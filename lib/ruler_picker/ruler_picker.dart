part of moon_ruler_picker;

class RulerPicker extends StatefulWidget {
  final double selectedNumber;
  final Function(double) callbackDouble;
  final Function(int)? callbackInt;
  final int? maxNumber;
  final int? minNumber;

  final double resistance;
  final double acceleration;

  final double width;
  final double height;
  final double borderWidth;
  final Color pickedBarColor;
  final Color barColor;
  final TextStyle? titleStyle;

  const RulerPicker({
    super.key,
    required this.callbackDouble,
    this.callbackInt,
    required this.selectedNumber,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.pickedBarColor,
    required this.barColor,
    this.resistance = 1,
    this.acceleration = 1,
    this.maxNumber,
    this.minNumber,
    this.titleStyle,
  });

  @override
  State<StatefulWidget> createState() => RulerPickerState();
}

class RulerPickerState extends State<RulerPicker> {
  double get resistance => 0.99 / widget.resistance;
  double get acceleration => 0.0002 * widget.acceleration;

  Timer? timer;
  late double selectedValue;
  late int _previousSelectedValue;

  int? get maxNumber => widget.maxNumber;
  int? get minNumber => widget.minNumber;
  double get height => widget.height;
  double get borderWidth => widget.borderWidth;
  Color get pickedBarColor => widget.pickedBarColor;
  Color get barColor => widget.barColor;

  @override
  initState() {
    selectedValue = widget.selectedNumber;
    _previousSelectedValue = selectedValue.floor();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RulerPicker oldWidget) {
    selectedValue = widget.selectedNumber;
    _previousSelectedValue = selectedValue.floor();

    _limitMaxNumber();
    _limitMinNumber();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rulerLines = [];

    for (int index = 0; index < 20; index++) {
      if (maxNumber == null) {
        rulerLines.add(
          RulerVerticalLine(
            standardNumber: selectedValue,
            myNumber: selectedValue + index,
            width: borderWidth,
            height: height,
            color: barColor,
            pickedColor: pickedBarColor,
          ),
        );
      } else if ((selectedValue + index) >= maxNumber!) {
        double maxDouble = maxNumber!.toDouble();
        rulerLines.add(
          RulerVerticalLine(
            standardNumber: selectedValue,
            myNumber: maxDouble,
            width: borderWidth,
            height: height,
            color: barColor,
            pickedColor: pickedBarColor,
          ),
        );
        break;
      } else {
        rulerLines.add(
          RulerVerticalLine(
            standardNumber: selectedValue,
            myNumber: selectedValue + index,
            width: borderWidth,
            height: height,
            color: barColor,
            pickedColor: pickedBarColor,
          ),
        );
      }
    }

    for (int index = -1; index > -20; index--) {
      if (minNumber == null) {
        rulerLines.add(
          RulerVerticalLine(
            standardNumber: selectedValue,
            myNumber: selectedValue + index,
            width: borderWidth,
            height: height,
            color: barColor,
            pickedColor: pickedBarColor,
          ),
        );
      } else if ((selectedValue + index) < minNumber!) {
        double minDouble = minNumber!.toDouble();
        rulerLines.add(
          RulerVerticalLine(
            standardNumber: selectedValue,
            myNumber: minDouble,
            width: borderWidth,
            height: height,
            color: barColor,
            pickedColor: pickedBarColor,
          ),
        );
        break;
      } else {
        rulerLines.add(
          RulerVerticalLine(
            standardNumber: selectedValue,
            myNumber: selectedValue + index,
            width: borderWidth,
            height: height,
            color: barColor,
            pickedColor: pickedBarColor,
          ),
        );
      }
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragDown: (details) {
          timer?.cancel();
          timer = null;
        },
        onHorizontalDragEnd: (details) => shootDrag(details),
        onHorizontalDragUpdate: (details) => updateDrag(details),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: rulerLines,
          ),
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

    widget.callbackDouble(selectedValue);
    widget.callbackInt == null ? null : widget.callbackInt!(selectedValue.floor());
  }

  void shootDrag(details) {
    double velocity = (details.primaryVelocity ?? 0) * acceleration;

    timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      velocity = velocity * resistance;
      setState(() {
        selectedValue -= (velocity);
        _limitMaxNumber();
        _limitMinNumber();

        widget.callbackDouble(selectedValue);
        widget.callbackInt == null ? null : widget.callbackInt!(selectedValue.floor());
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
      selectedValue -= 5 * 0.2;
    } else if (delta < -5) {
      selectedValue -= -5 * 0.2;
    } else {
      selectedValue -= delta * 0.2;
    }
  }

  void _limitMaxNumber() {
    if (maxNumber == null) {
    } else if ((selectedValue) >= maxNumber!) {
      selectedValue = maxNumber!.toDouble();
    }
  }

  void _limitMinNumber() {
    if (minNumber == null) {
    } else if ((selectedValue) <= minNumber!) {
      selectedValue = minNumber!.toDouble();
    }
  }

  void _vibratingOnIntegerValue() {
    if ((selectedValue.floor() - _previousSelectedValue).abs() >= 0.5) {
      HapticFeedback.selectionClick();
      _previousSelectedValue = selectedValue.floor();
    }
  }
}
