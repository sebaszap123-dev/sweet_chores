import 'package:flutter/material.dart';

class StrokeText extends StatefulWidget {
  const StrokeText({
    super.key,
    this.width,
    this.height,
    this.text,
    this.textSize,
    this.textColor,
    this.strokeColor,
    this.letterSpacing,
    this.strokeWidth,
  });

  final double? width;
  final double? height;
  final String? text;
  final double? textSize;
  final Color? textColor;
  final Color? strokeColor;
  final double? letterSpacing;
  final double? strokeWidth;

  @override
  State<StrokeText> createState() => _StrokeTextState();
}

class _StrokeTextState extends State<StrokeText> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Implement the stroke
        Text(
          widget.text ?? '',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: widget.textSize ?? 16,
                letterSpacing: widget.letterSpacing ?? 0,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = widget.strokeWidth ?? 4
                  ..color = widget.strokeColor ?? Colors.black,
              ),
        ),
        // The text inside
        Text(
          widget.text ?? '',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: widget.textSize ?? 16,
                letterSpacing: widget.letterSpacing ?? 0,
                fontWeight: FontWeight.bold,
                color: widget.textColor ?? Colors.white,
              ),
        ),
      ],
    );
  }
}
