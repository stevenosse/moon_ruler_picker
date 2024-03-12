

part of ruler_picker_lib;



class _RulerVerticalLine extends StatelessWidget {

  late double standardNumber;
  late double myNumber;

  late double height;
  late double width;
  late Color pickedColor;
  late Color color;

  _RulerVerticalLine({required this.standardNumber, required this.myNumber, required this.width, required this.height, required this.color, required this.pickedColor});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        if (myNumber.floor() % 5 == 0) {
          return _RulerAlignedLongVerticalLine(standardNumber: standardNumber, myNumber: myNumber, width: width, height: constraints.maxHeight * 0.6, color: color, pickedColor: pickedColor, );
        } else {
          return _RulerAlignedShortVerticalLine(standardNumber: standardNumber, myNumber: myNumber, width: width, height: constraints.maxHeight * 0.34, color: color, pickedColor: pickedColor,  );
        }

      }
    );
  }
}
