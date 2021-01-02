import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exploring Stateful Widget",
      home: FavoriteCity(),
    ),
  );
}

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavCity();
  }
}

class _FavCity extends State<FavoriteCity> {
  String nameOfCity = '';
  String _currentItemSelected = 'Rupees';
  List<String> _currencies = ['Rupees', 'Dollars', 'Others'];

  @override
  Widget build(BuildContext context) {
    debugPrint("Widget is created");
    return Scaffold(
      appBar: AppBar(title: Text("Stateful App Example")),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(children: [
          TextField(
            onSubmitted: (String userInput) {
              setState(() {
                debugPrint("setState is called");
                nameOfCity = userInput;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Text("Your favorite city is $nameOfCity"),
          ),
          DropdownButton<String>(
            items: _currencies.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              setState(() {
                this._currentItemSelected = newValueSelected;
              });
            },
            value: _currentItemSelected,
          )
        ]),
      ),
    );
  }
}
