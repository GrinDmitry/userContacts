import 'package:flutter/material.dart';
import 'package:userContacts/userContacts.dart';

class ContactImage extends StatelessWidget {
  final double radius;
  final double textSize;

  const ContactImage({
    Key key,
    @required this.textSize,
    @required this.radius,
    @required this.contact,
  }) : super(key: key);

  final Person contact;

  @override
  Widget build(BuildContext context) {
    if (contact.imageData != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: Image(
          image: MemoryImage(contact.imageData),
          fit: BoxFit.fill,
        ).image,
      );
    } else {
      return Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            contact.getInitials(),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: textSize),
          ),
        ),
      );
    }
  }
}
