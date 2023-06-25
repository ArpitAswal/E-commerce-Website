import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class FlashScreen extends StatefulWidget {
   const FlashScreen({super.key, required this.title,});
  final String title;

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..animateBack(3, duration: const Duration(seconds: 3), curve: Curves.fastOutSlowIn)..repeat(reverse: true);
    Future.delayed(const Duration(seconds: 10),(){
      _controller.stop(canceled: true);
    }).then((value) {
      if(widget.title=='Home'){
        return Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context)=> const HomeScreen()));
      }
      else{
      return Navigator.pushReplacement(context, MaterialPageRoute(builder:(BuildContext context)=> const LogInScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Container(
          height: h,
          width: w,
          color: Colors.white,
          child: AnimatedBuilder(
            animation: _controller,
            child: Image.asset("assets/AA_Wings.jpg"),
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: _controller.value * 1.5,
                origin: const Offset(30.0, 40.0),
                child: child,
              );
            },
          )),
    ));
  }
}
