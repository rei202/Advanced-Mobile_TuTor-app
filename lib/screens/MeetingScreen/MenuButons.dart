import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 25,
              child: Icon(
                Icons.mic_none_outlined,
                color: Colors.white,
              )
          ),
          SizedBox(
            width: 25,
            child: Icon(
              Icons.videocam_off_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 25,
            child: Icon(
              Icons.screen_share_outlined,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 25,
            child: Icon(
              Icons.messenger_outline_rounded,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 25,
            child: Icon(
              Icons.fullscreen,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white,
              ));
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
              child: SizedBox(
                width: 25,
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}