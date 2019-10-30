import 'package:flutter/material.dart';
import 'text_style.dart';


class StorageListItem extends StatelessWidget{
  final Function onTap;
  final String storage;

  StorageListItem({
    @required this.onTap,
    @required this.storage
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Text(
              storage,
              style: AppTextStyle.text1,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
      ),
    );
  }
}