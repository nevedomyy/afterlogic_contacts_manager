import 'package:flutter/material.dart';
import '../ui/text_style.dart';


class LoginResponse {
  final String authToken;
  final TextStyle textStyle;

  LoginResponse(
    this.authToken,
    this.textStyle
  );

  LoginResponse.fromJSON(Map<String, dynamic> json)
    : authToken = json['Result']['AuthToken'],
      textStyle = AppTextStyle.text1;
  
  LoginResponse.withError()
    : authToken = '',
      textStyle = AppTextStyle.text1red;
}