import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_calculator/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('No transaction added yet!'),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/zzz.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
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
                    trailing: MediaQuery.of(context).size.width > 360
                        ? TextButton.icon(
                            label: Text('Delete'),
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteTx(
                              transaction[index].id,
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.red,
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => deleteTx(transaction[index].id),
                          )),
              );
            },
            itemCount: transaction.length,
          );
  }
}
