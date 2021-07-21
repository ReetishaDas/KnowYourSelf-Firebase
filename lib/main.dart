import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/Recommendation.dart';
import 'package:homely_assignment/Data/bodyType.dart';
import 'package:homely_assignment/Data/genderScreen.dart';
import 'package:homely_assignment/Data/heightScreen.dart';
import 'package:homely_assignment/Data/lastPage.dart';
import 'package:homely_assignment/Data/thankyouPage.dart';
import 'package:homely_assignment/Data/weightScreen.dart';
import 'package:homely_assignment/Screens/Sign_IN_screen.dart';
import 'package:homely_assignment/Screens/signUpScreen.dart';
import 'package:homely_assignment/Screens/welcomeScreen.dart';
import 'package:homely_assignment/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        GenderScreen.id: (context) => GenderScreen(),
        WeightScreen.id: (context) => WeightScreen(),
        HeightScreen.id: (context) => HeightScreen(),
        BodyPage.id: (context) => BodyPage(),
        LastQuestion.id: (context) => LastQuestion(),
        ThankyouPage.id: (context) => ThankyouPage(),
        Recommendation.id: (context) => Recommendation(),
      },
    );
  }
}
