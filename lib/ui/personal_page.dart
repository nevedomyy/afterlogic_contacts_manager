import 'package:flutter/material.dart';
import '../repository/repository.dart';
import '../model/contact.dart';
import '../bloc/bloc_login.dart';
import 'text_style.dart';
import 'stencil.dart';
import 'color.dart';


class PersonalPage extends StatelessWidget{
  final Contact contact;

  PersonalPage({
    @required this.contact
  });

  Widget _item(IconData icon, var text){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: AppColor.header,
            size: 16.0,
          ),
          SizedBox(width: 5.0),
          Text(
            text.toString(),
            style: AppTextStyle.text3,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
          )
        ],
      ),
    );
  }

  _logOut(BuildContext context) async{
    await storage.deleteAll();
    blocLogin.logOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return AppStencil(
      column: SizedBox(
        width: 60.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                contact.fullName,
                style: AppTextStyle.title,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () => _logOut(context),
              icon: Icon(Icons.exit_to_app),
              color: AppColor.header,
              iconSize: 30.0,
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              color: AppColor.header,
              iconSize: 30.0,
            ),
            SizedBox(height: 20.0)
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          _item(Icons.alternate_email, contact.primaryEmail),
          Divider(color: Colors.white),
          _item(Icons.phone_android, contact.primaryPhone),
          Divider(color: Colors.white),
          _item(Icons.location_city, contact.primaryAddress),
          Divider(color: Colors.white),
          _item(Icons.link, contact.skype),
          Divider(color: Colors.white),
          _item(Icons.link, contact.facebook),
          SizedBox(height: 40.0),
          Divider(color: Colors.white, thickness: 5.0)
        ],
      ),
    );
  }
}