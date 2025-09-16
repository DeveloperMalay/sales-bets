import 'package:flutter/material.dart';
import '../../core/themes/app_theme.dart';
import '../../services/data/data_seeder.dart';

class DevToolsScreen extends StatefulWidget {
  const DevToolsScreen({super.key});

  @override
  State<DevToolsScreen> createState() => _DevToolsScreenState();
}

class _DevToolsScreenState extends State<DevToolsScreen> {
  final DataSeeder _seeder = DataSeeder();
  bool _isLoading = false;
  String _statusMessage = '';
  Map<String, int> _dataStats = {};

  @override
  void initState() {
    super.initState();
    _loadDataStats();
  }

  Future<void> _loadDataStats() async {
    final stats = await _seeder.getDataStats();
    setState(() {
      _dataStats = stats;
    });
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
