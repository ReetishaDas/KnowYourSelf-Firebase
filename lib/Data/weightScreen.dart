import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:homely_assignment/Data/heightScreen.dart';

class WeightScreen extends StatefulWidget {
  static String id = "WeightScreen";
  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final _firestore = FirebaseFirestore.instance;

  Widget _buildItem(int i) {
    return Center(
      child: ClipRRect(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 2.2),
              shape: BoxShape.circle),
          child: Center(
            child: Text(
              "${i + 1}",
              style: TextStyle(
                  fontFamily: 'pop',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 35, top: 20, left: 34.0),
                  child: Text(
                    "What is your body weight?",
                    style: TextStyle(
                        fontFamily: 'pop',
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 83, top: 11, left: 34.0),
                  child: Text(
                    "Drag wheel to tell us your weight",
                    style: TextStyle(
                        fontFamily: 'pop',
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 58.0),
                  child: Container(
                    height: 250,
                    child: CircleListScrollView(
                      axis: Axis.horizontal,
                      itemExtent: 80,
                      physics: CircleFixedExtentScrollPhysics(),
                      children: List.generate(90, _buildItem),
                      onSelectedItemChanged: (int index) {
                        print("${index + 1}");
                        _firestore
                            .collection("weight")
                            .add({"weight": "${index + 1}"});
                      },
                      radius: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30, top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HeightScreen()));
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
    );
  }
}
