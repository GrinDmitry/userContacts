import 'package:flutter/material.dart';
import 'package:userContacts/userContacts.dart';
import 'contact_image.dart';

class ContactSearch extends SearchDelegate<Person> {
  final List<Person> list;

  ContactSearch(this.list);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var results =
        list.where((element) => element.fullName.toLowerCase().contains(query));

    return ListView(
      children: results
          .map<ListTile>(
            (contact) => ListTile(
              leading: ContactImage(
                contact: contact,
                radius: 18,
                textSize: 18,
              ),
              title: Text(contact.fullName),
              onTap: () {
                close(context, contact);
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var results =
        list.where((element) => element.fullName.toLowerCase().contains(query));

    return ListView(
      children: results
          .map<ListTile>(
            (e) => ListTile(
              title: Text(e.fullName),
              onTap: () {
                close(context, e);
              },
            ),
          )
          .toList(),
    );
  }
}
