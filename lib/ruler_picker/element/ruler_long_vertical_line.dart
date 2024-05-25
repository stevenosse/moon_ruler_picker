part of moon_ruler_picker;

class RulerLongVerticalLine extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const RulerLongVerticalLine({
    super.key,
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11),
      width: width,
      height: height,
      color: color,
    );
  }
}
