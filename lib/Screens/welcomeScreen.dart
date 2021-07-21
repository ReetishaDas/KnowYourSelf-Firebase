import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homely_assignment/Screens/Sign_IN_screen.dart';
import 'package:homely_assignment/Screens/signUpScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcome Screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 30),
                child: Text(
                  "Welcome To DailyDash",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'pop',
                      color: Colors.black),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 31, bottom: 20),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      color: Color(0xFF3A5999),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          "Use Facebook",
                          style: TextStyle(
                            color: Color(0xFFF6F6F9),
                            fontSize: 16,
                            fontFamily: 'pop',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 31, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black)),
                      height: 60,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          "Sign Up with Email",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'pop',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 161.0, right: 171),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'pop',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 117.0, right: 118, bottom: 45, top: 20),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFA4A0C)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
