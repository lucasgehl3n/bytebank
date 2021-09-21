import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType? tipo;
  final bool? esconderConteudo;
  final int? tamanhoMaximo;
  final TextStyle? style;
  final TextAlign? alinhamento;
  Editor({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
    this.tipo,
    this.esconderConteudo,
    this.tamanhoMaximo,
    this.style,
    this.alinhamento,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: style ??
            TextStyle(
              fontSize: 16.0,
            ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        //Tipo de teclado
        keyboardType: tipo ?? TextInputType.text,
        obscureText: esconderConteudo ?? false,
        maxLength: tamanhoMaximo ?? TextField.noMaxLength,
        textAlign: alinhamento ?? TextAlign.start,
      ),
    );
  }
}
