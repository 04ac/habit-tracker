import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/datetime/date_time.dart';

final _box = Hive.box("habit_database");

class HabitDatabase {
  List todaysHabits = [];
  Map<DateTime, int> heatMapDataSet = {};

  // Create initial Default data
  void createDefaultData() {
    todaysHabits = [
      ["Drink water", false],
      ["Fly a Boeing 747", false],
    ];

    _box.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // If it's a new day, entries of the day are not in the list
    if (_box.get(todaysDateFormatted()) == null) {
      // so we get the current habit list
      todaysHabits = _box.get("CURRENT_HABIT_LIST");

      // and set the status of all habits to false
      for (int i = 0; i < todaysHabits.length; i++) {
        todaysHabits[i][1] = false;
      }
    } else {
      // else we get today's data
      todaysHabits = _box.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    _box.put(todaysDateFormatted(), todaysHabits);
    _box.put("CURRENT_HABIT_LIST", todaysHabits);

    calculateTodaysHabitPercentages();

    loadHeatMap();
  }

  void calculateTodaysHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabits.length; i++) {
      if (todaysHabits[i][1] == true) {
        countCompleted++;
      }
    }
    String fractionCompleted = todaysHabits.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabits.length).toStringAsFixed(1);

    _box.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", fractionCompleted);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_box.get("START_DATE"));
    int daysBetweenStartAndNow = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i <= daysBetweenStartAndNow; i++) {
      DateTime currDate = startDate.add(Duration(days: i));
      String yyyymmddCurrDate = convertDateTimeToString(currDate);

      String frac = _box.get("PERCENTAGE_SUMMARY_$yyyymmddCurrDate") ?? "0.0";
      int year = currDate.year;
      int month = currDate.month;
      int day = currDate.day;

      heatMapDataSet[DateTime(year, month, day)] =
          (double.parse(frac) * 10).toInt();
    }
  }
}
