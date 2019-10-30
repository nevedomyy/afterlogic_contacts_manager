import 'package:flutter/material.dart';


class AuthorizationCheckRequest {
  final String module;
  final String method;

  AuthorizationCheckRequest({
    @required this.module,
    @required this.method
  });

  Map<String, String> toJSON(){
    return {'Module': module, 'Method': method};
  }
}