import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VegDiet extends StatefulWidget {
  @override
  _VegDietState createState() => _VegDietState();
}

class _VegDietState extends State<VegDiet> {
  final firestoreDB =
      FirebaseFirestore.instance.collection("dietPlans").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBAF02),
        title: Text(
          "VEG DIET PLANS",
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
                    snapshot.data.docs[index]['veg'],
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
