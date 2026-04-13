class ResponsiveSizes {
  final double headingSize;
  final double headingSize3; // ← Page3 heading, smaller than headingSize
  final double bodySize;
  final double bodySize2;
  final double logoHeight;
  final double buttonTextSize;
  final double buttonIconSize;
  final double buttonPadH;
  final double buttonPadV;

  const ResponsiveSizes({
    required this.headingSize,
    required this.headingSize3,
    required this.bodySize,
    required this.bodySize2,
    required this.logoHeight,
    required this.buttonTextSize,
    required this.buttonIconSize,
    required this.buttonPadH,
    required this.buttonPadV,
  });

  factory ResponsiveSizes.fromWidth(double w) {
    const double baseWidth = 1440.0;
    final double scale = w / baseWidth;

    double scaled(double baseValue, double min, double max) {
      return (baseValue * scale).clamp(min, max).toDouble();
    }

    return ResponsiveSizes(
      headingSize:    scaled(46.0, 22.0, 60.0),
      headingSize3:   scaled(42.0, 18.0, 50.0), // ← smaller than headingSize
      bodySize:       scaled(28.0, 14.0, 34.0),
      bodySize2:      scaled(24.0, 12.0, 30.0),
      logoHeight:     scaled(92.0, 44.0, 122.0),
      buttonTextSize: scaled(24.0, 13.0, 30.0),
      buttonIconSize: scaled(20.0, 10.0, 26.0),
      buttonPadH:     scaled(34.0, 14.0, 46.0),
      buttonPadV:     scaled(18.0, 8.0, 22.0),
    );
  }
}
