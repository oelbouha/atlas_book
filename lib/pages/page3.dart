import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/page_text_reveal.dart';
import '../app_routes.dart';
import '../utils/responsive.dart';

// ---------- Data ----------
class EpisodeItem {
  final String titleFr;
  final String titleAr;
  final String subtitle;
  final Color accentColor;
  final String videoAsset;
  final String thumbnailAsset;

  const EpisodeItem({
    required this.titleFr,
    required this.titleAr,
    required this.subtitle,
    required this.accentColor,
    required this.videoAsset,
    required this.thumbnailAsset,
  });
}

const String _bg = 'assets/page 3/Frame 19 background.jpg';
const String _logo = 'assets/logo atlas.png';
const String _polygonMarker = 'assets/polygon_1.svg';

const String _cover1 = 'assets/page 3/episodes/episode_1.png';
const String _video1 = 'assets/page 3/videos/tamarix.mp4';

const String _cover2 = 'assets/page 3/episodes/episode_2.png';
const String _video2 = 'assets/page 3/videos/kamcha.mp4';

const String _cover3 = 'assets/page 3/episodes/episode_3.png';
const String _video3 = 'assets/page 3/videos/talhsahraoui.mp4';

const String _cover4 = 'assets/page 3/episodes/episode_4.png';
const String _video4 = 'assets/page 3/videos/Kamounsoufi.mp4';

const String _cover5 = 'assets/page 3/episodes/episode_5.png';
const String _video5 = 'assets/page 3/videos/aagaya.mp4';

const String _cover6 = 'assets/page 3/episodes/episode_6.png';
const String _video6 = 'assets/page 3/videos/chihia.mp4';


final List<EpisodeItem> _episodes = [
  EpisodeItem(
    titleFr: 'Tarfa',
    titleAr: 'الكمشة',
    subtitle: 'Épisode 1',
    accentColor: const Color(0xFFF4996A),
    videoAsset: _video1,
    thumbnailAsset: _cover1,
  ),
  EpisodeItem(
    titleFr: 'Kamcha',
    titleAr: 'طرفة',
    subtitle: 'Épisode 2',
    accentColor: const Color(0xFFD4A96A),
    videoAsset: _video2,
    thumbnailAsset: _cover2,
  ),
  EpisodeItem(
    titleFr: 'Talh Sahraoui',
    titleAr: 'طلح صحراوي',
    subtitle: 'Épisode 3',
    accentColor: const Color(0xFF8FB89A),
    videoAsset: _video3,
    thumbnailAsset: _cover3,
  ),
  EpisodeItem(
    titleFr: 'Kammoun Soufi',
    titleAr: 'كمون صوفي',
    subtitle: 'Épisode 4',
    accentColor: const Color(0xFFC4A882),
    videoAsset: _video4,
    thumbnailAsset: _cover4,
  ),
  EpisodeItem(
    titleFr: 'Aagaya',
    titleAr: 'أكگاية',
    subtitle: 'Épisode 5',
    accentColor: const Color(0xFFB8956A),
    videoAsset: _video5,
    thumbnailAsset: _cover5,
  ),
  EpisodeItem(
    titleFr: 'Chihia',
    titleAr: 'شيهية',
    subtitle: 'Épisode 6',
    accentColor: const Color(0xFF9AA8B0),
    videoAsset: _video6,
    thumbnailAsset: _cover6,
  ),
];

