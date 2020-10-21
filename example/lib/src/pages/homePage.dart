import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userContacts/userContacts.dart';
import 'contactPage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../components/contact_search.dart';
import '../components/contact_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person> contactsList;
  int _selectedIndex;
  final TextEditingController _controller = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Contacts',
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                  labelText: 'Search people',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                onTap: () async {
                  final Person result = await showSearch(
                      context: context, delegate: ContactSearch(contactsList));
                  selectContact(result, false);
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => selectContact(contactsList[_selectedIndex], true),
        child: Icon(Icons.check),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: FutureBuilder(
        future: UserContacts().getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          contactsList = snapshot.data;

          return ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ContactCard(
                contact: snapshot.data[index],
                isSelected: index == _selectedIndex,
                onTap: () {
                  _selectedIndex = index;
                  _controller.text = contactsList[index].fullName;
                  onCardTap(index);
                },
              );
            },
          );
        },
      ),
    );
  }

  void selectContact(Person contact, bool andScroll) {
    if (contact != null) {
      int index = contactsList.indexWhere((element) => element == contact);
      _controller.text = contact.fullName;
      setState(
        () {
          _selectedIndex = index;
        },
      );

      if (andScroll) {
        _animateToIndex(index);
      }
    }
  }

  void onCardTap(int itemIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contactsList[itemIndex],
        ),
      ),
    );
  }

  _animateToIndex(i) => _scrollController.jumpTo(index: _selectedIndex);
}
