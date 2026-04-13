import 'package:flutter/material.dart';
import '../app_routes.dart';
import '../widgets/page_text_reveal.dart';
import 'page1.dart' show AtlasButton;
import 'page3.dart';
import '../utils/responsive.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          final responsive = ResponsiveSizes.fromWidth(w);

          return Stack(
            fit: StackFit.expand,
            children: [
              // Background
              Image.asset(
                'assets/page 2/Frame 19 background.jpg',
                fit: BoxFit.cover,
              ),

              // Content
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: w * 0.07,
		    right: w * 0.07,
                    top: h * 0.03,
		   bottom: 0
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/logo atlas.png',
                          height: responsive.logoHeight,
                        ),
                      ),

                      // Scrollable centered body
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: h * 0.82),
                            child: Center(
                              child: SizedBox(
                                width: w * 0.84,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: h * 0.04),

                                    // Heading
                                    PageTextReveal(
                                      delay: const Duration(milliseconds: 10),
                                      child: Text(
                                        'À PROPOS DE LA SÉRIE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'PlayfairDisplaySC',
                                          fontSize: responsive.headingSize,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          letterSpacing: 1.1,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: h * 0.03),

                                    // Body paragraph
                                    PageTextReveal(
                                      delay: const Duration(milliseconds: 140),
                                      child: Text(
                                        'AtlasBook est une initiative scientifique et territoriale qui met en lumière la richesse exceptionnelle de la flore du Sahara marocain. À travers un travail de terrain approfondi mené dans les régions de Laâyoune-Sakia El Hamra et de Dakhla-Oued Eddahab, le projet documente près de 480 espèces végétales, ainsi que leurs usages par les populations locales. À la croisée de la science et des savoirs traditionnels, AtlasBook valorise les plantes sahariennes pour leur rôle essentiel dans les écosystèmes et pour leur contribution à des usages agricoles, alimentaires et médicinaux. Cette série vidéo immersive intitulée "Saharan Flora" invite à découvrir 6 plantes emblématiques, à travers des récits qui relient biodiversité, innovation et transmission des savoirs.',
                                        textAlign: TextAlign.center,
                                        textScaler: TextScaler.noScaling,
                                        style: TextStyle(
                                          fontFamily: 'GilmerMedium',
                                          fontSize: responsive.bodySize2,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xE0FFFFFF),
                                          height: 1.3,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: h * 0.04),

                                    // Button
                                    AtlasButton(
                                      label: 'Regarder',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          atlasPageRoute(const Page3()),
                                        );
                                      },
                                    ),

                                    SizedBox(height: h * 0.04),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
