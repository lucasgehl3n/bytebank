import 'dart:convert';
import 'package:bytebank/WebApi/webclient.dart';
import 'package:bytebank/models/Transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  final String urlTransactions = "transactions";
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(urlBase, urlTransactions))
        .timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return _toTransactions(decodedJson);
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(
      Uri.http(urlBase, urlTransactions),
      headers: {
        "Content-type": "application/json",
        "password": "1000",
      },
      body: transactionJson,
    );

    Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return Transaction.fromJson(decodedJson);
  }

  List<Transaction> _toTransactions(List<dynamic> json) {
    return json.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    return transaction.toJson();
  }
}
