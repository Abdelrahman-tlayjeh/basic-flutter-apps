import 'package:bmi_app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:bmi_app/widgets/right_bars.dart';
import 'package:bmi_app/widgets/left_bars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double _resultNum = 0;
  String _resultStr = "";
  Color _resultColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(
            color: accentHexColor,
            fontWeight: FontWeight.w300,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        title: const Text("Settings"),
                        backgroundColor: accentHexColor,
                      ),
                      body: Center(
                        child: Text(
                          "Nothing here",
                          style: TextStyle(
                            color: accentHexColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: accentHexColor,
              size: 30,
            ),
          )
        ],
      ),
      backgroundColor: mainHexColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 130,
                  child: TextField(
                    controller: _heightController,
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: accentHexColor),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Height(cm)",
                      hintStyle: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: TextField(
                    controller: _weightController,
                    style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: accentHexColor),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Weight(kg)",
                      hintStyle: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () {
                debugPrint("Clicked!");
                double height;
                double weight;
                //clear old result
                _resultStr = "";
                _resultNum = 0;
                try {
                  height = double.parse(_heightController.text) / 100;
                  weight = double.parse(_weightController.text);
                } catch (e) {
                  //clear old result
                  setState(() {
                    _resultStr = "";
                    _resultNum = 0;
                  });
                  return;
                }
                //show result
                setState(() {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _resultNum = weight / (height * height);
                  if (_resultNum > 25) {
                    _resultStr = "Obese";
                    _resultColor = Colors.red;
                  } else if (_resultNum >= 18.5) {
                    _resultStr = "Normal";
                    _resultColor = Colors.green;
                  } else {
                    _resultStr = "Underweight";
                    _resultColor = Colors.red;
                  }
                });
              },
              child: Text(
                "Calculate",
                style: TextStyle(
                  fontSize: 22,
                  color: accentHexColor,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            //output nb//
            Visibility(
              visible: _resultStr.isNotEmpty,
              child: Text(
                _resultNum.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 40,
                  color: _resultColor,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //output msg//
            Text(
              _resultStr,
              style: TextStyle(
                fontSize: 32,
                color: _resultColor,
              ),
            ),
            //just decorations//
            const SizedBox(
              height: 30,
            ),
            const RightBars(),
            const SizedBox(
              height: 30,
            ),
            const LeftBars(),
          ],
        ),
      ),
    );
  }
}
