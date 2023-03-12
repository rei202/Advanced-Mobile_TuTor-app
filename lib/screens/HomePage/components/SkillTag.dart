import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkillTag extends StatelessWidget {
  const SkillTag({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (
    Container(
        margin: EdgeInsets.only(right: 4, top: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xffddeaff),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ) ,
        child: Text(name),
    ));
  }
}
