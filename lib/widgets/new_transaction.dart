import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final inputController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = inputController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  Future<void> _presentDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      elevation: 5,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                  ),
                  TextButton(
                    child: Text('Choose a Date'),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: submitData,
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
