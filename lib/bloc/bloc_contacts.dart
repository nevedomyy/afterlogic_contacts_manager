import 'package:rxdart/rxdart.dart';
import '../model/contacts_byId_response.dart';
import '../model/contacts_info_response.dart';
import '../model/contacts_storage_response.dart';
import '../repository/repository.dart';
import 'bloc_login.dart';


class BlocContacts {
  final BehaviorSubject<ContactsStorageResponse> _contactsStorage = BehaviorSubject<ContactsStorageResponse>();
  final BehaviorSubject<ContactsInfoResponse> _contactsInfo = BehaviorSubject<ContactsInfoResponse>();
  final BehaviorSubject<ContactsByIdResponse> _contactsById = BehaviorSubject<ContactsByIdResponse>();

  BehaviorSubject<ContactsStorageResponse> get contactsStorage => _contactsStorage;
  BehaviorSubject<ContactsByIdResponse> get contactsById => _contactsById;

  init() async{
    List<String> uuidList = List();
    try{
      String authToken = await storage.read(key: 'authToken');
      ContactsStorageResponse csResponse = await repository.getContactsStorage(authToken);
      ContactsInfoResponse ciResponse = await repository.getContactsInfo(authToken, csResponse.list[0].id);
      ciResponse.list.forEach((item){uuidList.add(item.uuid);});
      ContactsByIdResponse cbidResponse = await repository.getContactsById(authToken, csResponse.list[0].id, uuidList);
      _contactsStorage.add(csResponse);
      _contactsInfo.add(ciResponse);
      _contactsById.add(cbidResponse);
    }catch(e){
      _contactsStorage.add(ContactsStorageResponse.withError(e.toString()));
      _contactsInfo.add(ContactsInfoResponse.withError(e.toString()));
      _contactsById.add(ContactsByIdResponse.withError(e.toString()));
    }
  }

  refresh(String currentStorage) async{
    await blocLogin.authorizationCheck();
    Map<String, String> uuidMap = Map();
    List<String> uuidList = List();
    try{
      String authToken = await storage.read(key: 'authToken');
      ContactsInfoResponse ciResponse = await repository.getContactsInfo(authToken, currentStorage);
      if(_contactsInfo.value != null && _contactsInfo.value.cTag != ciResponse.cTag) {
        _contactsById.add(null);
        ciResponse.list.forEach((item){uuidList.add(item.uuid);});
        ContactsByIdResponse cbidResponse = await repository.getContactsById(authToken, currentStorage, uuidList);
        _contactsInfo.add(ciResponse);
        _contactsById.add(cbidResponse);
      }else{
        ciResponse.list.forEach((contactsInfo){uuidMap[contactsInfo.uuid] = contactsInfo.etag;});
        _contactsInfo.value.list.forEach((contactsInfo){
          if(uuidMap[contactsInfo.uuid] != contactsInfo.etag) uuidList.add(contactsInfo.uuid);
        });
        if (uuidList.isNotEmpty) {
          _contactsById.add(null);
          ContactsByIdResponse cbidResponse = await repository.getContactsById(authToken, currentStorage, uuidList);
          _contactsById.add(cbidResponse);
        }
      }
    }catch(e){
      _contactsInfo.add(ContactsInfoResponse.withError(e.toString()));
      _contactsById.add(ContactsByIdResponse.withError(e.toString()));
    }
  }

  changeStorage(String newStorage) async{
    await blocLogin.authorizationCheck();
    _contactsById.add(null);
    List<String> uuidList = List();
    try{
      String authToken = await storage.read(key: 'authToken');
      ContactsInfoResponse ciResponse = await repository.getContactsInfo(authToken, newStorage);
      ciResponse.list.forEach((item){uuidList.add(item.uuid);});
      ContactsByIdResponse cbidResponse = await repository.getContactsById(authToken, newStorage, uuidList);
      _contactsInfo.add(ciResponse);
      _contactsById.add(cbidResponse);
    }catch(e){
      _contactsInfo.add(ContactsInfoResponse.withError(e.toString()));
      _contactsById.add(ContactsByIdResponse.withError(e.toString()));
    }
  }

  dispose(){
    _contactsById.close();
    _contactsInfo.close();
    _contactsStorage.close();
  }
}