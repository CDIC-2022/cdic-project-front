
import 'package:cdic_2022/commons/two_line_item.dart';
import 'package:cdic_2022/styles/colors.dart';
import 'package:cdic_2022/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:cdic_2022/power/powerSave.dart';

class ProfileInfoCard extends StatefulWidget {
  final firstText, secondText, isButton, deviceName;

  const ProfileInfoCard({this.firstText, this.secondText, this.isButton = false, this.deviceName});

  @override
  State<StatefulWidget> createState() => _ProfileInfoCard(deviceName);
}

class _ProfileInfoCard extends State<ProfileInfoCard>{
  String deviceName;
  _ProfileInfoCard(this.deviceName);

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return FutureBuilder(
        future: powerSave().isPowerSaved(deviceName),
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            //todo error page
            return new Text("Error occured");
          } else {
            int? powerSaved = snapshot.data;
            String onOffText = "";
            bool powerSaveFlag = false;

              if (powerSaved == 1) {
                print("power save is in on state");
                //imagePath = image that turn off power save
                onOffText = "OFF";
                powerSaveFlag = true;
              } else if (powerSaved == 0) {
                print("power save is in off state");
                //imagePath = image that turn on power save
                onOffText = "ON";
                powerSaveFlag = false;
              } else if (powerSaved == -1) {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("통신 오류"),
                        content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("기기와의 통신이 실패하였습니다."),
                                Text("네트워크를 확인해주세요.")
                              ],
                            )
                        ), actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("확인")
                        )
                      ],
                      );
                    }
                );
              }

            return Expanded(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: widget.isButton
                    ? Center(
                    child: GestureDetector(
                      onTap: () async {
                        print("powerSaveFlag now : " + powerSaveFlag.toString());
                          if (powerSaveFlag) {
                            //todo
                            // on -> off
                            powerSaveFlag = await powerSave().powerSaveOff(deviceName);
                            onOffText = "ON";
                          } else {
                            // off -> on
                            powerSaveFlag = await powerSave().powerSaveOn(deviceName);
                            onOffText = "OFF";
                          }
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

        );
  }

}