import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/lastPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const inActiveCardColor = Color(0xFFFBAF02);
const activeCardColor = Colors.white;
enum BodyType {
  Ectomorph,
  Endomorph,
  Mesomorph,
}

class BodyPage extends StatefulWidget {
  static String id = "BodyPage";
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  BodyType selectedBodyType;

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
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
                    padding: EdgeInsets.only(right: 35, top: 20),
                    child: Text(
                      "What is your body type?",
                      style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 83, top: 11, bottom: 70),
                    child: Text(
                      "Tap to bubble to select body type",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: 'pop',
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
                                  selectedBodyType = BodyType.Ectomorph;
                                  _firestore.collection("bodyType").add({
                                    "bodyType": "Ectomorph",
                                  });
                                });
                              },
                              child: BodyTypeCard(
                                color: selectedBodyType == BodyType.Ectomorph
                                    ? activeCardColor
                                    : inActiveCardColor,
                                text: "Ectomorph",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedBodyType = BodyType.Endomorph;
                                  _firestore.collection("bodyType").add({
                                    "bodyType": "Endomorph",
                                  });
                                });
                              },
                              child: BodyTypeCard(
                                color: selectedBodyType == BodyType.Endomorph
                                    ? activeCardColor
                                    : inActiveCardColor,
                                text: "Endomorph",
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
                                  selectedBodyType = BodyType.Mesomorph;
                                  _firestore.collection("bodyType").add({
                                    "bodyType": "Mesomorph",
                                  });
                                });
                              },
                              child: BodyTypeCard(
                                text: "Mesomorph",
                                color: selectedBodyType == BodyType.Mesomorph
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
                    padding: EdgeInsets.only(top: 100.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LastQuestion()));
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
                        ),
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

class BodyTypeCard extends StatelessWidget {
  final String text;
  final Color color;
  BodyTypeCard({this.text, this.color});

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
