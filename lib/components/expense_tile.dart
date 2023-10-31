import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function (BuildContext)? deleteTapped;

  ExpenseTile({super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
     required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [

          //delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent ,
            borderRadius: BorderRadius.circular(10) ,

          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
            "${dateTime.day}/${dateTime.month}/${dateTime.year}   ${getDayName(dateTime)}   ${dateTime.hour}:${dateTime.minute}"),
        trailing: Text("৳"+amount),
      ),
    );
  }
}

String getDayName (DateTime dateTime ){
  switch (dateTime.weekday){
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      return "";

  }
}
