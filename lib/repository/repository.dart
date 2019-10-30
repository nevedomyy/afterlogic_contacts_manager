import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/login_response.dart';
import '../model/contacts_byId_response.dart';
import '../model/contacts_info_response.dart';
import '../model/contacts_storage_response.dart';
import 'api_provider.dart';


class Repository {
  final ApiProvider _provider = ApiProvider();

  Future<LoginResponse> getAuthToken(String login, String password) => _provider.getAuthToken(login, password);
  Future<ContactsStorageResponse> getContactsStorage(String authToken) => _provider.getContactsStorage(authToken);
  Future<ContactsInfoResponse> getContactsInfo(String authToken, String storage) => _provider.getContactsInfo(authToken, storage);
  Future<ContactsByIdResponse> getContactsById(String authToken, String storage, List<String> list) => _provider.getContactsById(authToken, storage, list);
  Future<bool> authorizationCheck(String authToken) => _provider.authorizationCheck(authToken);
  logOut(String authToken) => _provider.logOut(authToken);
}

final repository = Repository();
final storage = FlutterSecureStorage();