import 'package:cdic_2022/commons/radial_progress.dart';
import 'package:cdic_2022/commons/rounded_image.dart';
import 'package:cdic_2022/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyInfo extends StatelessWidget {
  String deviceName;
  MyInfo(this.deviceName);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadialProgress(
            width: 4,
            goalCompleted: 1,
            child: RoundedImage(
              imagePath: "assets/images/plug.png",
              size: Size.fromWidth(100.0),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                deviceName,
                style: whiteNameTextStyle,
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}