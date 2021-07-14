import 'package:flutter/material.dart';
import 'package:helloworld/src/config/app_colors.dart';

PreferredSizeWidget appBarMain(String text, BuildContext context) {
  return AppBar(
    title: Text(text, style: TextStyle(color: Colors.black)),
    backgroundColor: Colors.white,
  );
}

PreferredSizeWidget appBarHome(String text, BuildContext context) {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(text, style: TextStyle(color: Colors.white));
  return AppBar(
    // leading: IconButton(
    //   icon: Icon(Icons.menu),
    //   onPressed: () {},
    // ),
    actions: <Widget>[
      IconButton(onPressed: () {}, icon: cusIcon),
      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
    ],
    title: cusSearchBar,
    backgroundColor: colorDarkGreen,
  );
}

InputDecoration textFieldInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: colorLightGray),
    fillColor: Colors.white,
    filled: true,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
        borderSide: new BorderSide(width: 1, color: Colors.white)),
  );
}

Widget button(
    context, String text, TextStyle textStyle, ButtonStyle buttonStyle) {
  return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 100.0,
      child: TextButton(
          onPressed: () {
            print('REGISTER');
          },
          child: Text(
            text,
            style: textStyle,
          ),
          style: buttonStyle));
}

TextStyle hindTextStyle() {
  return TextStyle(
    color: colorGray,
    fontSize: 18,
  );
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}
