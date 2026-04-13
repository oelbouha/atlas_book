import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'pages/page1.dart';

// All background images to preload so page transitions are instant
const List<String> _allBackgrounds = [
  'assets/page 1/Frame 19 background.jpg',
  'assets/page 2/Frame 19 background.jpg',
  'assets/page 3/Frame 19 background.jpg',
  'assets/page 1/frame 19 image.png',
  'assets/logo atlas.png',
  'assets/page 3/Frame 10.jpg',
  'assets/page 3/episodes/episode_1.png',
  'assets/page 3/episodes/episode_2.png',
  'assets/page 3/episodes/episode_3.png',
  'assets/page 3/episodes/episode_4.png',
  'assets/page 3/episodes/episode_5.png',
  'assets/page 3/episodes/episode_6.png',
];

// All videos to warm up at startup by copying from bundled assets to temp dir.
const List<String> _allVideos = ['assets/EP 3 TAMARIX subs def.mp4'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  VideoPlayerMediaKit.ensureInitialized(
    android: true,
    windows: true,
    linux: true,
  );
  runApp(const AtlasBookApp());
}

class AtlasBookApp extends StatelessWidget {
  const AtlasBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlas Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF4996A)),
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const _PreloadWrapper(child: Page1()),
    );
  }
}

/// Preloads all images once so every page transition is instant.
class _PreloadWrapper extends StatefulWidget {
  final Widget child;
  const _PreloadWrapper({required this.child});

  @override
  State<_PreloadWrapper> createState() => _PreloadWrapperState();
}

class _PreloadWrapperState extends State<_PreloadWrapper> with SingleTickerProviderStateMixin {
  bool _didPreload = false;
  bool _isLoading = true;

  late AnimationController _animeCtrl;
  late Animation<double> _scaleAnime;

  @override
  void initState() {
    super.initState();
    _animeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _scaleAnime = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animeCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animeCtrl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPreload) return;
    _didPreload = true;
    _preloadAssets();
  }

  Future<void> _preloadAssets() async {
    final preloadWork = () async {
      // Precache images used across pages so route transitions feel instant.
      for (final path in _allBackgrounds) {
        if (!mounted) return;
        await precacheImage(AssetImage(path), context);
      }

      // Warm up video files once at app startup for smoother first playback.
      try {
        final tempDir = await getTemporaryDirectory();
        for (final assetPath in _allVideos) {
          final fileName = assetPath.split('/').last;
          final file = File('${tempDir.path}/$fileName');
          if (await file.exists()) continue;

          final byteData = await rootBundle.load(assetPath);
          await file.writeAsBytes(byteData.buffer.asUint8List());
        }
      } catch (e) {
        debugPrint('Global video warmup failed: \$e');
      }
    }();

    try {
      // User requested exactly 5 seconds for the loading screen.
      await Future.wait([
        preloadWork,
        Future.delayed(const Duration(seconds: 5)),
      ]).timeout(const Duration(seconds: 5));
    } catch (_) {
      // Timeout ignored, let the background tasks continue if they are slow.
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: _isLoading
          ? Scaffold(
              key: const ValueKey('splash'),
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/page 1/Frame 19 background.jpg',
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: ScaleTransition(
                      scale: _scaleAnime,
                      child: Image.asset(
                        'assets/logo atlas.png',
                        width: 220,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : KeyedSubtree(
              key: const ValueKey('app'),
              child: widget.child,
            ),
    );
  }
}
