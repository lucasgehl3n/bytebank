import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();
  final String _textoBotaoSalvar = "Criar";

  ContactForm();

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Editor(
              controlador: widget._nomeController,
              rotulo: 'Nome Completo',
              // tipo: TextInputType.text,
            ),
            Editor(
              controlador: widget._numeroContaController,
              rotulo: 'Número da Conta',
              dica: '000001',
              tipo: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                // Largura máxima sempre
                width: double.maxFinite,
                child: ElevatedButton.icon(
                  onPressed: () => salvarContato(),
                  label: Text(widget._textoBotaoSalvar),
                  icon: Icon(Icons.save),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void salvarContato() async {
    final String nome = widget._nomeController.text;
    final int? numeroConta = int.tryParse(widget._numeroContaController.text);
    final Contact contato = Contact(0, nome, numeroConta);
    await _dao.save(contato);
    Navigator.pop(context);
  }
}
