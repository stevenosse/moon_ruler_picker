

// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
//
// import 'element/ruler_vertical_line.dart';

part of ruler_picker_lib;


class RulerPicker extends StatefulWidget {

  double selectedNumber;
  late Function(double) callback;
  int? maxNumber;
  int? minNumber;

  late double height;
  late double borderWidth;
  late Color pickedColor;
  late Color color;

  RulerPicker({super.key, required this.callback, required this.selectedNumber, this.maxNumber, this.minNumber, required this.height, required this.borderWidth, required this.pickedColor, required this.color});

  @override
  State<StatefulWidget> createState() => _RulerPickerState(callback: callback, selectedNumber: selectedNumber, maxNumber: maxNumber, minNumber: minNumber, height: height, width: borderWidth, pickedColor: pickedColor, color: color);
}

class _RulerPickerState extends State<RulerPicker> {

  Timer? timer;
  double selectedNumber;
  late int prev = 0;
  late Function(double) callback;
  int? maxNumber;
  int? minNumber;

  late double height;
  late double width;
  late Color pickedColor;
  late Color color;

  _RulerPickerState({required this.callback, required this.selectedNumber, this.maxNumber, this.minNumber, required this.height, required this.width, required this.pickedColor, required this.color})
    :prev = selectedNumber.floor();

  @override
  void didUpdateWidget(covariant RulerPicker oldWidget) {
    selectedNumber = widget.selectedNumber;
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> rulerLines = [];

    for (int index = 0; index < 20; index++) {
      if (maxNumber == null) {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: width, height: height, color: color, pickedColor: pickedColor));
      } else if( (selectedNumber + index) >= maxNumber! ) {
        double maxDouble = maxNumber!.toDouble();
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: maxDouble, width: width, height: height, color: color, pickedColor: pickedColor));
        break;
      } else {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: width, height: height, color: color, pickedColor: pickedColor));
      }
    }

    for (int index = -1; index > -20; index--) {
      if (minNumber == null) {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: width, height: height, color: color, pickedColor: pickedColor));
      } else if( (selectedNumber + index) < minNumber! ) {
        double minDouble = minNumber!.toDouble();
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: minDouble, width: width, height: height, color: color, pickedColor: pickedColor));
        break;
      } else {
        rulerLines.add(_RulerVerticalLine(standardNumber: selectedNumber, myNumber: selectedNumber + index, width: width, height: height, color: color, pickedColor: pickedColor));
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragDown: (details) {
        timer?.cancel();
        timer = null;
      },
      onHorizontalDragEnd: (details) {
        shootDrag(details);
      },
      onHorizontalDragUpdate: (details) {
        updateDrag(details);
      },
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: rulerLines
        ),
      ),
    );
  }

  void updateDrag(details) {
    setState(() {
      double delta = details.delta.dx;

      _moveRulerPicker(delta);
      _limitMaxNumber();
      _limitMinNumber();
    });

    _vibratingOnIntegerValue();

    callback(selectedNumber);
  }

  void shootDrag(details) {

    double velocity = (details.primaryVelocity ?? 0) * 0.0002;

    timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      velocity = velocity * 0.99;
      setState(() {
        selectedNumber -= (velocity);
        _limitMaxNumber();
        _limitMinNumber();

        callback(selectedNumber);
      });

      _vibratingOnIntegerValue();

      if (velocity.abs() < 0.1) {
        this.timer?.cancel();
        this.timer = null;
      }
    });
  }


  void _moveRulerPicker(double delta) {
    if (delta > 5) {
      selectedNumber -= 5 * 0.2;
    } else if (delta < -5) {
      selectedNumber -= -5 * 0.2;
    } else {
      selectedNumber -= delta * 0.2;
    }
  }

  void _limitMaxNumber() {
    if (maxNumber == null) {

    } else if( (selectedNumber) >= maxNumber! ) {
      selectedNumber =  maxNumber!.toDouble();
    }
  }

  void _limitMinNumber() {
    if (minNumber == null) {

    } else if( (selectedNumber) <= minNumber! ) {
      selectedNumber =  minNumber!.toDouble();
    }
  }

  void _vibratingOnIntegerValue() {
    if ((selectedNumber.floor() - prev).abs() >= 0.5) {
      HapticFeedback.selectionClick();
      prev = selectedNumber.floor();
    }
  }
}

