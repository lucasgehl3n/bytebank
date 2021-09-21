import 'dart:async';

import 'package:bytebank/WebApi/webclients/transactions_webclients.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/loader.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:bytebank/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _exibirLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Loader(
                  message: "Enviando",
                ),
                visible: _exibirLoader,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Editor(
                  controlador: _valueController,
                  rotulo: 'Valor de Transferência',
                  tipo: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  // Largura máxima sempre
                  width: double.maxFinite,
                  child: ElevatedButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (contextDialog) {
                        return TransactionAuthDialog(
                          onConfirm: (String password) {
                            _save(password, contextDialog);
                          },
                        );
                      },
                    ),
                    // onPressed: () {

                    label: Text('Salvar'),
                    icon: Icon(Icons.save),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(String password, BuildContext context) async {
    final double? value = double.tryParse(_valueController.text);
    final transactionCreated =
        Transaction(transactionId, value!, widget.contact);

    Transaction? transaction =
        await _sendSave(transactionCreated, password, context);

    if (transaction != null) _showSuccessfulMessage(context);
  }

  Future<Transaction?> _sendSave(Transaction transactionCreated,
      String password, BuildContext context) async {
    setState(() {
      _exibirLoader = true;
    });
    final Transaction? transaction =
        await _webClient.save(transactionCreated, password).catchError(
      (e) {
        _showFailureMessage(context, message: e.message);
      },
      test: (e) => e is HttpException,
    ).catchError((e) {
      _showFailureMessage(context, message: 'Timeout error');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() => setState(() {
              _exibirLoader = false;
            }));

    return transaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = 'Unkown error'}) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return FailureDialog(message);
      },
    );
  }

  void _showSuccessfulMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (contextDialog) {
        return SuccessDialog('successful transaction');
      },
    );
    Navigator.pop(context);
  }
}
