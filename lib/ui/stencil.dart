import 'package:flutter/material.dart';
import 'color.dart';


class AppStencil extends StatelessWidget{
  final Widget column;
  final Widget child;

  AppStencil({
    @required this.column,
    @required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            column,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [AppColor.bgr2, AppColor.bgr1],
                  )
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}