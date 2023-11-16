import 'package:flutter/material.dart';
import 'package:report_247/Screens/login_screen.dart';
import 'package:report_247/Service/auth.dart';
import 'package:report_247/units/styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
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
                    padding: EdgeInsets.fromLTRB(24.0, 100.0, 0.0, 0.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Color(0xff3ea339),
                        // color: Colors.white,
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(290.0, 40.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                        // shadows: Colors.white,
                        fontSize: 140.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff3ea339),
                      ),
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
                    validator: (email) {},
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    cursorColor: Color(0xff3ea339),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3ea339)),
                      ),
                      labelText: 'Email',
                      labelStyle: kLabelText,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (password) {},
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    cursorColor: Color(0xff3ea339),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff3ea339)),
                      ),
                      labelText: 'Password',
                      labelStyle: kLabelText,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    validator: (confirmPassword) {
                      if (passwordController.text != confirmPassword) {
                        return 'password incorrect';
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
                        borderSide: BorderSide(color: Color(0xff3ea339)),
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: kLabelText,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 280,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xff3ea339),
                      shadowColor: Colors.black,
                      elevation: 5.0,
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Auth().signUp(emailController.text,
                                passwordController.text, context);
                          }
                        },
                        child: Center(
                          child: Text(
                            'SIGNUP',
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
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have a account?',
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
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Log in',
                    style: kLoginSignUp,
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
