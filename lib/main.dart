import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home(),)
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoCrontroller = TextEditingController();
  TextEditingController alturaCrontroller = TextEditingController();
  GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  String _infoText="Informe seus dados!";
  void _reset(){
    pesoCrontroller.text="";
    alturaCrontroller.text="";
  setState(() {
    _infoText ="Informe seus dados!";
  });
  }
  void _calcular(){
    setState(() {
      double peso= double.parse(pesoCrontroller.text);
      double altura= double.parse(alturaCrontroller.text)/100;
      double imc= peso/ (altura * altura);
      if(imc<18.6){
        _infoText= "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      }
      else if(imc>=18.6 && imc<24.9){
        _infoText= "Peso Ideal (${imc.toStringAsPrecision(4)})";
      }
      else if(imc>=24.9 && imc<29.9){
        _infoText= "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      }
      else if(imc>=29.9 && imc<34.9){
        _infoText= "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      }
      else if(imc>=34.9 && imc<39.9){
        _infoText= "Obsedidade Grau II (${imc.toStringAsPrecision(4)})";
      }
      else if(imc>=40){
        _infoText= "Obseidade Grau III(${imc.toStringAsPrecision(4)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    //Scaffol implementa barra de baixo, de cima, botao etc.
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _reset,
            )
          ],
        ),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //isso é para poder rolar, para o teclado não cobrir o conteudo
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child:Form(
            key: _formkey,
           child: Column(
             // aq ele vai preencher toda a largura, so nao vai preencher tudo
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               Icon(Icons.person_outline, size: 120.0, color: Colors.red),
               TextFormField(
                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   labelText: "Peso em (KG)",
                   labelStyle: TextStyle(color: Colors.red),
                 ),
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 23.0,
                 ),
                 controller: pesoCrontroller,
                 validator: (value){
                   if(value.isEmpty){
                     return "Insira seu Peso!";
                   }
                 },
               ),
               TextFormField(
                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                   labelText: "Altura",
                   labelStyle: TextStyle(color: Colors.red),
                 ),
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 23.0,
                 ),
                 controller: alturaCrontroller,
                 validator: (value){
                   if(value.isEmpty){
                     return "Insira sua Altura!";
                   }
                 },
               ),
               Padding(
                 padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                 child: //container pra poder aumentar a largura.
                 Container(
                   height: 50.0,
                   child: RaisedButton(
                     onPressed: (){
                       if(_formkey.currentState.validate()){
                         _calcular();
                       }
                     },
                     child: Text(
                       "Calcular",
                       style: TextStyle(color: Colors.white, fontSize: 25.0),
                     ),
                     color: Colors.red,
                   ),
                 ),
               ),
               Text(
                 _infoText,
                 textAlign: TextAlign.center,
                 style: TextStyle(color: Colors.red, fontSize: 25.0),
               ),
             ],
           ) ,
          ),
        ),
    );
  }
}
