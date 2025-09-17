import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/themes/app_theme.dart';
import '../../services/data/data_seeder.dart';
import '../../services/api/firestore_repository.dart';
import '../../services/real_time_bet_service.dart';
import '../../models/event/event_model.dart';
import '../../models/team/team_model.dart';

class DevToolsScreen extends StatefulWidget {
  const DevToolsScreen({super.key});

  @override
  State<DevToolsScreen> createState() => _DevToolsScreenState();
}

class _DevToolsScreenState extends State<DevToolsScreen> {
  final DataSeeder _seeder = DataSeeder();
  final FirestoreRepository _repository = FirestoreRepository();
  final RealTimeBetService _betService = RealTimeBetService();
  bool _isLoading = false;
  String _statusMessage = '';
  Map<String, int> _dataStats = {};
  List<EventModel> _availableEvents = [];
  List<TeamModel> _teams = [];
  Map<String, String?> _selectedWinners = {}; // Map eventId -> selected teamId

  @override
  void initState() {
    super.initState();
    _loadDataStats();
    _loadEventsAndTeams();
    _initializeBetService();
  }

  void _initializeBetService() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _betService.initialize(context, user.uid);
    }
  }

  @override
  void dispose() {
    _betService.dispose();
    super.dispose();
  }

  Future<void> _loadDataStats() async {
    final stats = await _seeder.getDataStats();
    setState(() {
      _dataStats = stats;
    });
  }

  Future<void> _loadEventsAndTeams() async {
    try {
      final events = await _repository.getAllEvents();
      final teams = await _repository.getAllTeams();
      setState(() {
        _availableEvents = events; // Show all events to see status changes
        _teams = teams;
      });
    } catch (e) {
      debugPrint('Error loading events and teams: $e');
    }
  }

  Future<void> _seedData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Seeding data...';
    });

    try {
      await _seeder.seedAllData();
      await _loadDataStats();
      setState(() {
        _statusMessage = '✅ Data seeded successfully!';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Error seeding data: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _clearData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Clearing data...';
    });

    try {
      await _seeder.clearAllData();
      await _loadDataStats();
      setState(() {
        _statusMessage = '✅ Data cleared successfully!';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Error clearing data: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _reseedData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Re-seeding data...';
    });

    try {
      await _seeder.seedAllData(forceReseed: true);
      await _loadDataStats();
      setState(() {
        _statusMessage = '✅ Data re-seeded successfully!';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Error re-seeding data: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _endEventWithSelectedWinner(EventModel event) async {
    final selectedTeamId = _selectedWinners[event.id];

    if (selectedTeamId == null) {
      setState(() {
        _statusMessage = '❌ Please select a winner team first';
      });
      return;
    }

    final winnerTeam = _teams.firstWhere(
      (team) => team.id == selectedTeamId,
      orElse:
          () => TeamModel(
            id: '',
            name: 'Unknown',
            followers: 0,
            wins: 0,
            isLive: false,
            description: '',
          ),
    );

    if (winnerTeam.id.isEmpty) {
      setState(() {
        _statusMessage = '❌ Selected team not found';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage =
          '🏆 Setting "${winnerTeam.name}" as winner for "${event.title}"...';
    });

    // Add a small delay for better UX
    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      // Complete the event with the selected winner
      await _repository.completeEvent(event.id, winnerTeam.id);

      // Give a short delay for the real-time listeners to catch the changes
      await Future.delayed(const Duration(milliseconds: 500));

      await _loadEventsAndTeams(); // Refresh the events list
      setState(() {
        _statusMessage =
            '🎉 Event "${event.title}" completed!\n'
            '🏆 Winner: ${winnerTeam.name}\n'
            '✅ Check your notifications for bet results!';
        _isLoading = false;
        _selectedWinners.remove(event.id); // Clear the selection
      });
    } catch (e) {
      setState(() {
        _statusMessage = '❌ Error completing event: $e';
        _isLoading = false;
      });
    }
  }

  void _setWinnerForEvent(String eventId, String? teamId) {
    setState(() {
      _selectedWinners[eventId] = teamId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Tools'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWarningCard(),
              const SizedBox(height: 24),
              _buildDataStatsCard(),
              const SizedBox(height: 24),
              _buildActionsCard(),
              const SizedBox(height: 24),
              _buildTestingCard(),
              const SizedBox(height: 24),
              if (_statusMessage.isNotEmpty) _buildStatusCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWarningCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.red.shade700, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Development Tools',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'These tools are for development only. Use with caution in production.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Database Statistics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_dataStats.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children:
                    _dataStats.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                entry.value.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _loadDataStats,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh Stats'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.build, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Data Management',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Seed Data Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _seedData,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Seed Initial Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Re-seed Data Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _reseedData,
                icon: const Icon(Icons.refresh),
                label: const Text('Re-seed Data (Force)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Clear Data Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _clearData,
                icon: const Icon(Icons.delete_forever),
                label: const Text('Clear All Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Seed Data includes:\n• 8 realistic sales teams\n• 6 sales competitions/events\n• 5 live streams with real descriptions',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.orange),
                const SizedBox(width: 8),
                const Text(
                  'Event Testing',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Create a test bet on any event (optional - for testing)\n'
              '2. Select a winning team from the dropdown\n'
              '3. Click "End Event" to set the selected team as winner\n'
              '4. Watch for win/loss notifications and check your credits',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            if (_availableEvents.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Text(
                  'No available events found. Please seed data first.',
                  style: TextStyle(color: Colors.orange),
                ),
              )
            else
              Column(
                children:
                    _availableEvents
                        .map((event) => _buildSimpleEventCard(event))
                        .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleEventCard(EventModel event) {
    final eventTeams =
        _teams.where((team) => event.teamIds.contains(team.id)).toList();
    final isCompleted = event.status == EventStatus.completed;
    final winnerTeam =
        event.winnerId != null
            ? _teams.firstWhere(
              (t) => t.id == event.winnerId,
              orElse:
                  () => TeamModel(
                    id: '',
                    name: 'Unknown',
                    followers: 0,
                    wins: 0,
                    isLive: false,
                    description: '',
                  ),
            )
            : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isCompleted ? Colors.green.shade300 : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isCompleted ? Colors.green.shade50 : Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            isCompleted && winnerTeam != null
                ? 'Winner: ${winnerTeam.name} 🏆'
                : 'Teams: ${eventTeams.map((t) => t.name).join(', ')}',
            style: TextStyle(
              fontSize: 14,
              color: isCompleted ? Colors.green.shade700 : Colors.grey,
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color:
                  isCompleted
                      ? Colors.green.withOpacity(0.1)
                      : event.status == EventStatus.live
                      ? Colors.red.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              event.status.name.toUpperCase(),
              style: TextStyle(
                color:
                    isCompleted
                        ? Colors.green
                        : event.status == EventStatus.live
                        ? Colors.red
                        : Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              if (!isCompleted) ...[
                // Winner Selection Dropdown
                SizedBox(
                  width: 140,
                  child: DropdownButtonFormField<String>(
                    value: _selectedWinners[event.id],
                    hint: const Text(
                      'Select Winner',
                      style: TextStyle(fontSize: 12),
                    ),
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items:
                        eventTeams.map((team) {
                          return DropdownMenuItem<String>(
                            value: team.id,
                            child: Text(
                              team.name,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                    onChanged:
                        _isLoading
                            ? null
                            : (value) => _setWinnerForEvent(event.id, value),
                  ),
                ),
                const SizedBox(width: 8),
              ],

              ElevatedButton.icon(
                onPressed:
                    isCompleted ||
                            _isLoading ||
                            (!isCompleted && _selectedWinners[event.id] == null)
                        ? null
                        : () => _endEventWithSelectedWinner(event),
                icon: Icon(
                  isCompleted ? Icons.check_circle : Icons.emoji_events,
                  size: 20,
                ),
                label: Text(isCompleted ? 'Completed' : 'End Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? Colors.green : Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(
                    _statusMessage.contains('✅')
                        ? Icons.check_circle
                        : Icons.error,
                    color:
                        _statusMessage.contains('✅')
                            ? Colors.green
                            : Colors.red,
                  ),
                const SizedBox(width: 8),
                const Text(
                  'Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(_statusMessage, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
