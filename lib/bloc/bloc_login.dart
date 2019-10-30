import 'package:rxdart/rxdart.dart';
import '../repository/repository.dart';
import '../model/login_response.dart';
import '../ui/text_style.dart';


class BlocLogin {
  final BehaviorSubject<LoginResponse> _subject = BehaviorSubject<LoginResponse>();

  BehaviorSubject<LoginResponse> get subject => _subject;

  Future<bool> getAuthToken(String login, String password) async{
    LoginResponse response = await repository.getAuthToken(login, password);
    _subject.add(response);
    if(response.authToken.length > 10){
      await storage.write(key: 'authToken', value: response.authToken);
      await storage.write(key: 'login', value: login);
      await storage.write(key: 'password', value: password);
      return true;
    }  
    return false;
  }

  getNewToken() async{
    String login = await storage.read(key: 'login');
    String password = await storage.read(key: 'password');
    LoginResponse response = await repository.getAuthToken(login, password);
    if(response.authToken.length > 10){
      await storage.write(key: 'authToken', value: response.authToken);
    }
  }

  authorizationCheck() async{
    String authToken = await storage.read(key: 'authToken');
    bool isAuth = await repository.authorizationCheck(authToken);
    if(!isAuth) await getNewToken();
  }

  logOut() async{
    String authToken = await storage.read(key: 'authToken');
    await repository.logOut(authToken);
  }

  setGreyColor() async{
    _subject.add(LoginResponse(_subject.value.authToken, AppTextStyle.text1));
  }

  dispose() => _subject.close();
}

final BlocLogin blocLogin = BlocLogin();