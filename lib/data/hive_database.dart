import 'package:hive/hive.dart';

import '../models/expense_item.dart';

class HiveDataBase {

  // reference our box

  final _mybox = Hive.box("expense_database");

  //write data
  void saveData (List <ExpenseItem> allExpense) {

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense){
      List<dynamic> expensesFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expensesFormatted);
    }
    //finally lets store in our database
    _mybox.put("All_Expenses", allExpensesFormatted);

  }

  // read data
  List<ExpenseItem> readData (){
     List savedExpenses = _mybox.get("All_Expenses")?? [];
     List <ExpenseItem> allExpenses =[];
     for (int i=0 ; i < savedExpenses.length; i++ ){
       //collect individual expenses data
       String name = savedExpenses[i][0];
       String amount = savedExpenses[i][1];
       DateTime dateTime = savedExpenses[i][2];
       
       //create expense item
       ExpenseItem expense =
       ExpenseItem(
           name: name,
           amount: amount,
           dateTime: dateTime
       );
       allExpenses.add(expense);
     }
     return allExpenses;
  }

}