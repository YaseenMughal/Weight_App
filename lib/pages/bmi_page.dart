import 'dart:math';
import 'package:khuzapp/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double? deviceHeight, deviceWidth;
  int age = 25, weight = 100, height = 70, gender = 0;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
        child: Center(
      child: Container(
        height: deviceHeight! * 0.78,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ageSelectContainer(),
                weightSelectContainer(),
              ],
            ),
            heightSelectContainer(),
            genderSelectContainer(),
            calculateBMIBtn(),
          ],
        ),
      ),
    ));
  }

  Widget ageSelectContainer() {
    return Center(
      child: InfoCard(
        width: deviceWidth! * 0.45,
        height: deviceHeight! * 0.20,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Age yr',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              age.toString(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        age--;
                      });
                    },
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                    child: const Text('--'),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        age++;
                      });
                    },
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                    child: const Text('+'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget weightSelectContainer() {
    return Center(
      child: InfoCard(
        width: deviceWidth! * 0.45,
        height: deviceHeight! * 0.20,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Weight lbs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              weight.toString(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        weight--;
                      });
                    },
                    textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                    child: const Text('--'),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    onPressed: () {
                      setState(() {
                        weight++;
                      });
                    },
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                    child: const Text('+'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget heightSelectContainer() {
    return InfoCard(
      width: deviceWidth! * 0.90,
      height: deviceHeight! * 0.18,
      child: Column(
        children: [
          const Text(
            'Height in',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            height.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: deviceWidth! * 0.80,
            child: CupertinoSlider(
              min: 0,
              max: 96,
              divisions: 96,
              value: height.toDouble(),
              onChanged: (value) {
                setState(() {
                  height = value.toInt();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget genderSelectContainer() {
    return InfoCard(
      width: deviceWidth! * 0.90,
      height: deviceHeight! * 0.11,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: gender,
            children: const {
              0: Text("Male"),
              1: Text('Female'),
            },
            onValueChanged: (value) {
              setState(() {
                gender = value as int;
              });
            },
          )
        ],
      ),
    );
  }

  Widget calculateBMIBtn() {
    return Container(
      height: deviceHeight! * 0.07,
      child: CupertinoButton.filled(
        child: const Text('Calculate BMI'),
        onPressed: () {
          if (height > 0 && weight > 0 && age > 0) {
            double ibm = 703 * (weight / pow(height, 2));
            showResultDialog(ibm);
          }
        },
      ),
    );
  }

  void showResultDialog(double bmi) {
    String? status;
    if (bmi < 18.5) {
      status = "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      status = "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      status = "Overweight";
    } else if (bmi >= 30) {
      status = "Obese";
    }

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(status!),
          content: Text(bmi.toStringAsFixed(2)),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                saveResults(bmi.toString(), status!);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void saveResults(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'bmi_date',
      DateTime.now().toString(),
    );
    await prefs.setStringList(
      'bmi_data',
      <String>[
        bmi,
        status,
      ],
    );
  }
}
