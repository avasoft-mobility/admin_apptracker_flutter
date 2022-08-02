import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection axisDirection;
  CustomPageRoute({
    this.axisDirection = AxisDirection.up,
    required this.child,
  }) : super(pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      // position: Tween<Offset>(
      //   begin: getBeginPostion(),
      //   end: Offset.zero,
      // ).animate(animation),
      child: this.child,
    );
  }

  Offset getBeginPostion() {
    switch (axisDirection) {
      case AxisDirection.up:
        return const Offset(1, 1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.down:
        return const Offset(-1, -1);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
