import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/screens/MainScreen.dart';
import 'package:lettutor/services/authenService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/User.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  TextEditingController emailController = TextEditingController();
  final Widget svg = SvgPicture.asset(
      "images/lettutor_logo.91f91ade.svg",
      semanticsLabel: 'Acme Logo',color: primaryMyColor,
  );

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
        title: Text("Forgot password"),
      ),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            margin: EdgeInsets.only(top: 70),
            child: Column( mainAxisAlignment: MainAxisAlignment.start,children: [
              Container(
                child: svg,
                margin: EdgeInsets.only(bottom: 14, top: 50),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(top: 17, left: 25, right: 25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

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
                          margin: EdgeInsets.only(top: 16, bottom: 8),
                          alignment: Alignment.topLeft,
),
                      Container(
                          height: 40,
                          constraints:
                              BoxConstraints(minWidth: double.infinity),
                          child: ElevatedButton(
                            onPressed: () async {
                              var response = await AuthenService.forgotPassword(
                                  emailController.text);
                              print(response);
                              if (response['isSuccess'] == true) {
                                showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: "Successful",
                                      maxLines: 2,
                                    ),
                                    displayDuration:
                                    const Duration(milliseconds: 500),
                                    animationDuration:
                                    const Duration(milliseconds: 1000)
                                );
                              }
                              else{
                                showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message:
                                      "Your email does not exist",
                                      maxLines: 2,
                                    ),
                                    displayDuration:
                                    const Duration(milliseconds: 500));
                              }
                            },
                            child: const Text('SEND'),
                          )),
                    ]),
              ),
            ])));
  }
}
