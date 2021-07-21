import 'package:flutter/material.dart';
import 'package:homely_assignment/Screens/welcomeScreen.dart';

class SplashScreen extends StatelessWidget {
  static String id = "SplashScreen";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashImage(),
    );
  }
}

class SplashImage extends StatefulWidget {
  @override
  _SplashImageState createState() => _SplashImageState();
}

class _SplashImageState extends State<SplashImage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/Mypost.png"), fit: BoxFit.fill),
      ),
    );
  }
}
