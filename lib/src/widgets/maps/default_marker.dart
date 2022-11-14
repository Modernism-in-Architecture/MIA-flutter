import 'package:flutter/material.dart';

class DefaultLocationMarker extends StatelessWidget {
  const DefaultLocationMarker({super.key});

//   const DefaultLocationMarker({super.key});
//
//   @override
//   _DefaultLocationMarkerState createState() => _DefaultLocationMarkerState();
//
// }
// class _DefaultLocationMarkerState extends State<DefaultLocationMarker> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation _animation;
//
//   @override
//   void initState() {
//     _animationController = AnimationController(
//         vsync: this,
//         duration: const Duration(seconds: 1)
//     );
//     _animationController.repeat(reverse: true);
//     _animation = Tween(
//         begin: 2.0, end: 20.0
//     ).animate(_animationController)..addListener((){
//       setState(() {});
//     });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return const Icon(
        Icons.circle,
        size: 20,
        color: Colors.blue,
        shadows: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 10
              // blurRadius: _animation.value,
              // spreadRadius: _animation.value
          )
        ],
    );

  }
}