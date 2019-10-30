import 'package:flutter/material.dart';
import 'dart:convert';


class ContactsInfoRequest {
  final String module;
  final String method;
  final String storage;

  ContactsInfoRequest({
    @required this.module,
    @required this.method,
    @required this.storage
  });

  Map<String, String> toJSON(){
    final parameters = json.encode({'Storage': storage});
    return {'Module': module, 'Method': method, 'Parameters': parameters};
  }
}