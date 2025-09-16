import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../../models/stream/stream_model.dart';
import '../stream/stream_viewer_screen.dart';
import '../../services/api/firestore_repository.dart';

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({super.key});

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  final FirestoreRepository _repository = FirestoreRepository();
  List<StreamModel> _streams = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStreams();
  }

  Future<void> _loadStreams() async {
    try {
      final liveStreams = await _repository.getLiveStreams();
      
      if (mounted) {
        setState(() {
          _streams = liveStreams;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading streams: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Streams'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStreams,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_streams.isNotEmpty) ...[
                      FadeInDown(child: _buildFeaturedStream(context)),
                      const SizedBox(height: AppConstants.largeSpacing),
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.mediumSpacing,
                      ),
                      child: FadeInLeft(
                        child: Text(
                          _streams.isEmpty ? 'No Live Streams' : 'All Live Streams',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.mediumSpacing),
                    if (_streams.isNotEmpty)
                      FadeInUp(child: _buildStreamsList())
                    else
                      const Padding(
                        padding: EdgeInsets.all(AppConstants.largeSpacing),
                        child: Center(
                          child: Text(
                            'No live streams available at the moment.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildFeaturedStream(BuildContext context) {
    final featuredStream = _streams.first;

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamViewerScreen(stream: featuredStream),
            ),
          ),
      child: Container(
        width: double.infinity,
        height: 250,
        margin: const EdgeInsets.all(AppConstants.mediumSpacing),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: AppConstants.mediumSpacing),
                  Text(
                    featuredStream.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    featuredStream.description,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.errorColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, color: Colors.white, size: 8),
                    SizedBox(width: 4),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.visibility, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      _formatViewerCount(featuredStream.viewerCount),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamsList() {
    final allStreams = _streams;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumSpacing,
      ),
      itemCount: allStreams.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildStreamItem(allStreams[index], index, context),
        );
      },
    );
  }

  Widget _buildStreamItem(StreamModel stream, int index, BuildContext context) {
    final isLive = stream.isLive;

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamViewerScreen(stream: stream),
            ),
          ),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                gradient:
                    isLive
                        ? AppTheme.primaryGradient
                        : LinearGradient(
                          colors: [Colors.grey[400]!, Colors.grey[600]!],
                        ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConstants.mediumRadius),
                  bottomLeft: Radius.circular(AppConstants.mediumRadius),
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  if (isLive)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stream.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isLive ? 'Live Now' : 'Offline',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatViewerCount(stream.viewerCount),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: AppConstants.mediumSpacing),
                        if (isLive) ...[
                          const Icon(
                            Icons.favorite,
                            size: 16,
                            color: AppTheme.errorColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(index + 1) * 45}',
                            style: const TextStyle(
                              color: AppTheme.errorColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppConstants.mediumSpacing),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isLive ? AppTheme.primaryColor : Colors.grey[400],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  isLive ? 'Watch' : 'Offline',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatViewerCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
