import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math' show pi;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    catAnimation = Tween(
      begin: -30.0,
      end: -83.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeInOut,
      ),
    );

    boxAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          boxController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          boxController.forward();
        }
      },
    );
    boxController.forward();
  }

  void onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anima Cat!')),
      backgroundColor: Color(0xFFB7A6B1),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 120.0),
          color: Colors.green,
          height: 400.0,
          child: GestureDetector(
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  buildCatAnimation(),
                  buildBox(),
                  buildLeftFlap(),
                  buildRightFlap(),
                ],
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      child: Cat(),
      builder: (BuildContext context, Widget child) {
        return Positioned(
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
          child: child,
        );
      },
    );
  }

  Widget buildBox() {
    return Container(
      color: Color(0xFFD4CAA0),
      height: 200.0,
      width: 200.0,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          );
        },
        child: Container(
          color: Color(0xFFD4CAA0),
          height: 10.0,
          width: 125.0,
        ),
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: -boxAnimation.value * 1.06,
            alignment: Alignment.topRight,
            child: child,
          );
        },
        child: Container(
          color: Color(0xFFD4CAA0),
          height: 10.0,
          width: 125.0,
        ),
      ),
    );
  }

  Widget buildGrassField() {
    return Container(
      height: 400.0,
      width: 300.0,
      color: Colors.green,
    );
  }
}
