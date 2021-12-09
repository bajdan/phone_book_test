import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoOpacityController;
  late Animation<double> _opacityLogoAnimation;


  @override
  void initState() {
    _moveToHomeScreen();
    _logoOpacityController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..addListener(() {
        setState(() {});
      });
    _opacityLogoAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _logoOpacityController, curve: Curves.bounceIn));
    super.initState();
  }

  @override
  void dispose() {
    _logoOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logoOpacityController.forward();
    return Scaffold(
      backgroundColor: const Color(0xFFdf6977),
      body: Center(
        child: Opacity(
          opacity: _opacityLogoAnimation.value,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo1.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _moveToHomeScreen() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/home');
  }
}
