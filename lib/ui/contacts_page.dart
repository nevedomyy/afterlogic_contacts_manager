import 'package:flutter/material.dart';
import '../bloc/bloc_contacts.dart';
import '../bloc/bloc_login.dart';
import '../model/contacts_byId_response.dart';
import '../model/contacts_storage_response.dart';
import '../model/contact.dart';
import '../repository/repository.dart';
import 'contacts_list_item.dart';
import 'storage_list_item.dart';
import 'circular_loader.dart';
import 'personal_page.dart';
import 'text_style.dart';
import 'error_page.dart';
import 'color.dart';
import 'stencil.dart';


class ContactsPage extends StatefulWidget {
   @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> with TickerProviderStateMixin{
  final BlocContacts _blocContacts = BlocContacts();
  AnimationController _animationController;
  Animation<double> _animateIcon;
  bool _showMenuTap = false;

  @override
  initState() {
    super.initState();
    _blocContacts.init();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150)
    )..addListener((){setState(() {});});
    _animateIcon = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(_animationController);
  }

  @override
  dispose() {
    super.dispose();
    _blocContacts.dispose();
    _animationController.dispose();
  }

  _logOut() async{
    await storage.deleteAll();
    blocLogin.logOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  _showMenu() async{
    _showMenuTap = !_showMenuTap;
    if (_animationController.isCompleted) _animationController.reverse();
    else _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AppStencil(
      column: Row(
        children: <Widget>[
          SizedBox(
            width: 60.0,
            child: StreamBuilder(
              stream: _blocContacts.contactsById.stream,
              builder: (context, AsyncSnapshot<ContactsByIdResponse> snapshot){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    RotatedBox(
                      quarterTurns: 3,
                      child: snapshot.hasData && snapshot.data.error == '' 
                        ? Text('${snapshot.data.list[0].storage} / Contacts', style: AppTextStyle.title)
                        : Text('Contacts', style: AppTextStyle.title)
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => _logOut(),
                      icon: Icon(Icons.exit_to_app),
                      color: AppColor.header,
                      iconSize: 30.0,
                    ),
                    IconButton(
                      onPressed: () {
                        if(snapshot.hasData && snapshot.data.error == '') _blocContacts.refresh(snapshot.data.list[0].storage);
                      },
                      icon: Icon(Icons.refresh),
                      color: AppColor.header,
                      iconSize: 30.0,
                    ),
                    IconButton(
                        onPressed: () => _showMenu(),
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _animateIcon,
                          color: AppColor.header,
                          size: 30.0,
                        )
                    ),
                    SizedBox(height: 20.0)
                  ],
                );
              },
            )
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            width: _showMenuTap ? 150.0 : 0.0,
            child: _showMenuTap && _animationController.isCompleted
                ? StreamBuilder(
                    stream: _blocContacts.contactsStorage.stream,
                    builder: (context, AsyncSnapshot<ContactsStorageResponse> snapshot){
                      if (snapshot.hasData && snapshot.data.error == ''){
                        return Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: ListView.builder(
                            itemCount: snapshot.data.list.length,
                            itemBuilder: (context, index){
                              return StorageListItem(
                                onTap: () {
                                  _blocContacts.changeStorage(snapshot.data.list[index].id);
                                  _showMenu();
                                },
                                storage: snapshot.data.list[index].name,
                              );
                            },                          
                          ),
                        );
                      } return Container();
                    },
                  )
                : Container() 
          ),
        ],
      ),
      child: StreamBuilder(
        stream: _blocContacts.contactsById.stream,
        builder: (context, AsyncSnapshot<ContactsByIdResponse> snapshot){
          if (snapshot.hasData){
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return ErrorPage(
                text: snapshot.data.error,
              );
            }
            return ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index){
                return Divider(color: Colors.white, thickness: 5.0);
              },
              itemCount: snapshot.data.list.length,
              itemBuilder: (context, index){
                Contact contact = snapshot.data.list[index];
                return ListItem(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PersonalPage(
                      contact: contact,
                    )
                  )),
                  name: contact.fullName ?? '',
                  mail: contact.primaryEmail.toString() ?? '',
                );
              }
            );
          }else if (snapshot.hasError){
            return ErrorPage(
              text: snapshot.error,
            );
          }else return CircularLoader();
        }
      ),
    );
  }
}