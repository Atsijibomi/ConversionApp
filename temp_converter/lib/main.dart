import 'package:flutter/material.dart';

void main() => runApp(const MyTemperatureConversionApp());

class MyTemperatureConversionApp extends StatefulWidget {
  const MyTemperatureConversionApp({super.key});

  @override
  _MyTemperatureConversionAppState createState() =>
      _MyTemperatureConversionAppState();
}

class _MyTemperatureConversionAppState
    extends State<MyTemperatureConversionApp> {
  String _conversionType = 'Convert from Fahrenheit';
  String _tempValue = '';
  String _convertedValue = '';
  String _conversionName = '';
  final List<String> _history = [];

  void _convertTemperature() {
    double? temp = double.tryParse(_tempValue);
    if (temp != null) {
      double convertedTemp;
      String conversionOperation;
      if (_conversionType == 'Convert from Fahrenheit') {
        convertedTemp = (temp - 32) * 5 / 9;
        conversionOperation = 'Fahrenheit';
        _conversionName = 'Celsius';
      } else {
        convertedTemp = temp * 9 / 5 + 32;
        conversionOperation = 'Celsius';
        _conversionName = 'Fahrenheit';
      }
      setState(() {
        _convertedValue = convertedTemp.toStringAsFixed(2);
        _history.insert(0,
            '$_tempValue $conversionOperation = $_convertedValue $_conversionName');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion App',
      home: Scaffold(
        backgroundColor: Colors.black, // Set background to black
        appBar: AppBar(
          title: const Text(
            'Converter',
            style: TextStyle(
              color: Colors.black, // Set text color to black
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white, // Change AppBar color to white
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Convert from',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      dropdownColor: Colors.black, // Dropdown background color
                      value: _conversionType,
                      onChanged: (String? newValue) {
                        setState(() {
                          _conversionType = newValue!;
                        });
                      },
                      items: <String>[
                        'Convert from Fahrenheit',
                        'Convert from Celsius',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white), // Dropdown text color
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (String value) {
                        setState(() {
                          _tempValue = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: _conversionType.contains('Fahrenheit')
                            ? 'Fahrenheit'
                            : 'Celsius',
                        labelStyle: const TextStyle(
                            color: Colors.white), // Set label text color
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // Set border color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // Set border color
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.white), // Set input text color
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: _convertTemperature,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Button text color
                    backgroundColor: Colors.white, // Button background color
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Convert',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conversion Result',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[800],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '$_tempValue $_conversionType = $_convertedValue $_conversionName',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'History',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _history.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            _history[index],
                            style: const TextStyle(
                                color: Colors.white), // Set history text color
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
