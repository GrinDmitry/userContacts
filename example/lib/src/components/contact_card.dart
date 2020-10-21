import 'package:flutter/material.dart';
import 'package:userContacts/userContacts.dart';
import 'contact_image.dart';

class ContactCard extends StatelessWidget {
  final Person contact;
  final bool isSelected;
  final VoidCallback onTap;
  ContactCard(
      {@required this.contact,
      @required this.isSelected,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        selected: isSelected,
        focusColor: Colors.cyan,
        selectedTileColor: Colors.deepPurple[100],
        onTap: onTap,
        leading: ContactImage(
          contact: contact,
          radius: 18,
          textSize: 18,
        ),
        title: Text(
          contact.fullName,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.deepPurple[900]),
        ),
      ),
    );
  }
}
