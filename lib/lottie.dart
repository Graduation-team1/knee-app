import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieIcon extends StatelessWidget {
  final String animationAsset;
  final double size;

  const LottieIcon({
    Key? key,
    required this.animationAsset,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        animationAsset,
        fit: BoxFit.contain,
      ),
    );
  }
}
