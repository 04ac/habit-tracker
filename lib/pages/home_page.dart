import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/create_habit_fab.dart';
import '../components/enter_habit_dialog.dart';
import '../components/habit_tile.dart';
import '../components/monthly_summary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _box = Hive.box("habit_database");
  final _newHabitNameController = TextEditingController();

  @override
  void initState() {
    //If this is the first time opening the db
    if (_box.get("CURRENT_HABIT_LIST") == null) {
      //create default data
      db.createDefaultData();
    } else {
      //else load existing data
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  void createNewHabit() {
    // Show Dialog for user to enter a new habit
    showDialog(
      context: context,
      builder: (context) {
        return EnterHabitDialog(
          hintText: "Enter a new Habit",
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelHabitDialog,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabits.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelHabitDialog() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    // Show Dialog for user to edit a existing habit
    showDialog(
      context: context,
      builder: (context) {
        return EnterHabitDialog(
          controller: _newHabitNameController,
          hintText: db.todaysHabits[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelHabitDialog,
        );
      },
    );
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabits.elementAt(index)[0] = _newHabitNameController.text;
      db.todaysHabits.elementAt(index)[1] = false;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void deleteExistingHabit(int index) {
    setState(() {
      db.todaysHabits.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        scrolledUnderElevation: 0,
      ),
      floatingActionButton: CreateHabitFab(
        onPressed: createNewHabit,
      ),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          // MonthlySummary
          MonthlySummary(
            datasets: db.heatMapDataSet,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: const Text(
              "Your Habits",
              style: TextStyle(fontSize: 24),
            ),
          ),
          // Habits
          ListView.builder(
            padding: EdgeInsets.all(10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: db.todaysHabits.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabits[index][0],
                habitCompleted: db.todaysHabits[index][1],
                onChanged: (newVal) {
                  setState(() {
                    db.todaysHabits[index][1] = newVal;
                  });
                  db.updateDatabase();
                },
                onSettingsPress: (context) => openHabitSettings(index),
                onDeletePress: (context) => deleteExistingHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
