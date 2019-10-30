import 'package:http/http.dart' as http;
import '../model/authorization_check_request.dart';
import '../model/login_response.dart';
import '../model/login_request.dart';
import '../model/contacts_storage_response.dart';
import '../model/contacts_storage_request.dart';
import '../model/contacts_info_response.dart';
import '../model/contacts_info_request.dart';
import '../model/contacts_byId_response.dart';
import '../model/contacts_byId_request.dart';
import '../model/logout_request.dart';
import 'dart:convert';


class ApiProvider {
  static final String _api = 'https://test.afterlogic.com/?Api/';

  Future<LoginResponse> getAuthToken(String login, String password) async{
    try {
      var response = await http.post(_api, body: LoginRequest(
        module: 'Core',
        method: 'Login',
        login: login,
        password: password
      ).toJSON());
      var responseBody = json.decode(response.body);
      return LoginResponse.fromJSON(responseBody);
    } catch (e){
      return LoginResponse.withError();
    }
  }

  Future<ContactsStorageResponse> getContactsStorage(String authToken) async{
    try {
      var response = await http.post(_api, body: ContactsStorageRequest(
          module: 'Contacts',
          method: 'GetContactStorages',
      ).toJSON(), headers: {'Accept':'application/json', 'Authorization':'Bearer $authToken'});
      var responseBody = json.decode(response.body);
      return ContactsStorageResponse.fromJSON(responseBody);
    } catch (e){
      return ContactsStorageResponse.withError(e.toString());
    }
  }

  Future<ContactsInfoResponse> getContactsInfo(String authToken, String storage) async{
    try {
      var response = await http.post(_api, body: ContactsInfoRequest(
          module: 'Contacts',
          method: 'GetContactsInfo',
          storage: storage,
      ).toJSON(), headers: {'Accept':'application/json', 'Authorization':'Bearer $authToken'});
      var responseBody = json.decode(response.body);
      return ContactsInfoResponse.fromJSON(responseBody);
    } catch (e){
      return ContactsInfoResponse.withError(e.toString());
    }
  }

  Future<ContactsByIdResponse> getContactsById(String authToken, String storage, List<String> list) async{
    try {
      var response = await http.post(_api, body: ContactsByIdRequest(
          module: 'Contacts',
          method: 'GetContactsByUids',
          storage: storage,
          uids: list
      ).toJSON(), headers: {'Accept':'application/json', 'Authorization':'Bearer $authToken'});
      var responseBody = json.decode(response.body);
      return ContactsByIdResponse.fromJSON(responseBody);
    } catch (e){
      return ContactsByIdResponse.withError(e.toString());
    }
  }

  Future<bool> authorizationCheck(String authToken) async{
    try {
      var response = await http.post(_api, body: AuthorizationCheckRequest(
          module: 'Core',
          method: 'DoServerInitializations',
      ).toJSON(), headers: {'Accept':'application/json', 'Authorization':'Bearer $authToken'});
      return response.statusCode == 401 ? false : true;
    } catch (e){
      return false;
    }
  }

  logOut(String authToken) async{
    try {
      await http.post(_api, body: LogOutRequest(
        module: 'Core',
        method: 'Logout',
      ).toJSON(), headers: {'Accept':'application/json', 'Authorization':'Bearer $authToken'});
    } catch (e){}
  }
}