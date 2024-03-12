

part of ruler_picker_lib;



class _RulerLongVerticalLine extends StatelessWidget {

  late double height;
  late double width;
  late Color color;

  _RulerLongVerticalLine({required this.height, required this.width, required this.color});

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