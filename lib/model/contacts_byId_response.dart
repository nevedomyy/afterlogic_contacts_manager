import 'contact.dart';


class ContactsByIdResponse {
  final List<Contact> list;
  final String error;

  ContactsByIdResponse(
    this.list,
    this.error
  );

  ContactsByIdResponse.fromJSON(Map<String, dynamic> json)
      : list = (json['Result'] as List).map((i) => Contact.fromJSON(i)).toList(),
        error = '';

  ContactsByIdResponse.withError(String error)
      : list = List(),
        error = error;
}