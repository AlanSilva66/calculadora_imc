import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _infoText = "Informe seus dados";

  void _resetField(){
    weightController.text ="";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.6){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal(${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso(${imc.toStringAsPrecision(30)})";
      }
      else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I(${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 34.9 && imc > 39.9) {
        _infoText = "Obesidade grau II(${imc.toStringAsPrecision(3)})";
      }
      else if(imc >= 40.0){
          _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //BARRA EM CIMA
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //Faz com que as coisas em HORIZONTAL ocupe toda a tela
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 120.0,
                  color: Colors.white,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (KG)",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (CM)",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if (value!.isEmpty){
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()){
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.black),
                  ),
                ),
                Text(
                  "$_infoText",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),

          ),
        ));
  }
}
