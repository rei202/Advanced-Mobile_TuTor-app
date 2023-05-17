import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/screens/LoginPage.dart';
import 'package:lettutor/screens/MainScreen.dart';
import 'package:lettutor/services/authenService.dart';
import 'package:lettutor/services/authenWithSocialNetwork.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../env/env.dart';
import '../models/User.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  final formField = GlobalKey<FormState>();
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
                child: Form(
                  key: formField,
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
                          child: TextFormField(
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
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email shouldn't be empty";
                              }
                              bool emailValid =
                                  RegExp(validateRegex).hasMatch(value);
                              if (!emailValid) return "Enter valid email";
                            },
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
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password shouldn't be empty";
                              } else if (passwordController.text.length < 6) {
                                return "Password should be more than 6 characters";
                              }
                            },
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
                          child: TextFormField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm password shouldn't be empty";
                              } else if (!(value == passwordController.text)) {
                                return "Password's not match";
                              }
                            },
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
                                bool isValid =
                                    formField.currentState!.validate();
                                if (isValid) {
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
                      ]),
                ),
              ),
            ])));
  }

  void showFailedAlert() {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Signup Failed",
          maxLines: 2,
        ),
        displayDuration: const Duration(milliseconds: 500));
  }

  void showSuccessfulAlert() {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: 'Signup successfully',
          maxLines: 2,
        ),
        displayDuration: const Duration(milliseconds: 500),
        animationDuration: const Duration(milliseconds: 1000));
  }
}
