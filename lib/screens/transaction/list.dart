import 'package:bytebank/WebApi/webclients/transactions_webclients.dart';
import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/loader.dart';
import 'package:bytebank/models/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = [];
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.findAll(),
        // future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Transaction>? transactions = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Loader();

              //Tem um dado disponível, mas ainda não terminou (stream)
              //Ex: pedaço de um download falando progresso
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (transactions != null && transactions.isNotEmpty) {
                  //Ainda tentando descobrir uma forma de gerenciar a edição a partir de um novo widget, por que se faço o setstate fora do futurebuilder ele não atualiza
                  return TransactionListItems(transactions);
                } else {
                  return CenteredMessage(
                    "Nenhuma mensagem encontrada!",
                    icon: Icons.warning,
                  );
                }
            }
          }
          return CenteredMessage(
            "Erro desconhecido",
            icon: Icons.warning,
          );
        },
      ),
    );
  }
}

class TransactionListItems extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionListItems(this.transactions);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Transaction transaction = transactions[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(
              transaction.value.toString(),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              transaction.contact.accountNumber.toString(),
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
