import 'package:flutter/material.dart';

class MenuPolarBear extends StatelessWidget{
  final bool flugOn;
  final String firstText, secondText;

  const MenuPolarBear({Key? key, required this.flugOn, required this.firstText, required this.secondText}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (flugOn == true){
      //북극곰 이미지 on
      //String imagePath =
    }else{
      //북극곰 이미지 off
      //String imagePath =
    }
    return Expanded(
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Image(
            image: AssetImage('images/polarbear.png'),
            color: Colors.green,
            width: 25,
            height: 25,
          ),
        )
      ),
    );
  }

}