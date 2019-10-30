import 'package:flutter/material.dart';


class ContactsStorageRequest {
  final String module;
  final String method;

  ContactsStorageRequest({
    @required this.module,
    @required this.method
  });

  Map<String, String> toJSON(){
    return {'Module': module, 'Method': method};
  }
}