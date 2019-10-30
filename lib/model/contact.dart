class Contact {
  final String fullName;
  var primaryEmail;
  var primaryPhone;
  var primaryAddress;
  final String skype;
  final String facebook;
  final String storage;

  Contact(
    this.fullName,
    this.primaryEmail,
    this.primaryPhone,
    this.primaryAddress,
    this.skype,
    this.facebook,
    this.storage
  );

  Contact.fromJSON(Map<String, dynamic> json)
      : fullName = json['FullName'],
        primaryEmail = json['PrimaryEmail'],
        primaryPhone = json['PrimaryPhone'],
        primaryAddress = json['PrimaryAddress'],
        skype = json['Skype'],
        facebook = json['Facebook'],
        storage = json['Storage'];
}