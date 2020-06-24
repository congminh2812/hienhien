
import 'package:flutter/material.dart';
import 'package:flutter_hienhien/helper/enum_selector.dart';
import 'package:flutter_hienhien/pages/listpage/list_page.dart';

class ButtonIcons extends StatelessWidget {
  final List<List<Object>> buttonText;
  ButtonIcons({@required this.buttonText});

  List<Widget> iconWithText(BuildContext context) {
    return buttonText.map((text) {
      return GestureDetector(
        child: Column(
          children: <Widget>[
            Image.asset(
              text[0],
              width: 50,
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(text[1],
                  style: TextStyle(
                      color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListPage(text[1], text[2])));
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: iconWithText(context),
      alignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
