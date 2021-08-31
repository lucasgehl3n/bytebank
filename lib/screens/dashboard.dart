import 'package:bytebank/screens/contact/list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        //Alinhamento da pagina na tela inteira no eixo veritcal
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/bytebank_logo.png'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //Gesture detector do material para conseguir colocar eventos em um elemento que não tem
            //Ink well precisa do material e precisa que a cor seja definida no material
            child: Material(
              //Pegando a cor do tema
              color: Theme.of(context).primaryColor,
              child: InkWell(
                //Acessar a página
                onTap: () {
                  _navegarParaContatos(context);
                },
                child: Container(
                  height: 100,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.white,
                          size: 24,
                        ),
                        Text(
                          'Contatos',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ), //Scaffold
    );
  }

  void _navegarParaContatos(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsList(),
      ),
    );
  }
}
