import 'package:flutter/material.dart';
import 'text_style.dart';


class ListItem extends StatelessWidget{
  final Function onTap;
  final String name;
  final String mail;

  ListItem({
    @required this.onTap,
    @required this.name,
    @required this.mail
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name == '' ? 'No name' : name,
                  style: name == '' ? AppTextStyle.text1blank : AppTextStyle.text1,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
                Text(
                  mail == '' ? 'No email' : mail,
                  style: mail == '' ? AppTextStyle.text2blank : AppTextStyle.text2,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}