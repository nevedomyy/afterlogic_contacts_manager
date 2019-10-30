import 'package:flutter/material.dart';
import 'dart:convert';


class LoginRequest {
  final String module;
  final String method;
  final String login;
  final String password;

  LoginRequest({
    @required this.module,
    @required this.method,
    @required this.login,
    @required this.password
  });

  Map<String, String> toJSON(){
    final parameters = json.encode({'Login': login, 'Password': password});
    return {'Module': module, 'Method': method, 'Parameters': parameters};
  }
}