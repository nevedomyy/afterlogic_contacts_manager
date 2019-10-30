class ContactsStorage {
  final String id;
  final String name;
  final int cTag;

  ContactsStorage(
    this.id,
    this.name,
    this.cTag,
  );

  ContactsStorage.fromJSON(Map<String, dynamic> json)
      : id = json['Id'],
        name = json['Name'],
        cTag = json['CTag'];
}