import 'package:flutter/material.dart';
import 'package:wplappgui/apis/loadUsername.dart';

class SplashBufferRing extends StatefulWidget {
  @override
  _SplashBufferRingState createState() => _SplashBufferRingState();
}

class _SplashBufferRingState extends State<SplashBufferRing> {
  double _getPercentage(p, v) {
    return ((p * v) / 100);
  }

  static double TWO_PI = 3.14 * 2;
  double end = 1.0;
  @override
  Widget build(BuildContext context) {
    final size = _getPercentage(50, MediaQuery.of(context).size.width);
    return TweenAnimationBuilder(
        onEnd: () {
          print("jj");
          setState(() {
            end = (end == 1.0) ? 0.0 : 1.0;
          });
        },
        tween: Tween(begin: 0.0, end: end),
        duration: Duration(seconds: 4),
        builder: (context, value, child) {
          int percentage = (value * 100).ceil();
          return Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                            startAngle: 0.0,
                            endAngle: TWO_PI,
                            stops: [
                              value,
                              value
                            ], // value from Tween Animation Builder
                            // 0.0 , 0.5 , 0.5 , 1.0
                            center: Alignment.center,
                            colors: [Colors.white, Colors.transparent])
                        .createShader(rect);
                  },
                  child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset("assets/icons/splashLeaf.png"))),
                ),
                Center(
                  child: Container(
                    width: _getPercentage(40, size),
                    height: _getPercentage(40, size),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(child: Image.asset("assets/icons/icon.png")),
                  ),
                )
              ],
            ),
          );
        });
  }
}
