import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Exploring UI Widgets",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text("Long List")),
          body: getListView(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              debugPrint("FAB clicked");
            },
            splashColor: Colors.black,
            child: Icon(Icons.add),
            tooltip: 'Add an item',
          ), // FloatingActionButton
        ) //Scaffold
        ); // Container
  }

  List<String> getListElements() {
    var items = List<String>.generate(1000, (counter) => "Item ${counter + 1}");
    return items;
  }

  Widget getListView() {
    var listItems = getListElements();
    var listView = ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.audiotrack,
            color: Colors.black,
            size: 35.0,
          ), //Icon
          title: Text(listItems[index]),
          subtitle: Text('has bot $index'),
          onTap: () {
            //debugPrint('${listItems[index]} was tapped');
            showSnackBar(context, listItems[index]);
          }, //onTap
          trailing: Text('trailing icon/text can also be added'),
        ); //ListTile
      },
    ); //ListView.builder
    return listView;
  }

  void showSnackBar(BuildContext context, String item) {
    var snackBar = SnackBar(
        content: Text("You just tapped $item."),
        action: SnackBarAction(
            label: "UNDO",
            onPressed: () {
              debugPrint("Dummy UNDO");
            }) //SnackBarAction
        ); //SnackBar
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
