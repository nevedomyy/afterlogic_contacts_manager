import 'package:flutter/material.dart';
import 'dart:convert';


class ContactsByIdRequest {
  final String module;
  final String method;
  final String storage;
  final List<String> uids;

  ContactsByIdRequest({
    @required this.module,
    @required this.method,
    @required this.storage,
    @required this.uids
  });

  Map<String, String> toJSON(){
    final parameters = json.encode({'Storage': storage, 'Uids': uids});
    return {'Module': module, 'Method': method, 'Parameters': parameters};
  }
}