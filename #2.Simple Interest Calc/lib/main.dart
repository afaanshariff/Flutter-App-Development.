import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SI Calculator',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('SI Calculator')),
        body: SICalc(),
      ),
    ),
  );
}

Widget moneyImageAsset() {
  AssetImage assetImage = AssetImage('images/money.png');
  Image image = Image(image: assetImage, width: 250.0, height: 200.0);
  return Container(child: image, padding: EdgeInsets.all(10.0));
}

class SICalc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SICalc();
  }
}

class _SICalc extends State<SICalc> {
  List<String> _currencies = ['Rupees', 'Dollars', 'Others'];
  String _currentItemSelected = '';
  String _displayResult = '';
  var _formKey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            moneyImageAsset(),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: principalController,
                validator: (String userInput) {
                  if (userInput.isEmpty) {
                    return 'Please enter principal amount';
                  }
                },
                style: textStyle,
                decoration: InputDecoration(
                  labelText: 'Principal amount',
                  hintText: 'Enter principal amount. Ex: 1200',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: roiController,
                validator: (String userInput) {
                  if (userInput.isEmpty) {
                    return 'Please enter rate of interest';
                  }
                },
                style: textStyle,
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'Enter rate of interest. Ex: 2',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: termController,
                      validator: (String userInput) {
                        if (userInput.isEmpty) {
                          return 'Please enter term';
                        }
                      },
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Enter term in years. Ex: 3',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    style: textStyle,
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
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.5, right: 2.5),
                    child: RaisedButton(
                      //color: Colors.blueGrey,
                      color: Theme.of(context).accentColor,
                      textColor: Colors.black,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            this._displayResult = _calculateReturns();
                          }
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.5, right: 2.5),
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      //color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        _reset();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('$_displayResult'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  String _calculateReturns() {
    double principal = double.parse(principalController.text);
    double rateOfInterest = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double result = principal + (principal * rateOfInterest * term) / 100;

    return 'After $term years, your investment will be worth $result $_currentItemSelected.';
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    this._currentItemSelected = _currencies[0];
  }
}
