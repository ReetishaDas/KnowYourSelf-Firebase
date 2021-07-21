import 'package:flutter/material.dart';
import 'package:homely_assignment/Data/genderScreen.dart';
import 'package:homely_assignment/Screens/signUpScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'welcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
  static String id = "SignInScreen";
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Signin",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'pop',
          ),
        ),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xFFE5E5E5),
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
      ),
      backgroundColor: Color(0xFFE5E5E5),
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            margin: EdgeInsets.all(40),
            child: Column(
              children: [
                inputFile(
                  label: "Email id",
                  onChange: (value) {
                    email = (value);
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                inputFile(
                  label: "Password",
                  obscureText: true,
                  onChange: (value) {
                    password = (value);
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenderScreen()));
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GenderScreen()));
                    Fluttertoast.showToast(
                        msg: "Login Successful",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.teal,
                        textColor: Colors.white,
                        timeInSecForIosWeb: 2);
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  color: Color(0xFFFBAF02),
                  child: Text(
                    "SignIn",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: TextStyle(
                        fontFamily: 'pop',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "SignUp here.",
                        style: TextStyle(
                          fontFamily: 'pop',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFile(
      {label,
      obscureText = false,
      controller,
      keyboardType,
      inText,
      onChange}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'pop',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87.withOpacity(0.4),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 46),
          child: TextFormField(
            onChanged: onChange,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: inText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
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
      ],
    );
  }
}
