import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../../core/themes/app_theme.dart';
import '../../models/stream/stream_model.dart';
import '../../blocs/auth/auth_bloc.dart';

class StreamViewerScreen extends StatefulWidget {
  final StreamModel stream;

  const StreamViewerScreen({
    super.key,
    required this.stream,
  });

  @override
  State<StreamViewerScreen> createState() => _StreamViewerScreenState();
}

class _StreamViewerScreenState extends State<StreamViewerScreen> {
  VideoPlayerController? _videoController;
  final ScrollController _chatScrollController = ScrollController();
  final TextEditingController _chatMessageController = TextEditingController();
  final FocusNode _chatFocusNode = FocusNode();
  
  bool _isFullScreen = false;
  bool _showChatOverlay = true;
  bool _isVideoReady = false;
  List<ChatMessage> _chatMessages = [];
  int _viewerCount = 0;
  
  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _loadChatMessages();
    _simulateViewerCount();
    _listenForNewMessages();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chatScrollController.dispose();
    _chatMessageController.dispose();
    _chatFocusNode.dispose();
    super.dispose();
  }

  void _initializeVideo() {
    // For demo purposes, use a sample video URL or asset
    // In production, this would be the actual stream URL
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4'),
    );
    
    _videoController!.initialize().then((_) {
      setState(() {
        _isVideoReady = true;
      });
      _videoController!.play();
      _videoController!.setLooping(true);
    }).catchError((error) {
      // Handle video loading error - show placeholder
      setState(() {
        _isVideoReady = false;
      });
    });
  }

  void _loadChatMessages() {
    // Simulate loading existing messages
    setState(() {
      _chatMessages = [
        ChatMessage(
          id: '1',
          userId: 'user1',
          username: 'TeamAlphaFan',
          message: 'Go Team Alpha! 🚀',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        ChatMessage(
          id: '2',
          userId: 'user2',
          username: 'BetaMaster',
          message: 'Beta squad is crushing it!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
        ),
        ChatMessage(
          id: '3',
          userId: 'user3',
          username: 'StreamViewer',
          message: 'This is so intense! Who do you think will win?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        ),
      ];
    });
  }

  void _simulateViewerCount() {
    // Simulate real-time viewer count updates
    setState(() {
      _viewerCount = 2547 + (DateTime.now().millisecond % 100);
    });
    
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) _simulateViewerCount();
    });
  }

  void _listenForNewMessages() {
    // Simulate new messages coming in
    const messages = [
      'Amazing play by Alpha!',
      'Beta team is on fire 🔥',
      'This stream quality is perfect',
      'Who else has bets on this?',
      'GO GO GO!',
      'Incredible technique',
      'Best stream ever!',
    ];
    
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        final randomMessage = messages[DateTime.now().millisecond % messages.length];
        final randomUser = 'Viewer${DateTime.now().millisecond % 1000}';
        
        _addNewMessage(ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: 'random',
          username: randomUser,
          message: randomMessage,
          timestamp: DateTime.now(),
        ));
        
        _listenForNewMessages();
      }
    });
  }

  void _addNewMessage(ChatMessage message) {
    setState(() {
      _chatMessages.add(message);
      if (_chatMessages.length > 100) {
        _chatMessages.removeAt(0); // Keep only last 100 messages
      }
    });
    
    // Auto-scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_chatScrollController.hasClients) {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Video Player
            _buildVideoPlayer(),
            
            // Top overlay with stream info
            if (!_isFullScreen) _buildTopOverlay(),
            
            // Chat overlay
            if (_showChatOverlay && !_isFullScreen) _buildChatOverlay(),
            
            // Controls overlay
            _buildControlsOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_videoController == null || !_isVideoReady) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.live_tv,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.stream.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.stream.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _toggleFullScreen,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: VideoPlayer(_videoController!),
      ),
    );
  }

  Widget _buildTopOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stream.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Streamer: ${widget.stream.streamerName}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildViewerCount(),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor,
                    borderRadius: BorderRadius.circular(12),
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
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Sales Challenge Final',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewerCount() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.visibility, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            _formatViewerCount(_viewerCount),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatOverlay() {
    return Positioned(
      right: 0,
      top: 120,
      bottom: 100,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Chat header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.chat, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Live Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showChatOverlay = false),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
            
            // Messages list
            Expanded(
              child: ListView.builder(
                controller: _chatScrollController,
                padding: const EdgeInsets.all(8),
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  return _buildChatMessage(_chatMessages[index]);
                },
              ),
            ),
            
            // Message input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage(ChatMessage message) {
    final isOwnMessage = message.userId == 'current_user'; // Replace with actual user ID
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.username,
            style: TextStyle(
              color: isOwnMessage ? AppTheme.primaryColor : Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            message.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatMessageController,
              focusNode: _chatFocusNode,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              maxLines: 1,
              onSubmitted: _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _sendMessage(_chatMessageController.text),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            if (!_showChatOverlay)
              IconButton(
                onPressed: () => setState(() => _showChatOverlay = true),
                icon: const Icon(Icons.chat, color: Colors.white),
              ),
            const Spacer(),
            IconButton(
              onPressed: _shareStream,
              icon: const Icon(Icons.share, color: Colors.white),
            ),
            IconButton(
              onPressed: _toggleFullScreen,
              icon: Icon(
                _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) return;
    
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user', // Replace with actual user ID
      username: authState.user.displayName ?? 'You',
      message: text.trim(),
      timestamp: DateTime.now(),
    );
    
    _addNewMessage(message);
    _chatMessageController.clear();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
    
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  void _shareStream() {
    // Implementation for sharing stream
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality coming soon!'),
        backgroundColor: AppTheme.primaryColor,
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

class ChatMessage {
  final String id;
  final String userId;
  final String username;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.userId,
    required this.username,
    required this.message,
    required this.timestamp,
  });
}