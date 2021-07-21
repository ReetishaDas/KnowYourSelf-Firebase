import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/bodyType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeightScreen extends StatefulWidget {
  static String id = "HeightScreen";

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final _firestore = FirebaseFirestore.instance;
  String ft;
  String inch;
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
                    padding: EdgeInsets.only(right: 35, top: 20),
                    child: Text(
                      "What is your body height?",
                      style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 83, top: 11, bottom: 50),
                    child: Text(
                      "Enter your height measurement ",
                      style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      color: Colors.transparent,
                      height: 100,
                      padding: EdgeInsets.only(right: 30),
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(right: 38.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 100,
                              width: 80,
                              child: TextField(
                                onChanged: (value) {
                                  ft = value;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: 'pop',
                                    fontSize: 48,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Ft",
                                  style: TextStyle(
                                    fontFamily: 'pop',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: Colors.transparent,
                              height: 100,
                              width: 80,
                              child: TextField(
                                onChanged: (value) {
                                  inch = value;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: 'pop',
                                    fontSize: 48,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "in",
                                  style: TextStyle(
                                    fontFamily: 'pop',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 230.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _firestore
                                .collection("height")
                                .add({"Ft": ft, "inch": inch});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BodyPage()));
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
