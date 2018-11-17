import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController _age = new TextEditingController();
  final TextEditingController _height = new TextEditingController();
  final TextEditingController _weight = new TextEditingController();
  double bmi;

  String status;

  double optimalA;
  double optimalB;
  String optimal = "You're Awesome!";

  void calculateBmi() {
    setState(() {
      optimalA = 0.0;
      optimalB = 0.0;
      bmi = (double.parse(_weight.text) /
              (double.parse(_height.text) * double.parse(_height.text))) *
          10000;

      optimalA =
          (24.9 * (double.parse(_height.text) * double.parse(_height.text))) /
              10000;
      optimalB =
          (18.5 * (double.parse(_height.text) * double.parse(_height.text))) /
              10000;
      optimal =
          "You're Awesome!\nStill between\n(${optimalB.toStringAsFixed(2)} - ${optimalA.toStringAsFixed(2)})Kg";

      if (bmi < 18.5)
        status = "Underweight";
      else if (bmi >= 18.5 && bmi <= 24.9)
        status = "Normal weight";
      else if (bmi > 24.9 && bmi <= 29.9)
        status = "Overweight";
      else if (bmi > 29.9 && bmi <= 34.9)
        status = "Class I obese";
      else if (bmi > 34.9 && bmi <= 39.9)
        status = "Class II obese";
      else
        status = "Class III obese";

      if (bmi < 18.5)
        optimal =
            "Weight should increased between\n(${(optimalB - double.parse(_weight.text)).toStringAsFixed(2)} - ${(optimalA - double.parse(_weight.text)).toStringAsFixed(2)})Kg";
      else if (bmi > 24.9)
        optimal =
            "Weight should decreased between\n(${(double.parse(_weight.text) - optimalA).toStringAsFixed(2)} - ${(double.parse(_weight.text) - optimalB).toStringAsFixed(2)})Kg";

      _neverSatisfied();
    });
  }

  //Calculation: [weight (kg) / height (cm) / height (cm)] x 10,000
  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Your BMI Score Is',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${bmi.toStringAsFixed(2)}',
                  style: new TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$status',
                  style: new TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: double.parse(_weight.text) < optimalB
                          ? Colors.yellow.shade700
                          : double.parse(_weight.text) > optimalA
                              ? Colors.red.shade700
                              : Colors.green),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$optimal',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("BMI"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            new Image.asset(
              'images/bmilogo.png',
              width: 150.0,
              height: 150.0,
            ),
            new Container(
              color: Colors.white.withOpacity(0.4),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(15.0),
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _age,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Age",
                        labelStyle: TextStyle(fontSize: 18.0),
                        icon: new Icon(Icons.person_outline)),
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),
                  new TextField(
                    controller: _height,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Height",
                        labelStyle: TextStyle(fontSize: 18.0),
                        hintText: "In cm",
                        icon: new Icon(Icons.accessibility)),
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),
                  new TextField(
                    controller: _weight,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Weight",
                        labelStyle: TextStyle(fontSize: 18.0),
                        hintText: "In Kilogrames",
                        icon: new Icon(Icons.directions_run)),
                  ),
                  new Padding(padding: EdgeInsets.all(10.0)),
                  new IconButton(
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {
                      calculateBmi();
                    },
                    color: Colors.redAccent,
                    tooltip: "Calculate",
                    icon: new Image.asset('images/cal.png'),
                    iconSize: 80.0,
                  ),
                  new Text(
                    "Calculate",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
