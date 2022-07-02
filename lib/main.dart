import 'package:SQFlite/pages/home_page.dart';
import 'package:SQFlite/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main ()=> runApp(new MyApp());

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  final routes = {
    '/login':(BuildContext context) => new LogInPage(),
    '/home':(BuildContext context) => new HomePage(),
    '/':(BuildContext context) => new LogInPage(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: ' Flutter SQFlite',
      theme: new ThemeData(primarySwatch: Colors.blueGrey),
      routes: routes,
    );

  }
}
