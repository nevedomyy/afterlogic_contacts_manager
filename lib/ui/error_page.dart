import 'package:flutter/material.dart';
import 'text_style.dart';


class ErrorPage extends StatelessWidget{
  final String text;

  ErrorPage({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          text,
          style: AppTextStyle.error,
        ),
      )
    );
  }
}