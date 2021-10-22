import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_calculator/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transaction.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('No transaction added yet!'),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/zzz.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              child: Text('\$${transaction[index].amount}')),
                        ),
                      ),
                      title: Text(
                        transaction[index].title!,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transaction[index].date!)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => deleteTx(transaction[index].id),
                      )),
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
