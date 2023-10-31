import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  //List of All expense
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //prepared data to display
  final db = HiveDataBase();
  void preparedData() {
    //if there exits data, get it
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //get weekday (mon, tues, etc) from a datetime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thur";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  //get the date for start of the week ( sunday )

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //get todays date
    DateTime today = DateTime.now();

    //go backward from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  DateTime startOfWeekDate() {
    DateTime today = DateTime.now();

    // Initialize startOfWeek with today's date.
    DateTime startOfWeek = today;

    // Go backward from today to find Sunday.
    for (int i = 0; i < 7; i++) {
      if (getDayName(startOfWeek) == "Sun") {
        return startOfWeek;
      }
      startOfWeek = startOfWeek.subtract(Duration(days: 1));
    }

    // If no Sunday is found, you can return a default value or handle it as needed.
    return today;
  }


  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);
      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }

   */
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      String amountStr = expense.amount;

      try {
        double amount = double.parse(amountStr);

        if (dailyExpenseSummary.containsKey(date)) {
          double currentAmount = dailyExpenseSummary[date]!;
          currentAmount += amount;
          dailyExpenseSummary[date] = currentAmount;
        } else {
          dailyExpenseSummary.addAll({date: amount});
        }
      } catch (e) {
        // Handle the invalid amount here, e.g., by logging or skipping the expense.
        print("Invalid amount: $amountStr");
      }
    }

    return dailyExpenseSummary;
  }

}
