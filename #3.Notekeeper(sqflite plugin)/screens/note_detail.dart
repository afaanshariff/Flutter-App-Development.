import 'package:flutter/material.dart';
import 'package:Notekeeper/models/note.dart';
import 'package:Notekeeper/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  _NoteDetailState createState() =>
      _NoteDetailState(this.note, this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;
  _NoteDetailState(this.note, this.appBarTitle);
  List<String> _priorities = ['Low', 'Medium', 'High'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              moveToLastScreen();
            },
          ),
          title: Text(appBarTitle),
        ),
        body: getNoteDetail(),
      ),
    );
  }

  getNoteDetail() {
    //String _currentItemSelected = '';
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return ListView(
      children: <Widget>[
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: titleController,
            style: textStyle,
            onChanged: (value) {
              print('something has changed in title');
              updateTitle();
            },
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                gapPadding: 20.0,
              ),
            ),
          ),
        ),
        //SizedBox(height: 2.0),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: descriptionController,
            /*
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter description";
              }
            },*/
            style: textStyle,
            onChanged: (value) {
              print('something has changed in description field');
              updateDescription();
            },
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        ListTile(
          leading: Text(
            'Select Priority',
            textScaleFactor: 1.28,
          ),
          title: DropdownButton(
            items: _priorities.map((String dropDownStringItem) {
              return DropdownMenuItem(
                child: Text(dropDownStringItem),
                value: dropDownStringItem,
              );
            }).toList(),
            value: getPriorityAsString(note.priority),
            onChanged: (valueSelectedByUser) {
              setState(() {
                //this._currentItemSelected = valueSelectedByUser;
                print('User selected $valueSelectedByUser');
                updatePriorityAsInt(valueSelectedByUser);
              });
            },
          ),
        ),
        //SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Theme.of(context).bottomAppBarColor,
            child: Text(
              'Save',
              textScaleFactor: 1.5,
            ),
            onPressed: () {
              debugPrint('Save button pressed');
              _save();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Theme.of(context).backgroundColor,
            child: Text(
              'Delete',
              textScaleFactor: 1.5,
            ),
            onPressed: () {
              debugPrint('Delete button pressed');
              _delete();
            },
          ),
        ),
      ],
    );
  }

  // Convert the string priority into int form before saving it to the database.
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Low':
        note.priority = 3;
        break;

      case 'Medium':
        note.priority = 2;
        break;

      case 'High':
        note.priority = 1;
        break;
    }
  }

  // Convert int priority to string and display it to the user.
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[2]; // High
        break;

      case 2:
        priority = _priorities[1]; // High
        break;

      case 3:
        priority = _priorities[0]; // High
        break;
    }
    return priority;
  }

  // Update the title of Note object.
  void updateTitle() {
    note.title = titleController.text;
  }

  // Update the description of Note object.
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to the database.
  void _save() async {
    // Whenever we save data we've to navigate back to notelist page.
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    // To check whether the operation was successfull or not.
    int result;
    if (note.id != null) {
      // Case 1: Update operation.
      result = await helper.updateNote(note);
      print('case1 $result');
    } else {
      // Case 2: Insert operation.
      result = await helper.insertNote(note);
      print('case2 $result');
    }
    print('result is $result');
    print(
        'data = ${note.date}, id = ${note.id}, title = ${note.title}, desc = ${note.description}, priority = ${note.priority}');

    if (result != 0) {
      // Success.
      _showAlertDialog('Status', 'Note saved successfully');
    } else {
      // Failure.
      _showAlertDialog('Status', 'Problem saving the note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog,
    );
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted.');
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
    // The true here will be returned to note_list.dart navigateToDetail() to
    //  variable bool result value.
  }
}
