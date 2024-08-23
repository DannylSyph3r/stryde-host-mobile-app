import 'package:flutter/material.dart';
import 'package:stryde_mobile_app/theme/palette.dart';

class CustomVerticalBar extends StatelessWidget {
  final double percentage;
  final double width;
  final double height;
  final Color backgroundColor;

  const CustomVerticalBar({
    Key? key,
    required this.percentage,
    this.width = 30.0,
    this.height = 200.0,
    this.backgroundColor = Palette.buttonBG,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Gradient-filled part
          FractionallySizedBox(
            heightFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 60, 60, 60),
                      Color(0xFF444444),
                      Color(0xFF666666),
                      Color(0xFFAA8866),
                      Color(0xFFDDAA88),
                    ],
                    stops: [
                      0.0,
                      0.6,
                      0.8,
                      0.9,
                      1.0,
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
