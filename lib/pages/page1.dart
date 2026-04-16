
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_routes.dart';
import '../utils/responsive.dart';
import '../widgets/page_text_reveal.dart';
import 'page2.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final isWide = w >= 900;

          final responsive = ResponsiveSizes.fromWidth(w);

          final padH = w * 0.07;
          final padV = h * 0.03;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Background
              Image.asset(
                'assets/page 1/Frame 19 background.jpg',
                fit: BoxFit.cover,
              ),

              if (isWide)
                SafeArea(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Left text — behind
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          padH,
                          padV,
                          w * 0.40 + 16,
                          padV,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/logo atlas.png',
                              height: responsive.logoHeight,
                            ),
                            SizedBox(height: h * 0.03),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _TextBlock(
                                  responsive: responsive,
                                  maxWidth: double.infinity,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right image — on top
Positioned(
  right: 0,
  top: 0,
  bottom: 0,
  child: Image.asset(
    'assets/page 1/frame 19 image.png',
    fit: BoxFit.fitHeight,
    alignment: Alignment.centerRight,
  ),
),                    
],
                  ),
                )
              else
                // Narrow: book image faded behind text
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.35,
                        child: Image.asset(
                          'assets/page 1/frame 19 image.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padH,
                          vertical: padV,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/logo atlas.png',
                              height: responsive.logoHeight,
                            ),
                            SizedBox(height: h * 0.03),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: _TextBlock(
                                  responsive: responsive,
                                  maxWidth: w * 0.75,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TextBlock extends StatelessWidget {
  final ResponsiveSizes responsive;
  final double maxWidth;

  const _TextBlock({
    required this.responsive,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Heading
          PageTextReveal(
            delay: const Duration(milliseconds: 10),
            child: Text(
              'DÉcouvrez les Épisodes de\nla sÉrie «The Saharan Flora»'.toUpperCase(),
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'PlayfairDisplaySC',
                fontSize: responsive.headingSize,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.1,
                letterSpacing: 1.2,
              ),
            ),
          ),

          SizedBox(height: responsive.headingSize * 0.4),

          // Paragraph
          PageTextReveal(
            delay: const Duration(milliseconds: 140),
            child: Text(
              'Une exploration en épisodes du patrimoine végétal du Sahara marocain.',
              textAlign: TextAlign.left,
              textScaler: TextScaler.noScaling,
              style: GoogleFonts.nunito(
                fontSize: responsive.bodySize,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: responsive.headingSize * 0.6),

          // Button
          AtlasButton(
            label: 'Découvrir',
            onPressed: () {
              Navigator.push(context, atlasPageRoute(const Page2()));
            },
          ),
        ],
      ),
    );
  }
}

// ── Shared pill button ────────────────────────────────────────────────────────
class AtlasButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AtlasButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final r = ResponsiveSizes.fromWidth(w);

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SizedBox(
        width: r.buttonIconSize,
        height: r.buttonIconSize,
        child: SvgPicture.asset(
          'assets/icons/lucide_play.svg',
          width: r.buttonIconSize,
          height: r.buttonIconSize,
          fit: BoxFit.contain,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          placeholderBuilder: (_) => Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: r.buttonIconSize,
          ),
          errorBuilder: (_, __, ___) => Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: r.buttonIconSize,
          ),
        ),
      ),
      label: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: r.buttonTextSize,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.4,
        ),
      ),
      iconAlignment: IconAlignment.end,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF4996A),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: r.buttonPadH,
          vertical: r.buttonPadV,
        ),
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    );
  }
}

