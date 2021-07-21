import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homely_assignment/Data/genderScreen.dart';
import 'package:homely_assignment/Screens/welcomeScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

enum MobileVerificationState {
  SHOW_REGISTRATION_STATE,
  SHOW_OTP_FORM_STATE,
}

class SignUpScreen extends StatefulWidget {
  static String id = "SignUpScreen";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_REGISTRATION_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String email;
  String password;
  String username;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String verificationId;
  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential = _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential != null) {
        Fluttertoast.showToast(
            msg: "Registration Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            timeInSecForIosWeb: 2);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GenderScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      Fluttertoast.showToast(
          msg: e.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          timeInSecForIosWeb: 2);
    }
  }

  getRegistrationFormWidget(context) {
    return SingleChildScrollView(
      child: ModalProgressHUD(
        inAsyncCall: showLoading,
        child: Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Column(
            children: [
              inputFile(
                  label: "Enter Name",
                  onChange: (value) {
                    username = value;
                  }),
              inputFile(
                  label: "Email id",
                  keyboardType: TextInputType.emailAddress,
                  onChange: (value) {
                    email = value;
                  }),
              inputFile(
                  label: "Enter contact number",
                  controller: phoneController,
                  keyboardType: TextInputType.phone),
              inputFile(
                label: "Password",
                obscureText: true,
                inText: "6 characters min",
                onChange: (value) {
                  password = value;
                },
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  setState(() {
                    showLoading = true;
                  });
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    await _auth.verifyPhoneNumber(
                      phoneNumber: "+91" + phoneController.text,
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                        Fluttertoast.showToast(
                            msg: "Phone Verified",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.teal,
                            textColor: Colors.white,
                            timeInSecForIosWeb: 2);
                        //signInWithPhoneAuthCredential(PhoneAuthCredential)
                      },
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        Fluttertoast.showToast(
                            msg: "PhoneNo not valid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.teal,
                            textColor: Colors.white,
                            timeInSecForIosWeb: 2);
                      },
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          this.verificationId = verificationId;
                        });
                        Fluttertoast.showToast(
                            msg: "OTP Sent to" + phoneController.text,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.teal,
                            textColor: Colors.white,
                            timeInSecForIosWeb: 2);
                      },
                      codeAutoRetrievalTimeout: (verificationId) async {},
                    );
                  }
                  _firestore
                      .collection("users")
                      .add({"displayName": username, "email": email});
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => getOtpFormWidget(context)));
                  setState(() {
                    showLoading = false;
                  });
                },
                color: Color(0xFFFBAF02),
                elevation: 0,
                child: Text(
                  "Create an account",
                  style: TextStyle(
                    fontFamily: 'pop',
                    fontWeight: FontWeight.w600,
                    fontSize: 17.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getOtpFormWidget(context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => getRegistrationFormWidget(context)));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 38.0, right: 38, top: 40),
                  child: Text(
                    'Verify your mobile number',
                    style: TextStyle(
                      fontFamily: 'pop',
                      fontSize: 46.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 38.0, right: 59, top: 27),
                  child: Text(
                    "Enter one time password sent to " + phoneController.text,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'pop',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 38, right: 38, top: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 17),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 38.0,
                        ),
                        child: Text(
                          "Have a trouble,\t\t\t",
                          style: TextStyle(
                            fontFamily: 'pop',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            showLoading = true;
                          });

                          await _auth.verifyPhoneNumber(
                            phoneNumber: "+91" + phoneController.text,
                            verificationCompleted: (phoneAuthCredential) async {
                              setState(() {
                                showLoading = false;
                              });
                              //signInWithPhoneAuthCredential(PhoneAuthCredential)
                            },
                            verificationFailed: (verificationFailed) async {
                              setState(() {
                                showLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "PhoneNo not valid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.teal,
                                  textColor: Colors.white,
                                  timeInSecForIosWeb: 2);
                            },
                            codeSent: (verificationId, resendingToken) async {
                              setState(() {
                                showLoading = false;
                                this.verificationId = verificationId;
                              });
                              Fluttertoast.showToast(
                                  msg: "OTP Sent to  " + phoneController.text,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.teal,
                                  textColor: Colors.white,
                                  timeInSecForIosWeb: 2);
                            },
                            codeAutoRetrievalTimeout: (verificationId) async {},
                          );
                        },
                        child: Text(
                          "Resend Code?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 35.0),
                  child: SizedBox(
                    height: 50,
                    width: 315,
                    child: MaterialButton(
                      onPressed: () async {
                        PhoneAuthCredential phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: otpController.text);
                        signInWithPhoneAuthCredential(phoneAuthCredential);
                      },
                      color: Color(0xFFFBAF02),
                      child: Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'pop',
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Signup",
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFE5E5E5),
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_REGISTRATION_STATE
                ? getRegistrationFormWidget(context)
                : getOtpFormWidget(context),
        padding: EdgeInsets.all(16),
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
            fontSize: 15,
            fontFamily: 'pop',
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
