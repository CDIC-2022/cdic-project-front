
import 'package:cdic_2022/commons/two_line_item.dart';
import 'package:cdic_2022/styles/colors.dart';
import 'package:cdic_2022/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:cdic_2022/power/powerSave.dart';

class ProfileInfoCard extends StatefulWidget {
  final firstText, secondText, isButton;

  const ProfileInfoCard({this.firstText, this.secondText, this.isButton = false});

  @override
  State<StatefulWidget> createState() => _ProfileInfoCard();
}

class _ProfileInfoCard extends State<ProfileInfoCard>{

  @override
  Widget build(BuildContext context) {
    String onOffText;
    bool powerSaved = powerSave().isPowerSaved();
    bool powerSaveFlag;

    if (powerSaved){
      print("power save is in on state");
      //imagePath = image that turn off power save
      onOffText = "OFF";
      powerSaveFlag = true;
    }else{
      print("power save is in off state");
      //imagePath = image that turn on power save
      onOffText = "ON";
      powerSaveFlag = false;
    }

    return Expanded(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: widget.isButton
            ? Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if(powerSaveFlag){
                    // on -> off
                    powerSaveFlag = powerSave().powerSaveOff();
                    onOffText = "ON";
                  }else{
                    // off -> on
                    powerSaveFlag = powerSave().powerSaveOn();
                    onOffText = "OFF";
                  }

                });
                print("Power Save button clicked");


              },
              child: Text(
                onOffText,
                style: titleStyle,
              ),
            )

        )
            : TwoLineItem(
          firstText: widget.firstText,
          secondText: widget.secondText,
        ),
      ),
    );
  }

}