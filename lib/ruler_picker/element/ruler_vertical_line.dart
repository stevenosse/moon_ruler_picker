part of moon_ruler_picker;

class RulerVerticalLine extends StatelessWidget {
  final double standardNumber;
  final double myNumber;

  final double height;
  final double width;
  final Color pickedColor;
  final Color color;

  final TextStyle? textStyle;

  const RulerVerticalLine({
    super.key,
    required this.standardNumber,
    required this.myNumber,
    required this.width,
    required this.height,
    required this.color,
    required this.pickedColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (myNumber.floor() % 5 == 0) {
          return RulerAlignedLongVerticalLine(
            standardNumber: standardNumber,
            myNumber: myNumber,
            width: width,
            height: constraints.maxHeight * 0.6,
            color: color,
            pickedColor: pickedColor,
            textStyle: textStyle,
          );
        } else {
          return RulerAlignedShortVerticalLine(
            standardNumber: standardNumber,
            myNumber: myNumber,
            width: width,
            height: constraints.maxHeight * 0.34,
            color: color,
            pickedColor: pickedColor,
          );
        }
      },
    );
  }
}
