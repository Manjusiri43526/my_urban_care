import 'package:flutter/material.dart';

Text customText(String text, double size, Color clr, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
        color: clr, fontSize: size, fontWeight: weight, fontFamily: "Inter"),
  );
}

Text customItalicText(String text, double size, Color clr, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
      color: clr,
      fontSize: size,
      fontWeight: weight,
      fontFamily: "Inter",
      fontStyle: FontStyle.italic,
    ),
  );
}

Text underLnTxt(String text, double size, Color clr, FontWeight weight) {
  return Text(
    text,
    style: TextStyle(
        color: clr,
        fontSize: size,
        fontWeight: weight,
        fontFamily: "Inter",
        decoration: TextDecoration.underline),
  );
}

Text paragraphText(
    String txt, double size, Color clr, FontWeight weight, TextAlign align) {
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
        color: clr, fontSize: size, fontWeight: weight, fontFamily: "Inter"),
  );
}

Text italicParagraphText(
    String txt, double size, Color clr, FontWeight weight, TextAlign align) {
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      color: clr,
      fontSize: size,
      fontWeight: weight,
      fontFamily: "Inter",
      fontStyle: FontStyle.italic,
    ),
  );
}

Widget listText(
    String text, double fontSize, Color color, FontWeight fontWeight) {
  return Text(
    '• $text',
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}
