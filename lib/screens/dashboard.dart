import 'package:bytebank/screens/contact/list.dart';
import 'package:bytebank/screens/transaction/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FeatureItem(
                  "Transferências",
                  Icons.monetization_on,
                  actionOnClick: () => _navegarParaContatos(context),
                ),
                _FeatureItem(
                  "Transações",
                  Icons.description,
                  actionOnClick: () => _navegarParaTransacoes(context),
                ),
                _FeatureItem(
                  "Transações",
                  Icons.description,
                  actionOnClick: () => _navegarParaTransacoes(context),
                ),
              ],
            ),
          ),
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

  void _navegarParaTransacoes(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  static final double? _widthButtonsDash = 150;
  static final double? _heigthButtonsDash = 100;
  final String name;
  final IconData icon;
  final Function? actionOnClick;
  const _FeatureItem(this.name, this.icon, {@required this.actionOnClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //Gesture detector do material para conseguir colocar eventos em um elemento que não tem
      //Ink well precisa do material e precisa que a cor seja definida no material
      child: Material(
        //Pegando a cor do tema
        color: Theme.of(context).primaryColor,
        child: InkWell(
          //Acessar a página
          onTap: () {
            //Check para executar somente se não nulo
            this.actionOnClick!();
          },
          child: Container(
            height: _heigthButtonsDash,
            width: _widthButtonsDash,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    this.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  Text(
                    this.name,
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
    );
  }
}
