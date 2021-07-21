import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/Recommendation.dart';

class ThankyouPage extends StatefulWidget {
  static String id = "ThankyouPage";
  @override
  _ThankyouPageState createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.only(right: 35, top: 55),
                    child: Text(
                      "Thank for the your details",
                      style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 83, top: 11),
                    child: Text(
                      "Love home cooked food?",
                      style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 83, top: 5),
                    child: Text(
                      "Homecooked is the perfect solution for your everyday problem",
                      style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 320.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Recommendation()));
                          },
                          child: Text("Explore",
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
