import 'contacts_storage.dart';


class ContactsStorageResponse {
  final List<ContactsStorage> list;
  final String error;

  ContactsStorageResponse(
    this.list,
    this.error
  );

  ContactsStorageResponse.fromJSON(Map<String, dynamic> json)
      : list = (json['Result'] as List).map((i) => ContactsStorage.fromJSON(i)).toList(),
        error = '';

  ContactsStorageResponse.withError(String error)
      : list = List(),
        error = error;
}