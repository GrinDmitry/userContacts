part of user_contacts;

class Person {
  String givenName;
  String familyName;
  Uint8List imageData;
  List<String> phones;

  String get fullName => givenName + ' ' + familyName;
  String get nameInitinals => givenName[0] + familyName[0];

  Person(this.givenName, this.familyName, this.phones);

  String getInitials() {
    print(givenName);
    print(familyName);

    if (familyName.isNotEmpty && givenName.isNotEmpty) {
      return nameInitinals;
    }

    String nameInitials = '';

    if (givenName.isNotEmpty) {
      nameInitials = givenName[0];
    } else if (familyName.isNotEmpty) {
      nameInitials = familyName[0];
    } else if (familyName.isEmpty && givenName.isEmpty) {
      nameInitials = 'N/A';
    }

    return nameInitials;
  }

  Person.fromJson(Map<String, dynamic> json) {
    givenName = json['name'];
    familyName = json['familyName'];

    var phonesFromJson = json['phones'];
    List<String> phonesList = phonesFromJson.cast<String>();
    phones = phonesList;

    var bytes = json['imageData'];
    if (bytes != null) {
      imageData = base64Decode(bytes);
    } else {
      imageData = null;
    }
  }
}
