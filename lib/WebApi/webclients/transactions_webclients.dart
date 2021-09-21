import 'dart:convert';
import 'package:bytebank/WebApi/webclient.dart';
import 'package:bytebank/models/Transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  final String urlTransactions = "transactions";
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(Uri.http(urlBase, urlTransactions));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return _toTransactions(decodedJson);
  }

  Future<Transaction?> save(Transaction transaction, String password) async {
    await Future.delayed(Duration(seconds: 2));
    Map<String, dynamic> transactionMap = _toMap(transaction);
    final String transactionJson = jsonEncode(transactionMap);

    final Response response = await client.post(
      Uri.http(urlBase, urlTransactions),
      headers: {
        "Content-type": "application/json",
        "password": password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return Transaction.fromJson(decodedJson);
    }

    throw HttpException(getMessageError(response.statusCode));
  }

  String getMessageError(int statusCode) {
    return _statusCodeResponses[statusCode] ?? "Erro desconhecido.";
  }

  List<Transaction> _toTransactions(List<dynamic> json) {
    return json.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    return transaction.toJson();
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction alway exists'
  };
}

class HttpException implements Exception {
  final String? message;
  HttpException(this.message);
}
