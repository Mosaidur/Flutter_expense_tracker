
import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // text controller
  final newExpenseNameController = TextEditingController();
  final newExpenseTakaController = TextEditingController();
  final newExpensePoyshaController = TextEditingController();

  @override
  void initState (){

    super.initState();

    //prepare data on startup

    Provider.of<ExpenseData>(context, listen: false).preparedData();

  }

  //add new expense
  void addNewExpense (){
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text("Add new expense"),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //expense name
              TextField(
                controller: newExpenseNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Expense name",
                ),
              ),

              //expense amount
              Row(
                children: [
                  // taka
                  Expanded(
                    child: TextField(
                      controller: newExpenseTakaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Taka",
                      ),
                    ),
                  ),

                  //poysha
                  Expanded(
                    child: TextField(
                      controller: newExpensePoyshaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "paisa",
                      ),
                      //decoration:  ,
                    ),
                  ),

                ],
              ),
            ],
          ),
          actions: [
            //save button
            MaterialButton(onPressed: save,
            child: Text("Save"),),
            //cancel button
            MaterialButton(onPressed: cancel,
              child: Text("Cancel"),)
          ],
        ),

    );
  }

  // delete expense
  void deleteExpense (ExpenseItem expense){
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  /*
  //edit expense
  void editExpense (ExpenseItem expense){
      showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          title: Text("Edit this expense"),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //expense name
              TextField(
                controller: newExpenseNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Expense name",
                ),
              ),

              //expense amount
              Row(
                children: [
                  // taka
                  Expanded(
                    child: TextField(
                      controller: newExpenseTakaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Taka",
                      ),
                    ),
                  ),

                  //poysha
                  Expanded(
                    child: TextField(
                      controller: newExpensePoyshaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "paisa",
                      ),
                      //decoration:  ,
                    ),
                  ),

                ],
              ),
            ],
          ),
          actions: [
            //save button
            MaterialButton(onPressed: save,
              child: Text("Save"),),
            //cancel button
            MaterialButton(onPressed: cancel,
              child: Text("Cancel"),)
          ],
        ),
      );

    Provider.of<ExpenseData>(context, listen: false).editExpense(expense);
  }


   */


  //save
  void save(){

    if (
    newExpenseNameController.text.isNotEmpty &&
    newExpenseTakaController.text.isNotEmpty &&
    newExpensePoyshaController.text.isNotEmpty
    ) {
      //put taka and cents togethar
      String amount = newExpenseTakaController.text + "." +
          newExpensePoyshaController.text;

      //create expense item
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now()
      );
      // add the new expense
      Provider.of<ExpenseData>(context, listen: false).addNewExpense(
          newExpense);
    }
    Navigator.pop(context);
    clear();
  }

  //cancel
  void cancel(){
    Navigator.pop(context);
    clear();
  }

  //clear
  void clear (){
    newExpenseNameController.clear();
    newExpenseTakaController.clear();
    newExpensePoyshaController.clear();
  }




  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton:  FloatingActionButton(
        onPressed: addNewExpense,
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
        //weekly summary

          ExpenseSummary(startOfWeek: value.startOfWeekDate()),

        SizedBox(height: 20,),

        //expense list
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context,index)=>
                  ExpenseTile(name: value.getAllExpenseList()[index].name,
                    amount: value.getAllExpenseList()[index].amount,
                    dateTime: value.getAllExpenseList()[index].dateTime,
                    deleteTapped: (p0 )=> deleteExpense(value.getAllExpenseList()[index]),

                  )
          ),
        ],
      ),
    ), );
  }
}
