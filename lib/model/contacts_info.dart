class ContactsInfo {
  final String uuid;
  final String etag;

  ContactsInfo(
    this.uuid,
    this.etag,
  );

  ContactsInfo.fromJSON(Map<String, dynamic> json)
      : uuid = json['UUID'],
        etag = json['ETag'];
}