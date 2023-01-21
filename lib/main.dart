import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools;

import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> categoryItems = [
  'Customer Project',
  'Internal Project',
  'Internal Activity',
  'Non Working Hours',
];

final selectionItems = [
  'Emanate',
  'HPPL',
  'B4E',
  'Labelcoin',
  'Augmint',
];

class TimesheetNotifier extends StateNotifier<List> {
  TimesheetNotifier() : super([]);

  void addProject() {
    devtools.log('Add Project!');
    state = [...state, 1];
  }
}

final timeSheetProvider = StateNotifierProvider<TimesheetNotifier, List>((ref) => TimesheetNotifier());

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
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

class TimeSheet extends ConsumerStatefulWidget {
  const TimeSheet({super.key});

  @override
  TimeSheetState createState() => TimeSheetState();
}

class TimeSheetState extends ConsumerState<TimeSheet> {
  final textEditingController = TextEditingController();
  String? selectedCategory;
  String? selectedSection;

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

    final lastWeekDay = DateTime.utc(currentYear, 1, 1).add(Duration(days: lastDay - 1));

    final days = List.generate(7, (index) {
      return lastWeekDay.subtract(Duration(days: index));
    }).reversed;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timesheet'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Monday',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              Consumer(
                builder: (context, ref, child) {
                  final projects = ref.watch(timeSheetProvider);
                  if (projects.isEmpty) return const SizedBox.shrink();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0.0),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.blueAccent,
                          ),
                        ),
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: const Text('Category'),
                                    items: categoryItems
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ),
                                        )
                                        .toList(),
                                    value: selectedCategory,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                    },
                                    buttonHeight: 40.0,
                                    buttonWidth: 175.0,
                                    buttonPadding: const EdgeInsets.only(left: 10.0),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.blueAccent,
                                    ),
                                    itemHeight: 40.0,
                                    dropdownMaxHeight: 200.0,
                                    searchController: textEditingController,
                                    searchInnerWidget: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: textEditingController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for an item...',
                                          hintStyle: const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) textEditingController.clear();
                                    },
                                  ),
                                ),
                                const Spacer(),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: const Text('Selection'),
                                    items: selectionItems
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          ),
                                        )
                                        .toList(),
                                    value: selectedSection,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSection = value;
                                      });
                                    },
                                    buttonHeight: 40.0,
                                    buttonWidth: 175.0,
                                    buttonPadding: const EdgeInsets.only(left: 10.0),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.blueAccent,
                                    ),
                                    itemHeight: 40.0,
                                    dropdownMaxHeight: 200.0,
                                    searchController: textEditingController,
                                    searchInnerWidget: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: textEditingController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Search for an item...',
                                          hintStyle: const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onMenuStateChange: (isOpen) {
                                      if (!isOpen) textEditingController.clear();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 100.0,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Hours',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              Row(
                children: [
                  const SizedBox(width: 10.0),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(Icons.add_circle),
                    iconSize: 30,
                    onPressed: () {
                      ref.read(timeSheetProvider.notifier).addProject();
                    },
                  ),
                  const Text('Add Project')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
