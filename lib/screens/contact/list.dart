import 'package:bytebank/components/loader.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/Contact.dart';
import 'package:bytebank/screens/contact/form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  void _navegarParaNovoFormulario(context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ContactForm(),
          ),
        )
        .then(
          (value) => setState(() {}),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          //Conteúdo é retornoado no snapshot.data
          final List<Contact>? _contatos = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Loader();

            //Tem um dado disponível, mas ainda não terminou (stream)
            //Ex: pedaço de um download falando progresso
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              if (_contatos != null) {
                //Ainda tentando descobrir uma forma de gerenciar a edição a partir de um novo widget, por que se faço o setstate fora do futurebuilder ele não atualiza
                return ListView.builder(
                  //iterador
                  itemBuilder: (contexto, index) {
                    final Contact contato = _contatos[index];
                    return ContactListItem(contato);
                  },
                  itemCount: _contatos.length,
                );
              }
              break;
          }
          return Text('Ocorreu um erro desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navegarParaNovoFormulario(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact _contato;

  const ContactListItem(this._contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _contato.nome,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _contato.numeroConta.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
