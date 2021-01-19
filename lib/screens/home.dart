import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    catAnimation = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );

    catController.forward();
  }

  void onTap() {
    if (catController.status == AnimationStatus.forward ||
        catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else
      catController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Anima Cat!')),
      backgroundColor: Color(0xFF9A9AFF),
      body: GestureDetector(
        child: Stack(
          children: [
            buildAnimation(),
            buildBox(),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      child: Cat(),
      builder: (BuildContext context, Widget child) {
        return Container(
          margin: EdgeInsets.only(top: catAnimation.value),
          padding: EdgeInsets.symmetric(horizontal: 100.0),
          // padding: EdgeInsets.symmetric(horizontal: catAnimation.value * 0.4),
          // color: Colors.blue.shade300,
          child: child,
        );
      },
    );
  }

  Widget buildBox() {
    return Center(
      child: Container(
        color: Colors.brown,
        height: 200.0,
        width: 200.0,
      ),
    );
  }
}
