import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "Trip Cost Calculator",
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FuelForm(),
      ),
    );
  }
}

class FuelForm extends StatefulWidget {
  FuelForm({Key key}) : super(key: key);

  @override
  _FuelFormState createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _currencies = ['Dollars', 'Euro', 'Pounds', "Cordobas"];
  final double _formDistance = 5.0;
  String _currency = "Cordobas";
  TextEditingController distanceController = new TextEditingController();
  TextEditingController avgController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        //  backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                  hintText: "e.g. 124",
                  labelStyle: textStyle,
                  labelText: "Distance",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                  hintText: "e.g. 17",
                  labelStyle: textStyle,
                  labelText: "Distance per unit",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        hintText: "e.g. 1.65",
                        labelStyle: textStyle,
                        labelText: "Price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: _formDistance * 5,
                  ),
                  Expanded(
                    child: DropdownButton(
                      onChanged: _onDropDownChanged,
                      value: _currency,
                      items: _currencies
                          .map(
                            (String value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        result = _calculate();
                      });
                    },
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Submit',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _reset();
                    },
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            Text(result)
          ],
        ),
      ),
    );
  }

  void _onDropDownChanged(String value) {
    setState(() {
      _currency = value;
    });
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;
    String _result =
        'The total cost of your trip is ${_totalCost.toStringAsFixed(2)} $_currency';
    return _result;
  }
}
