import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_247/Screens/registration_screen.dart';
import 'package:report_247/Service/auth.dart';
import 'package:report_247/units/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(30.0, 100.0, 0.0, 0.0),
                        child: Text(
                          'Report It',
                          style: TextStyle(
                            color: Color(0xff3ea339),
                            // color: Colors.while,
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(160.0, 175.0, 0.0, 0.0),
                        child: Text(
                          '24/7',
                          style: TextStyle(
                            color: Color(0xff3ea339),
                            // color: Colors.while,
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(300.0, 110.0, 0.0, 0.0),
                        child: Text(
                          '.',
                          style: TextStyle(
                              fontSize: 140.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3ea339)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 35.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Required';
                          }
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Color(0xff3ea339),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff9f7d24)),
                          ),
                          labelText: 'EMAIL',
                          labelStyle: kLabelText,
                        ),
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Required';
                          } else if (password.length < 6) {
                            return 'Password too weak';
                          }
                        },
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        cursorColor: Color(0xff3ea339),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff9f7d24)),
                          ),
                          labelText: 'PASSWORD',
                          labelStyle: kLabelText,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                      Container(
                        height: 50.0,
                        width: 280,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xff3ea339),
                          shadowColor: Colors.white,
                          elevation: 5.0,
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Auth().signInEmail(emailController.text,
                                    passwordController.text, context);
                              }
                            },
                            child: Center(
                              child: Text(
                                'LOGIN',
                                style: kLoginSignUpButton,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to our App!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        'Sign up',
                        style: kLoginSignUp,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
