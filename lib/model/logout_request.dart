import 'package:flutter/material.dart';


class LogOutRequest {
  final String module;
  final String method;

  LogOutRequest({
    @required this.module,
    @required this.method
  });

  Map<String, String> toJSON(){
    return {'Module': module, 'Method': method};
  }
}