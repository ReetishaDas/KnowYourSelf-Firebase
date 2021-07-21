import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NonVegDiet extends StatefulWidget {
  @override
  _NonVegDietState createState() => _NonVegDietState();
}

class _NonVegDietState extends State<NonVegDiet> {
  final firestoreDB =
      FirebaseFirestore.instance.collection("dietPlans").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBAF02),
        title: Text(
          "NON-VEG DIET PLANS",
          style: TextStyle(
            fontFamily: 'pop',
          ),
        ),
      ),
      body: StreamBuilder(
        stream: firestoreDB,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, int index) {
              return Container(
                  margin: EdgeInsets.all(25),
                  child: Text(
                    snapshot.data.docs[index]['nonVeg'],
                    style: TextStyle(
                      fontFamily: 'pop',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
