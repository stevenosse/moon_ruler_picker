part of moon_ruler_picker;

class RulerAlignedShortVerticalLine extends StatelessWidget {
  final double standardNumber;

  final double alignX;

  final double height;
  final double width;
  final Color pickedColor;
  final Color color;

  double get _diff => (standardNumber - myNumber);
  bool get _widgetStandard => ((myNumber % 5 == 1 && standardNumber - myNumber < 0)
      ? (_diff < 0.5 && _diff >= -0.5)
      : (_diff <= 0.5 && _diff > -0.5));

  final int myNumber;

  RulerAlignedShortVerticalLine({
    super.key,
    required this.standardNumber,
    required double myNumber,
    required this.width,
    required this.height,
    required this.color,
    required this.pickedColor,
  })  : myNumber = myNumber.floor(),
        alignX = (myNumber - standardNumber) * rulerBetweenWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(alignX, 0.0),
        child: _widgetStandard
            ? RulerPickedShortVerticalLine(
                width: width * 1.2,
                height: height * 1.46,
                color: pickedColor,
              )
            : RulerShortVerticalLine(
                width: width,
                height: height,
                color: color,
              ));
  }
}
