

part of ruler_picker_lib;



class _RulerAlignedLongVerticalLine extends StatelessWidget {

  final double rulerBetweenWidth = 0.071;
  late double standardNumber;
  late int myNumber;
  late double alignX;

  late double height;
  late double width;
  late Color pickedColor;
  late Color color;

  double get _diff => (standardNumber - myNumber).abs();
  bool get _widgetStandard => ( _diff < 0.5 );

  _RulerAlignedLongVerticalLine({required this.standardNumber, required double myNumber, required this.height, required this.width, required this.color, required this.pickedColor}){
    this.myNumber = myNumber.floor();
    alignX = (this.myNumber - standardNumber) * rulerBetweenWidth;
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [

          Align(
              alignment: Alignment(alignX, 0.0),
              child: _widgetStandard ? _RulerPickedLongVerticalLine(height: height, width: width * 1.2, color: pickedColor) : _RulerLongVerticalLine(height: height, width: width, color: color)
          ),

          Align(
            alignment: Alignment(alignX, 1.0),
            child: Text(
              myNumber.toStringAsFixed(0),
              style: const TextStyle(
                color: Color(0xFF0180BE),
                fontSize: 12,
                fontFamily: 'Noto Sans CJK KR',
                fontWeight: FontWeight.w500,
                height: 0.17,
              ),
            ),
          ),

        ]
    );
  }
}