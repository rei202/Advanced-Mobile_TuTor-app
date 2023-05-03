import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/screens/LoginPage.dart';
import 'package:lettutor/screens/MainScreen.dart';
import 'package:lettutor/services/authenService.dart';

import '../models/User.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameContrller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        appBar: AppBar(
          title: Text("Sign up"),
        ),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            margin: EdgeInsets.only(top: 70),
            child: ListView(children: [
              Container(
                child: svg,
              ),
              Container(
                padding: EdgeInsets.only(top: 17, left: 25, right: 25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 8, top: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "FULL NAME  ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )),
                      Container(
                        child: TextField(
                          controller: fullnameContrller,
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
                          padding: EdgeInsets.only(bottom: 8, top: 8),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "CONFIRM PASSWORD  ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )),
                      Container(
                        child: TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 8),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                          height: 40,
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (passwordController.text
                                  .endsWith(confirmPasswordController.text)) {
                                var response = await AuthenService.register(
                                    fullnameContrller.text,
                                    emailController.text,
                                    passwordController.text);
                                print(response);
                                if (response['isSuccess'] == true) {
                                  showSuccessfulAlert();
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  showFailedAlert();
                                }
                              }
                            },
                            child: const Text('REGISTER'),
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
                    ]),
              ),
            ])));
  }

  void showFailedAlert() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        "Signup Failed",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.red,
    ));
  }

  void showSuccessfulAlert() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Signup successfully',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.green,
    ));
  }
}
