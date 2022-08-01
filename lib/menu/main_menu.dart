import 'dart:ffi';

import 'package:cdic_2022/menu/menu_card.dart';
import 'package:cdic_2022/menu/opaque_image.dart';
import 'package:cdic_2022/styles/colors.dart';
import 'package:flutter/material.dart';

import '../styles/text_style.dart';

class mainMenu extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Stack(
                children: <Widget>[
                  OpaqueImage(imageUrl: 'assets/images/polarbear.png'),
                  SafeArea(
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "My Profile",
                                    textAlign: TextAlign.left,
                                    style: headingTextStyle,
                                  ),
                                ),
                              ]
                          )
                      )
                  )
                ],
              )
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
                        MenuCards(
                          firstText: "oneone",
                          secondText: "twotwo",
                          icon: Icon(
                            Icons.star,
                            size: 32,
                            color: blueColor,
                          ),
                        ),
                        MenuCards(
                          firstText: "threethree",
                          secondText: "fourfour",
                          icon: Icon(
                            Icons.ac_unit,
                            size: 32,
                            color: blueColor,
                          ),
                        ),
                      ]
                  ),
                  TableRow(
                    children: [
                      MenuCards(
                        firstText: "fivefive",
                        secondText: "sixsix",
                        icon: Icon(
                          Icons.airline_seat_individual_suite,
                          size: 32,
                          color: blueColor,
                        ),
                      ),
                      MenuCards(
                        firstText: "sevenseven",
                        secondText: "eighteight",
                        icon: Icon(
                          Icons.flag,
                          size: 32,
                          color: blueColor,
                        ),

                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      //   Positioned(
      //     top: screenHeight * (4 / 9) - 80 / 2,
      //     left: 16,
      //     right: 16,
      //     child: Container(
      //       height: 80,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         mainAxisSize: MainAxisSize.max,
      //         children: <Widget>[
      //           ProfileInfoCard(firstText: "54%", secondText: "Progress"),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           ProfileInfoCard(
      //             hasImage: true,
      //             imagePath: "assets/icons/pulse.png",
      //           ),
      //           SizedBox(
      //             width: 10,
      //           ),
      //           ProfileInfoCard(firstText: "152", secondText: "Level"),
      //       ],
      //       ),
      //     ),
      //   ),
      //   ],
      // ),
      // );
    );
  }
}