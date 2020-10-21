import 'package:flutter/material.dart';
import 'package:userContacts/userContacts.dart';
import '../components/contact_image.dart';

class ContactPage extends StatelessWidget {
  final Person contact;

  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepPurple[900]),
        title: Text(contact.fullName,
            style: TextStyle(
              color: Colors.deepPurple[900],
            )),
      ),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: ContactImage(
                      contact: contact, radius: 100.0, textSize: 48),
                ),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      itemCount: contact.phones.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(contact.phones[index]),
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }
}
