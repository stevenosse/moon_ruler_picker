part of moon_ruler_picker;

const double rulerBetweenWidth = 0.071;

class RulerAlignedLongVerticalLine extends StatelessWidget {
  final double standardNumber;
  final int myNumber;
  final double alignX;
  final double height;
  final double width;
  final Color pickedColor;
  final Color color;
  final TextStyle? textStyle;

  double get _diff => (standardNumber - myNumber).abs();
  bool get _widgetStandard => (_diff < 0.5);

  RulerAlignedLongVerticalLine({
    super.key,
    required this.standardNumber,
    required double myNumber,
    required this.height,
    required this.width,
    required this.color,
    required this.pickedColor,
    this.textStyle,
  })  : myNumber = myNumber.floor(),
        alignX = (myNumber - standardNumber) * rulerBetweenWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment(alignX, 0.0),
          child: _widgetStandard
              ? RulerPickedLongVerticalLine(height: height, width: width * 1.2, color: pickedColor)
              : RulerLongVerticalLine(height: height, width: width, color: color),
        ),
        Align(
          alignment: Alignment(alignX, 1.0),
          child: Text(
            myNumber.toStringAsFixed(0),
            style: textStyle ??
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontFamily: 'Noto Sans CJK KR',
                  fontWeight: FontWeight.w500,
                  height: 0.17,
                ),
          ),
        ),
      ],
    );
  }
}
