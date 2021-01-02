import 'package:flutter/material.dart';
import 'dart:math';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Container(
          padding:
              EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
          //margin: EdgeInsets.only(bottom:40.0),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Text(
                  "Flight ${generateNumber()} from Mysore to Bangalore.",
                  style: TextStyle(
                    fontFamily: 'Lemonada',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w100,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ), //Expandedfirst
              Expanded(
                child: Text(
                  "Flight ${generateNumber()} from Bangalore to UAE.",
                  style: TextStyle(
                    fontFamily: 'Lemonada',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w100,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ), //Expandedsecond
            ]), //Row
            FlightImageAsset(),
            FlightBookButton(),
          ]), //Column
        ), //Container
      ), // Center
    ); //Material
  }

  int generateNumber() {
    var n = Random().nextInt(10);
    return n;
  }
}

class FlightImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/flight.png');
    Image image = Image(image: assetImage, color: Colors.white);
    return Container(child: image);
  }
}

class FlightBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 50.0,
      margin: EdgeInsets.only(top: 200.0),
      child: RaisedButton(
        color: Colors.deepOrange,
        child: Text(
          "Book Your Flight",
          style: TextStyle(
            fontFamily: 'Lemonada',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w100,
            fontSize: 20.0,
            color: Colors.white,
          ), //TextStyle
        ), //Text
        elevation: 6.0, 
        onPressed: () => bookFlight(context),
      ), //RaisedButton
    ); //Container
  }

  void bookFlight(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Flight Booked Successfully"),
      content: Text("Have a pleasant flight"),
    ); // AlertDialog

    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog); //showDialog
  }
}