// ---------- Page 3 ----------
class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  int _selectedIndex = 2;

  void _onEpisodeTap(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).push(
      atlasPageRoute(_FullscreenPlayer(episode: _episodes[index])),
    );
  }

  void _onEpisodeCentered(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_bg, fit: BoxFit.cover),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;
                final isWide = w >= 900;
                final logoHeight = ResponsiveSizes.fromWidth(w).logoHeight;

                if (isWide) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 32),
                                    ),
                                    const SizedBox(width: 24),
                                    Image.asset(_logo, height: logoHeight),
                                  ],
                                ),
                                SizedBox(height: h * 0.03),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: _LeftPanel(
                                      selectedIndex: _selectedIndex,
                                      isWide: true,
                                      w: w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: w * 0.04),
                        SizedBox(
                          width: (w * 0.38).clamp(280.0, 380.0),
                          child: _CardList(
                            episodes: _episodes,
                            selectedIndex: _selectedIndex,
                            onTap: _onEpisodeTap,
                            onCenterChanged: _onEpisodeCentered,
                            horizontal: false,
                            availableHeight: h,
                            showPolygon: true,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Narrow
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          w * 0.07, h * 0.03, w * 0.07, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 22),
                          ),
                          const SizedBox(width: 16),
                          Image.asset(_logo, height: logoHeight),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.04),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                      child: _LeftPanel(
                        selectedIndex: _selectedIndex,
                        isWide: false,
                        w: w,
                      ),
                    ),
                    SizedBox(height: h * 0.04),
                    Expanded(
                      child: _CardList(
                        episodes: _episodes,
                        selectedIndex: _selectedIndex,
                        onTap: _onEpisodeTap,
                        onCenterChanged: _onEpisodeCentered,
                        horizontal: true,
                        availableHeight: h * 0.5,
                        showPolygon: false,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Left text panel ----------
class _LeftPanel extends StatelessWidget {
  final int selectedIndex;
  final bool isWide;
  final double w;

  const _LeftPanel({
    required this.selectedIndex,
    required this.isWide,
    required this.w,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSizes.fromWidth(w);
    final headingSize = responsive.headingSize3;
    final labelSize = responsive.bodySize;
    final selected = _episodes[selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        PageTextReveal(
          delay: const Duration(milliseconds: 10),
          child: Text(
            'DÉcouvrez les Épisodes de\nla sÉrie «The Saharan Flora»'.toUpperCase(),
            style: TextStyle(
              fontFamily: 'PlayfairDisplaySC',
              fontSize: headingSize,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.1,
              letterSpacing: 1.1,
            ),
          ),
        ),
        SizedBox(height: labelSize * 1.5),
        PageTextReveal(
          delay: const Duration(milliseconds: 120),
          child: Text(
            'CHOISISSEZ UN ÉPISODE',
            style: GoogleFonts.nunito(
              fontSize: labelSize * 0.80,
              fontWeight: FontWeight.w800,
              color: Colors.white.withValues(alpha: 0.9),
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 2),
        PageTextReveal(
          delay: const Duration(milliseconds: 170),
          child: Text(
            '${selected.subtitle} - ${selected.titleFr}',
            style: GoogleFonts.nunito(
              fontSize: labelSize,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------- Card list ----------
class _CardList extends StatefulWidget {
  final List<EpisodeItem> episodes;
  final int selectedIndex;
  final void Function(int) onTap;
  final void Function(int)? onCenterChanged;
  final bool horizontal;
  final double availableHeight;
  final bool showPolygon;

  const _CardList({
    required this.episodes,
    required this.selectedIndex,
    required this.onTap,
    this.onCenterChanged,
    required this.horizontal,
    required this.availableHeight,
    required this.showPolygon,
  });

  @override
  State<_CardList> createState() => _CardListState();
}

class _CardListState extends State<_CardList> {
  ScrollController? _horizontalController;
  ScrollController? _verticalController;

  @override
  void dispose() {
    _horizontalController?.dispose();
    _verticalController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.horizontal) {
      // Keep 16:10 always — derive width from height
      final cardH = widget.availableHeight.clamp(150.0, 260.0);
      final cardW = cardH * (16 / 10);

      _horizontalController ??= ScrollController(
        initialScrollOffset: widget.selectedIndex * (cardW + 12.0),
      );

      return ListView.separated(
        controller: _horizontalController,
        scrollDirection: Axis.horizontal,
        // Extra padding so scaled card is never clipped at edges
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: widget.episodes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (ctx, i) => SizedBox(
          width: cardW,
          height: cardH,
          child: _EpisodeCard(
            episode: widget.episodes[i],
            isSelected: widget.selectedIndex == i,
            onTap: () => widget.onTap(i),
          ),
        ),
      );
    }

    // Vertical list
    return LayoutBuilder(
      builder: (context, constraints) {
        const indicatorWidth = 16.0;
        const indicatorGap = 16.0;
        const separatorHeight = 12.0;

        final cardWidth = widget.showPolygon
            ? constraints.maxWidth - indicatorWidth - indicatorGap
            : constraints.maxWidth;
        final cardHeight = cardWidth / (16 / 10);
        final itemExtent = cardHeight + separatorHeight;
        final listPadding =
            ((constraints.maxHeight - cardHeight) / 2).clamp(0.0, double.infinity);

        _verticalController ??= ScrollController(
          initialScrollOffset: widget.selectedIndex * itemExtent,
        );

        return Stack(
          clipBehavior: Clip.none, // ← allows scaled card to overflow stack
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: widget.showPolygon ? indicatorWidth + indicatorGap : 0,
              ),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  final centerOffset = notification.metrics.pixels +
                      (notification.metrics.viewportDimension / 2);
                  final rawIndex =
                      (centerOffset - listPadding - (cardHeight / 2)) /
                      itemExtent;
                  final centeredIndex =
                      rawIndex.round().clamp(0, widget.episodes.length - 1);
                  widget.onCenterChanged?.call(centeredIndex);
                  return false;
                },
                child: ListView.separated(
                  controller: _verticalController,
                  clipBehavior: Clip.none, // ← scaled card won't be clipped
                  padding: EdgeInsets.symmetric(vertical: listPadding),
                  itemCount: widget.episodes.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: separatorHeight),
                  itemBuilder: (ctx, i) => AspectRatio(
                    aspectRatio: 16 / 10,
                    child: _EpisodeCard(
                      episode: widget.episodes[i],
                      isSelected: widget.selectedIndex == i,
                      onTap: () => widget.onTap(i),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.showPolygon)
              Positioned(
                left: 0,
                top: (constraints.maxHeight - indicatorWidth) / 2,
                child: SvgPicture.asset(
                  _polygonMarker,
                  width: indicatorWidth,
                  height: indicatorWidth,
                  placeholderBuilder: (_) => const SizedBox(
                    width: indicatorWidth,
                    height: indicatorWidth,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ---------- Episode Card ----------
class _EpisodeCard extends StatefulWidget {
  final EpisodeItem episode;
  final bool isSelected;
  final VoidCallback onTap;

  const _EpisodeCard({
    required this.episode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<_EpisodeCard>
    with TickerProviderStateMixin {
  late final AnimationController _tapScale;
  late final AnimationController _selectionScale;

  static const double _radius = 16.0;

  @override
  void initState() {
    super.initState();
    _tapScale = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.96,
      upperBound: 1.0,
      value: 1.0,
    );
    _selectionScale = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.97,
      upperBound: 1.03,
      value: widget.isSelected ? 1.03 : 0.97,
    );
  }

  @override
  void didUpdateWidget(_EpisodeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _selectionScale.animateTo(
          1.03,
          curve: Curves.easeOutBack,
          duration: const Duration(milliseconds: 320),
        );
      } else {
        _selectionScale.animateTo(
          0.97,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 220),
        );
      }
    }
  }

  @override
  void dispose() {
    _tapScale.dispose();
    _selectionScale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _tapScale.reverse(),
      onTapUp: (_) => _tapScale.forward(),
      onTapCancel: () => _tapScale.forward(),
      child: AnimatedBuilder(
        animation: Listenable.merge([_tapScale, _selectionScale]),
        builder: (context, child) => Transform.scale(
          scale: _tapScale.value * _selectionScale.value,
          child: child,
        ),
        // No border, no shadow, no gradient — just the image with rounded corners
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: Image.asset(
            widget.episode.thumbnailAsset,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// ---------- Fullscreen Video Player ----------
class _FullscreenPlayer extends StatefulWidget {
  final EpisodeItem episode;
  const _FullscreenPlayer({required this.episode});

  @override
  State<_FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<_FullscreenPlayer> {
  VideoPlayerController? _ctrl;
  Future<void>? _initFuture;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _prepareAndPlay();
  }

  Future<void> _prepareAndPlay() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = widget.episode.videoAsset.split('/').last;
      final file = File('${tempDir.path}/$fileName');

      if (!await file.exists()) {
        final byteData = await rootBundle.load(widget.episode.videoAsset);
        await file.writeAsBytes(byteData.buffer.asUint8List());
      }

      _ctrl = VideoPlayerController.file(file)
        ..setLooping(true)
        ..setVolume(1.0);

      _initFuture = _ctrl!.initialize().then((_) {
        if (!mounted) return;
        _ctrl!.play();
        setState(() {});
      });
      setState(() {});
    } catch (e) {
      debugPrint('Error loading video: $e');
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _ctrl?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_ctrl == null) return;
    setState(() {
      _ctrl!.value.isPlaying ? _ctrl!.pause() : _ctrl!.play();
      _showControls = true;
    });
  }

  String _fmt(Duration d) {
    final s = d.isNegative ? Duration.zero : d;
    return '${s.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
        '${s.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _showControls = !_showControls),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    widget.episode.accentColor.withValues(alpha: 0.18),
                    Colors.black,
                  ],
                ),
              ),
            ),
            if (_initFuture != null)
              FutureBuilder<void>(
                future: _initFuture,
                builder: (_, snap) {
                  final ready =
                      snap.connectionState == ConnectionState.done &&
                      _ctrl != null &&
                      _ctrl!.value.isInitialized;
                  if (!ready) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                              color: widget.episode.accentColor),
                          const SizedBox(height: 16),
                          Text(
                            'Chargement…',
                            style: GoogleFonts.nunito(
                                color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _ctrl!.value.aspectRatio,
                      child: VideoPlayer(_ctrl!),
                    ),
                  );
                },
              )
            else
              const Center(
                  child: CircularProgressIndicator(color: Colors.white24)),
            IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.55),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.82),
                    ],
                    stops: const [0.0, 0.18, 0.70, 1.0],
                  ),
                ),
              ),
            ),
            if (_showControls)
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.arrow_back_ios_rounded,
                                color: Colors.white, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Image.asset(_logo, height: 24),
                          const Spacer(),
                          Text(
                            '${widget.episode.subtitle} – ${widget.episode.titleFr}',
                            style: GoogleFonts.nunito(
                                fontSize: 11, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (_ctrl != null && _ctrl!.value.isInitialized)
                      GestureDetector(
                        onTap: _togglePlay,
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: widget.episode.accentColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.episode.accentColor
                                    .withValues(alpha: 0.45),
                                blurRadius: 24,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: ValueListenableBuilder<VideoPlayerValue>(
                            valueListenable: _ctrl!,
                            builder: (_, v, __) => Icon(
                              v.isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    const Spacer(),
                    if (_ctrl != null && _ctrl!.value.isInitialized)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: ValueListenableBuilder<VideoPlayerValue>(
                          valueListenable: _ctrl!,
                          builder: (_, v, __) => Column(
                            children: [
                              Row(
                                children: [
                                  Text(_fmt(v.position),
                                      style: GoogleFonts.nunito(
                                          fontSize: 11,
                                          color: Colors.white70)),
                                  const Spacer(),
                                  Text(_fmt(v.duration),
                                      style: GoogleFonts.nunito(
                                          fontSize: 11,
                                          color: Colors.white70)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              VideoProgressIndicator(
                                _ctrl!,
                                allowScrubbing: true,
                                colors: VideoProgressColors(
                                  playedColor: widget.episode.accentColor,
                                  bufferedColor: Colors.white24,
                                  backgroundColor: Colors.white12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
