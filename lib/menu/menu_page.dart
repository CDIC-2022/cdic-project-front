import 'package:cdic_2022/commons/my_info.dart';
import 'package:cdic_2022/commons/opaque_image.dart';
import 'package:cdic_2022/commons/profile_info_big_card.dart';
import 'package:cdic_2022/commons/profile_info_card.dart';
import 'package:cdic_2022/menu//super_likes_me_page.dart';
import 'package:cdic_2022/styles/colors.dart';
import 'package:cdic_2022/styles/text_style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String deviceName;

  ProfilePage(this.deviceName, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePage(this.deviceName);

}

class _ProfilePage extends State<ProfilePage>{
  String deviceName;
  _ProfilePage(this.deviceName);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Stack(
                  children: <Widget>[
                    OpaqueImage(
                      imageUrl: "assets/images/polarbear.png",
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Home",
                                textAlign: TextAlign.left,
                                style: headingTextStyle,
                              ),
                            ),
                            MyInfo(deviceName),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  color: Colors.white,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "13",
                            secondText: "하루 전력 소모량 모니터링",
                            icon: Icon(
                              Icons.access_time,
                              size: 32,
                              color: greenColor,
                            ),
                          ),
                          ProfileInfoBigCard(
                              firstText: "21",
                              secondText: "한달 전력 소모량 모니터링",
                              icon: Icon(
                                  Icons.calendar_today_outlined,
                                  size:32,
                                  color:greenColor
                              )
                          ),
                        ],
                      ),

                      TableRow(
                        children: [
                          ProfileInfoBigCard(
                            firstText: "404",
                            secondText: "한달 기준 실시간 요금",
                            icon: Icon(
                              Icons.lightbulb_outline,
                              size: 32,
                              color: greenColor,
                            ),
                          ),
                          GestureDetector(
                            child: ProfileInfoBigCard(
                              firstText: "42",
                              secondText: "예상 대기 전력 차단량",
                              icon: Icon(
                                Icons.calculate_outlined,
                                size: 32,
                                color: greenColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * (4 / 9) - 80 / 2,
            left: 16,
            right: 16,
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //ProfileInfoCard(firstText: "54%", secondText: "Progress"),
                  SizedBox(
                    width: 50,
                  ),
                  ProfileInfoCard(
                    isButton : true,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}