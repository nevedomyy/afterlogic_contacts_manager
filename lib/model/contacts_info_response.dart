import 'contacts_info.dart';


class ContactsInfoResponse {
  final List<ContactsInfo> list;
  final int cTag;
  final String error;

  ContactsInfoResponse(
    this.list,
    this.cTag,
    this.error
  );

  ContactsInfoResponse.fromJSON(Map<String, dynamic> json)
      : list = (json['Result']['Info'] as List).map((i) => ContactsInfo.fromJSON(i)).toList(),
        cTag = json['Result']['CTag'],
        error = '';

  ContactsInfoResponse.withError(String error)
      : list = List(),
        cTag = 0,
        error = error;
}