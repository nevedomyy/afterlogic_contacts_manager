import 'package:flutter/material.dart';
import '../bloc/bloc_login.dart';
import '../model/login_response.dart';
import 'contacts_page.dart';
import 'text_style.dart';
import 'stencil.dart';
import 'color.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwController = TextEditingController();
  TextStyle _textStyle = AppTextStyle.text1;

  @override
  dispose() {
    super.dispose();
    blocLogin.dispose();
    _loginController.dispose();
    _passwController.dispose();
  }

  _signIn() async{
    bool getIn = await blocLogin.getAuthToken(_loginController.text, _passwController.text);
    if(getIn) Navigator.push(context, MaterialPageRoute(
      builder: (context) => ContactsPage()
    ));
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
                'Contacts Manager',
                style: AppTextStyle.title,
              ),
            ),
            Spacer()
          ],
        ),
      ),
      child: StreamBuilder(
        stream: blocLogin.subject.stream,
        builder: (context, AsyncSnapshot<LoginResponse> snapshot){
          if(snapshot.hasData){
            _textStyle = snapshot.data.textStyle ?? AppTextStyle.text1;
          }
          return Column(
            children: <Widget>[
              Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  onChanged: (value) => blocLogin.setGreyColor(),
                  controller: _loginController,
                  cursorColor: AppColor.text,
                  style: _textStyle,
                  decoration: InputDecoration(
                    labelText: 'login',
                    labelStyle: AppTextStyle.text1,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(color: Colors.white),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextField(
                  onChanged: (value) => blocLogin.setGreyColor(),
                  controller: _passwController,
                  cursorColor: AppColor.text,
                  style: _textStyle,
                  decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle: AppTextStyle.text1,
                    border: InputBorder.none
                  ),
                  obscureText: true,
                ),
              ),
              Divider(color: Colors.white),
              Spacer(flex: 1),
              Divider(color: Colors.white, thickness: 5.0),
              SizedBox(
                height: 100.0,
                child: Center(
                  child: Ink(
                    child: InkWell(
                      onTap: () => _signIn(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                        child: Text(
                          'SIGN IN',
                          style: AppTextStyle.text1,
                        ),
                      ),
                    ),
                  )
                ),
              )
            ],
          );
        },
      )
    );
  }
}