import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/weightScreen.dart';
import 'package:homely_assignment/Screens/welcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const inActiveCardColor = Color(0xFFFBAF02);
const activeCardColor = Colors.white;
enum Gender {
  male,
  female,
  other,
}

class GenderScreen extends StatefulWidget {
  static String id = 'GenderScreen';
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  Gender selectedGender;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
        backgroundColor: Color(0xFFFBAF02),
      ),
      backgroundColor: Color(0xFFFBAF02),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(left: 34.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 35, top: 25),
                    child: Text(
                      "Select your gender",
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'pop',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 83, top: 11, bottom: 90),
                    child: Text(
                      "Tap on bubble to select gender",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'pop',
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGender = Gender.male;
                                  _firestore
                                      .collection("gender")
                                      .add({"gender": "male"});
                                });
                              },
                              child: GenderCard(
                                color: selectedGender == Gender.male
                                    ? activeCardColor
                                    : inActiveCardColor,
                                text: "Male",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGender = Gender.female;
                                  _firestore
                                      .collection("gender")
                                      .add({"gender": "female"});
                                });
                              },
                              child: GenderCard(
                                color: selectedGender == Gender.female
                                    ? activeCardColor
                                    : inActiveCardColor,
                                text: "Female",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedGender = Gender.other;
                                  _firestore
                                      .collection("gender")
                                      .add({"gender": "other"});
                                });
                              },
                              child: GenderCard(
                                text: "Others",
                                color: selectedGender == Gender.other
                                    ? activeCardColor
                                    : inActiveCardColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 95.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeightScreen()));
                          },
                          child: Text("Next",
                              style: TextStyle(
                                  fontFamily: 'pop',
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.black,
                          size: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String text;
  final Color color;
  GenderCard({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 2.2),
          shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontFamily: 'pop',
          ),
        ),
      ),
    );
  }
}
