import 'package:flutter/material.dart';


class DefaultLocationMarker extends StatefulWidget {
  const DefaultLocationMarker({super.key});

  @override
  DefaultLocationMarkerState createState() => DefaultLocationMarkerState();
}


class DefaultLocationMarkerState extends State<DefaultLocationMarker> with TickerProviderStateMixin {
  final Tween<double> _tween = Tween(begin: 0.7, end: 1);

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = _tween.animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
            Icons.circle,
            size: 20,
            color: Colors.red,
          ),
      ),
    );// child:
  }
}