import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';

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
                child: Image.asset(
                  "images/login-thumnail.png",
                ),
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 16, bottom: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Forgot password ?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          )),
                      Container(
                          height: 40,
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: ElevatedButton(
                            onPressed: () {},
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
                                Text(
                                  "Sign up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                )
                              ])),
                    ]),
              ),
            ])));
  }
}
