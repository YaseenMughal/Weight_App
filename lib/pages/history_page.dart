import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:khuzapp/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  double? deviceHeight, deviceWidth;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    SharedPreferences.getInstance();

    return CupertinoPageScaffold(
      child: dataCard(),
    );
  }

  Widget dataCard() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final prefs = snapshot.data as SharedPreferences;
          final date = prefs.getString('bmi_date');
          final data = prefs.getStringList('bmi_data');
          return Center(
            child: InfoCard(
              width: deviceWidth! * 0.75,
              height: deviceHeight! * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  statusText(data![1]),
                  dateText(date!),
                  bmiText(data[0]),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }

  Widget statusText(String status) {
    return Text(
      status,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget dateText(String date) {
    DateTime parseDate = DateTime.parse(date);

    return Text(
      '${parseDate.day} / ${parseDate.month} / ${parseDate.year}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget bmiText(String bmi) {
    return Text(
      double.parse(bmi).toStringAsFixed(2),
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
