import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_exam/screen/cart_page/view/cart_page.dart';
import 'package:re_exam/screen/home_page/view/home_page.dart';

void main()
{
  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(p0) => Home_Page(),
        'Addcart':(p0) => Cart_Page(),
      },
    )
  );
}