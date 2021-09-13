import 'package:bytebank/WebApi/webclients/transactions_webclients.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:bytebank/models/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

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
                    onPressed: () {
                      final double? value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(value!, widget.contact);

                      _webClient.save(transactionCreated).then(
                            (transactionReceived) => {
                              Navigator.pop(context),
                            },
                          );
                    },
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
}
