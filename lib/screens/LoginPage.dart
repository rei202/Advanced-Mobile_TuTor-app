import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/screens/ForgotPassword.dart';
import 'package:lettutor/screens/MainScreen.dart';
import 'package:lettutor/screens/SignupPage.dart';
import 'package:lettutor/services/authenService.dart';

import '../models/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Widget svg = SvgPicture.asset("images/lettutor_logo.91f91ade.svg",
      semanticsLabel: 'Acme Logo');

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            margin: EdgeInsets.only(top: 70),
            child: ListView(children: [
              Container(
                child: svg,
                margin: EdgeInsets.only(bottom: 14),
              ),
              Container(
                padding: EdgeInsets.only(top: 17, left: 25, right: 25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 14),
                          child: Text(
                            "Say hello to your English tutors",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 7, top: 7),
                        child: Text(
                          "Become fluent faster through one on one video chat lessons tailored to your goals",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "EMAIL  ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )),
                      Container(
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 8, top: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "PASSWORD  ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )),
                      Container(
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                          // margin: EdgeInsets.only(top: 16, bottom: 8),
                          alignment: Alignment.topLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage()),
                                );
                              },
                              child: Text(
                                "Forgot password ?",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ))),
                      Container(
                          height: 40,
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: ElevatedButton(
                            onPressed: () async {
                              var response = await AuthenService.login(User(
                                  emailController.text,
                                  passwordController.text));
                              print(response);
                              if (response['isSuccess'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Login successfully',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen()),
                                  );
                                });
                              }
                            },
                            child: const Text('LOG IN'),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 24, bottom: 24),
                          alignment: Alignment.center,
                          child: Text(
                            "Or continue with",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 24),
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 65,
                                  child: IconButton(
                                    icon: Image.asset("images/fb-icon.png"),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  width: 65,
                                  child: IconButton(
                                    icon: Image.asset("images/google-icon.png"),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  width: 65,
                                  child: IconButton(
                                    icon: Image.asset("images/device-icon.png"),
                                    onPressed: () {},
                                  ),
                                )
                              ])),
                      Container(
                          margin: EdgeInsets.only(bottom: 40),
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Not a member yet? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupPage()),
                                      );
                                    },
                                    child: Text(
                                      "Sign up",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ))
                              ])),
                    ]),
              ),
            ])));
  }
}
