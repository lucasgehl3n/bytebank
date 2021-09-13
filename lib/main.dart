import 'package:flutter/material.dart';
import 'WebApi/webclients/transactions_webclients.dart';
import 'models/Contact.dart';
import 'models/Transaction.dart';
import 'screens/dashboard.dart';

void main() async {
  runApp(BytebankApp());
  final TransactionWebClient _webClient = TransactionWebClient();

  _webClient
      .save(Transaction(200.0, Contact(0, 'Gui', 2000)))
      .then((transaction) => print(transaction));
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    ); //MaterialApp
  }
}
