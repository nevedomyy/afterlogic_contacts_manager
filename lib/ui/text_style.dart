import 'package:flutter/material.dart';
import 'color.dart';


class AppTextStyle{
  static TextStyle get title => TextStyle(color: AppColor.header, fontSize: 30.0, fontFamily: 'SegoeUI');
  static TextStyle get header => TextStyle(color: AppColor.header, fontSize: 26.0, fontFamily: 'SegoeUI');
  static TextStyle get error => TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'SegoeUI');
  static TextStyle get text1 => TextStyle(color: AppColor.text, fontSize: 22.0, fontFamily: 'SegoeUI');
  static TextStyle get text2 => TextStyle(color: AppColor.header, fontSize: 16.0, fontFamily: 'SegoeUI');
  static TextStyle get text3 => TextStyle(color: AppColor.text, fontSize: 20.0, fontFamily: 'SegoeUI');
  static TextStyle get text1blank => TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'SegoeUI');
  static TextStyle get text2blank => TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'SegoeUI');
  static TextStyle get text1red => TextStyle(color: Colors.red[800], fontSize: 22.0, fontFamily: 'SegoeUI');
}