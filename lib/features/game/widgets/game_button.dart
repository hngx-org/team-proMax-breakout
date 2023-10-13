import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.height = 40,
    this.width = double.infinity,
    this.fontSize = 18,
    Key? key,
    this.fgColor,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Color? fgColor;
  final double height;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(20),
          textStyle: TextStyle(fontSize: fontSize),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(height / 2))),
        ),
        onPressed: onPressed,
        child: Text(
          title,
        ),
      ),
    );
  }
}
