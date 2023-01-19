import 'package:flutter/material.dart';

import 'dart:developer' as devtools;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timesheet',
      theme: ThemeData.dark(),
      home: const TimeSheet(),
    );
  }
}

class TimeSheet extends StatefulWidget {
  const TimeSheet({super.key});

  @override
  State<TimeSheet> createState() => _TimeSheetState();
}

class _TimeSheetState extends State<TimeSheet> {
  final currentYear = DateTime.now().year;

  // When switching weeks, Display Sunday - Saturday
  // Week of year
  void numberOfWeeksForYear(int currentYear) {
    final from = DateTime.utc(currentYear, 1, 1);
    final to = DateTime.utc(currentYear, 12, 31);
    devtools.log((to.difference(from).inDays / 7).ceil().toString());
  }

  void findFirstDayByWeekOfYear(int week) {
    // I need to find the 1st and last day for a given week number
    // week 1 - Jan 1 - 7
    // week 2 - Jan 8 - 14
    final lastDay = week * 7;
    final firstDay = lastDay - 6;

    final lastWeekDay = DateTime.utc(currentYear, 1, 1).add(Duration(days: lastDay - 1));

    final days = List.generate(7, (index) {
      return lastWeekDay.subtract(Duration(days: index));
    }).reversed;

    print(days);

    final firstWeekDay = lastWeekDay.subtract(const Duration(days: 6));
    // devtools.log('First Week Day $firstWeekDay');
    // devtools.log('Last Week Day: $lastWeekDay');

    // devtools.log('First Day: $firstDay');
    // devtools.log('Last Day: $lastDay');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timesheet'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                findFirstDayByWeekOfYear(53);
              },
              child: const Text('Test'),
            )
          ],
        ),
      ),
    );
  }
}
