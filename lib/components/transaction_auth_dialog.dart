import 'package:bytebank/components/editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password)? onConfirm;

  const TransactionAuthDialog({
    @required this.onConfirm,
  });

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: Editor(
        controlador: _passwordController,
        esconderConteudo: true,
        tamanhoMaximo: 4,
        tipo: TextInputType.number,
        style: TextStyle(
          fontSize: 48,
          letterSpacing: 24,
        ),
        alinhamento: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm!(_passwordController.text);
            Navigator.pop(context);
          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
