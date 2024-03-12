

part of ruler_picker_lib;



class _RulerPickedLongVerticalLine extends StatelessWidget {

  late double height;
  late double width;
  late Color color;

  _RulerPickedLongVerticalLine({required this.height, required this.width, required this.color});

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