// ignore_for_file: prefer_const_constructors

part of 'main.dart';

var theme = ThemeData(
  tabBarTheme: TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelStyle: TextStyle(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      elevation: 0,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Color.fromARGB(10, 0, 0, 0)),
      textStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(
          foreground: Paint()..color = Colors.black,
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Color(0xFFF44336)),
    headline4: TextStyle(
      fontSize: 30,
      color: Colors.black,
    ),
  ),
);
