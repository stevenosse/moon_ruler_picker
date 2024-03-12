


import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';



class RulerVerticalLine extends StatelessWidget {

  late double standardNumber;
  late double myNumber;

  late double height;
  late double width;
  late Color pickedColor;
  late Color color;

  RulerVerticalLine({required this.standardNumber, required this.myNumber, required this.width, required this.height, required this.color, required this.pickedColor});

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        if (myNumber.floor() % 5 == 0) {
          return RulerAlignedLongVerticalLine(standardNumber: standardNumber, myNumber: myNumber, width: width, height: constraints.maxHeight * 0.6, color: color, pickedColor: pickedColor, );
        } else {
          return RulerAlignedShortVerticalLine(standardNumber: standardNumber, myNumber: myNumber, width: width, height: constraints.maxHeight * 0.34, color: color, pickedColor: pickedColor,  );
        }

      }
    );
  }
}


class RulerAlignedLongVerticalLine extends StatelessWidget {

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

  RulerAlignedLongVerticalLine({required this.standardNumber, required double myNumber, required this.height, required this.width, required this.color, required this.pickedColor}){
    this.myNumber = myNumber.floor();
    alignX = (this.myNumber - standardNumber) * rulerBetweenWidth;
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [

          Align(
              alignment: Alignment(alignX, 0.0),
              child: _widgetStandard ? RulerPickedLongVerticalLine(height: height, width: width * 1.2, color: pickedColor) : RulerLongVerticalLine(height: height, width: width, color: color)
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

class RulerAlignedShortVerticalLine extends StatelessWidget {

  final double rulerBetweenWidth = 0.071;
  late double standardNumber;
  late int myNumber;
  late double alignX;

  late double height;
  late double width;
  late Color pickedColor;
  late Color color;



  double get _diff => (standardNumber - myNumber);
  bool get _widgetStandard => (
      (myNumber % 5 == 1 && standardNumber - myNumber < 0) ? (_diff < 0.5 && _diff >= -0.5 ) : (_diff <= 0.5 && _diff > -0.5 )
  );

  RulerAlignedShortVerticalLine({required this.standardNumber, required double myNumber, required this.width, required this.height, required this.color, required this.pickedColor}){
    this.myNumber = myNumber.floor();
    alignX = (this.myNumber - standardNumber) * rulerBetweenWidth;
  }

  @override
  Widget build(BuildContext context) {

    return Align(
        alignment: Alignment(alignX, 0.0),
        child: _widgetStandard ? RulerPickedShortVerticalLine(width: width * 1.2, height: height * 1.46, color: pickedColor,) : RulerShortVerticalLine(width: width, height: height, color: color,)
    );
  }
}


class RulerShortVerticalLine extends StatelessWidget {

  late double height;
  late double width;
  late Color color;

  RulerShortVerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11),
      width: width,
      height: height,
      color: color // const Color(0XFF0180BE).withOpacity(0.3),
    );
  }
}

class RulerPickedShortVerticalLine extends StatelessWidget {

  late double height;
  late double width;
  late Color color;

  RulerPickedShortVerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 11),
          width: width,
          height: height,
          color: color // const Color(0XFF0180BE)
        ),

      ],
    );
  }
}


class RulerLongVerticalLine extends StatelessWidget {

  late double height;
  late double width;
  late Color color;

  RulerLongVerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11),
      width: width,
      height: height,
      color: color
    );
  }
}

class RulerPickedLongVerticalLine extends StatelessWidget {

  late double height;
  late double width;
  late Color color;

  RulerPickedLongVerticalLine({required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.topCenter,
      children: [


        Container(
          margin: const EdgeInsets.symmetric(horizontal: 11),
          width: width,
          height: height,
          color: color
        ),
      ],
    );
  }
}