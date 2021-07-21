import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/thankyouPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const inActiveCardColor = Color(0xFFFBAF02);
const activeCardColor = Colors.white;
enum MEALS {
  salad,
  soup,
  Heavymeals,
  Juices,
  Meals,
}

class LastQuestion extends StatefulWidget {
  static String id = "LastQuestion";
  @override
  _LastQuestionState createState() => _LastQuestionState();
}

class _LastQuestionState extends State<LastQuestion> {
  final _firestore = FirebaseFirestore.instance;
  MEALS selectedMeal;

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
                  padding:
                      EdgeInsets.only(left: 34, right: 35, top: 10, bottom: 80),
                  child: Text(
                    "Last question, what is your preferred food type",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'pop',
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
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
                                selectedMeal = MEALS.salad;
                                _firestore.collection("food").add({
                                  "food": "salad",
                                });
                              });
                            },
                            child: foodCard(
                              color: selectedMeal == MEALS.salad
                                  ? activeCardColor
                                  : inActiveCardColor,
                              text: "Salad",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMeal = MEALS.soup;
                                _firestore.collection("food").add({
                                  "food": "soup",
                                });
                              });
                            },
                            child: foodCard(
                              color: selectedMeal == MEALS.soup
                                  ? activeCardColor
                                  : inActiveCardColor,
                              text: "Soup",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMeal = MEALS.Heavymeals;
                                _firestore.collection("food").add({
                                  "food": "Heavy meals",
                                });
                              });
                            },
                            child: foodCard(
                              color: selectedMeal == MEALS.Heavymeals
                                  ? activeCardColor
                                  : inActiveCardColor,
                              text: "\t\t\tHeavy \t\t\tMeals",
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
                                selectedMeal = MEALS.Juices;
                                _firestore.collection("food").add({
                                  "food": "Juices",
                                });
                              });
                            },
                            child: foodCard(
                              text: "Juices",
                              color: selectedMeal == MEALS.Juices
                                  ? activeCardColor
                                  : inActiveCardColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMeal = MEALS.Meals;
                                _firestore.collection("food").add({
                                  "food": "meals",
                                });
                              });
                            },
                            child: foodCard(
                              color: selectedMeal == MEALS.Meals
                                  ? activeCardColor
                                  : inActiveCardColor,
                              text: "Meals",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ThankyouPage()));
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

class foodCard extends StatelessWidget {
  final String text;
  final Color color;
  foodCard({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 2.2),
          shape: BoxShape.circle),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
    );
  }
}
