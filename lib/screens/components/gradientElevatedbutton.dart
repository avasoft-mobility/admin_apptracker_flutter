import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final double borderRadius;
  final double width;
  final double height;
  final Color startColor;
  final Color endColor;
  final bool shadow;
  // final double elevation;
  final VoidCallback? onPressed;
  final Widget child;

  const GradientElevatedButton({
    Key? key,
    // required this.elevation,
    required this.shadow,
    required this.endColor,
    required this.startColor,
    required this.onPressed,
    required this.child,
    required this.borderRadius,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          shadow
              ? const BoxShadow(
                  color: Colors.black26,
                  offset: Offset(4, 4),
                  blurRadius: 6.0,
                )
              : const BoxShadow(
                  color: Colors.transparent,
                )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            startColor,
            endColor,
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(

        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation:  MaterialStateProperty.all(0),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: child,
      ),
    );
  }
}
