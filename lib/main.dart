import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, int> _measuresMap = {
    'Meters': 0,
    'kilometers': 1,
    'Grams': 2,
    'kilograms': 3,
    'Feet': 4,
    'Miles': 5,
    'pounds(lbs)': 6,
    'Ounces': 7
  };
  final Map<String, List<double>> _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  String _userSelectTo = 'kilometers';
  String _userSelectFrom = 'Meters';
  double? _userInputNumber;
  String _convertedValue = '';
  var fruits = ['Orange', 'Banana', 'Apple'];
  final List<String> _measures = [
    'Meters',
    'kilometers',
    'Grams',
    'kilograms',
    'Feet',
    'Miles',
    'pounds(lbs)',
    'Ounces',
  ];
  final TextStyle inputStyle = TextStyle(fontSize: 20, color: Colors.blue[900]);
  final TextStyle labelStyle = TextStyle(fontSize: 24, color: Colors.grey[700]);
  String convert(double value, String userSelectTo, String userSelectFrom) {
    int nFrom = _measuresMap[userSelectFrom]!;
    int nTo = _measuresMap[userSelectTo]!;
    double multiplyFactor = _formulas[nFrom.toString()]![nTo];
    var result = value * multiplyFactor;
    if (result == 0) {
      return 'This conversion can not be performed';
    } else {
      return result.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Measures Converter'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Value',
                style: labelStyle,
              ),
              const Spacer(),
              TextField(
                style: inputStyle,
                decoration: const InputDecoration(
                    hintText: 'Please insert the measure to be converted'),
                onChanged: (String value) {
                  var vr = double.tryParse(value);
                  if (vr != null && int.parse(value[0]) != 0) {
                    setState(() {
                      _userInputNumber = vr;
                      _convertedValue = '';
                    });
                  } else {
                    setState(() {
                      _convertedValue = 'Please Enter a correct number';
                    });
                  }
                },
              ),
              const Spacer(),
              Text(
                'From',
                style: labelStyle,
              ),
              // const Spacer(),
              //from DropDownButton
              DropdownButton(
                isExpanded: true,
                value: _userSelectFrom,
                items: _measures
                    .map((String measure) => DropdownMenuItem(
                          value: measure,
                          child: Text(
                            measure,
                            style: inputStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (String? userselect) {
                  setState(() {
                    _userSelectFrom = userselect ?? '';
                  });
                },
              ),
              const Spacer(),
              Text(
                'To',
                style: labelStyle,
              ),
              // const Spacer(),
              //TO userDownDownButton
              // buildDropDownButton(_measures, _userSelectTo),
              DropdownButton(
                isExpanded: true,
                value: _userSelectTo,
                items: _measures
                    .map((String measure) => DropdownMenuItem(
                          value: measure,
                          child: Text(
                            measure,
                            style: inputStyle,
                          ),
                        ))
                    .toList(),
                onChanged: (String? userselect) {
                  setState(() {
                    _userSelectTo = userselect ?? '';
                  });
                },
              ),
              const Spacer(
                flex: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_userSelectFrom != '' &&
                      _userSelectTo != '' &&
                      _userInputNumber != null) {
                    setState(() {
                      _convertedValue = convert(
                          _userInputNumber!, _userSelectTo, _userSelectFrom);
                    });
                  }
                },
                child: Text(
                  'Convert',
                  style: inputStyle,
                ),
              ),

              Text(
                ' $_convertedValue',
                style: labelStyle,
              ),

              const Spacer(
                flex: 8,
              )
            ],
          ),
        ),
      ),
    );
  }

  // DropdownButton buildDropDownButton(
  //     List<String> measures, String userSelectTo) {
  //   return DropdownButton(
  //     isExpanded: true,
  //     value: userSelectTo,
  //     items: measures
  //         .map((String measure) => DropdownMenuItem(
  //               value: measure,
  //               child: Text(
  //                 measure,
  //                 style: inputStyle,
  //               ),
  //             ))
  //         .toList(),
  //     onChanged: (value) {
  //       setState(() {
  //         userSelectTo = value;
  //       });
  //     },
  // );
  // }
}
