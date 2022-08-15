import 'package:cdic_2022/styles/text_style.dart';
import 'package:flutter/material.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText, secondText;

  const TwoLineItem({ required this.firstText, required this.secondText}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          firstText,
          style: titleStyle,
        ),
        Text(
          secondText,
          style: subTitleStyle,
        ),
      ],
    );
  }
}