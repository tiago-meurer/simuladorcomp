import 'dart:wasm';
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {

  runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false,  
    title: 'Simulador Vek',
    home: SIForm(),
    theme:ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xff66aed2),
      accentColor: Color(0xff66aed2),
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _concorrentes = ['Rede', 'GetNet', 'PagSeguro', 'Stone', 'Vero'];
  var _currentConcorrente = 'Rede';
  //var _ramoAtividade = ['Industrial','Comercial','Prestação de Serviços'];


  List <Map<String, double>> _ramoAtividade = [{'Industrial': 2.5},{'Comercial':3.5},{'Prestação de Serviços':3.2}];

  

  var _currentAtividade = 'Industrial';

  final _minimumPadding = 6.0;

  TextEditingController cpfController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController tdcController = TextEditingController();
  TextEditingController ddController = TextEditingController();
  TextEditingController tccController = TextEditingController();
  TextEditingController dcController = TextEditingController();



  @override
  Widget build(BuildContext context) {
 
    
    
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;


    return Scaffold(
        appBar: AppBar(
          title: Text('Simulador Comparativo'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(_minimumPadding * 2),
            child: Column(
              children: <Widget>[
                getImageAsset(),

          

           FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  labelText: 'Concorrente *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(                 
                  isDense: true,                                    
                  items: _concorrentes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), 
                  value: _currentConcorrente,
                  onChanged: (String newValueSelected){
                    //Code to execute, when a menu item is selected from dropdown
                    _onDropDownConcorrente(newValueSelected);
                  },                     
                ),
              ),
            );
          },
        ),

                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: cpfController,
                  decoration: InputDecoration(
                      labelText: 'CNPJ ou CPF *',
                      hintText: 'Informe o CNPJ ou CPF',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),


                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: telefoneController,
                  decoration: InputDecoration(
                      labelText: 'Telefone *', 
                      hintText: 'Informe o telefone',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),


                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                    style: textStyle,
                    controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'Informe o endereço de e-mail',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),

                   FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                labelStyle: textStyle,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  labelText: 'Ramo de Atividade *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
              child: DropdownButtonHideUnderline(




                child: DropdownButton<String>(                 
                  isDense: true,                                    
                  items: _ramoAtividade.map((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(), 
                  value: _currentAtividade,
                  onChanged: (String newValueSelected){
                    //Code to execute, when a menu item is selected from dropdown
                    _onDropDownAtividade(newValueSelected);
                  },                     
                ),




              ),
            );
          },
        ),


                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                  style: textStyle,
                  controller: tdcController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Taxa Débito Concorrente *',
                      hintText: 'Informe a taxa de débito do concorrente',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),


                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                  style: textStyle,
                  controller: ddController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Desconto Débito *',
                      hintText: 'Informe o desconto de débito',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),


                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                   style: textStyle,
                   controller: tccController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Taxa Crédito Concorrente *',
                      hintText: 'Informe o taxa de crédito do concorrente',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),


                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: TextField(
                   style: textStyle,
                   controller: dcController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Desconto Crédito *',
                      hintText: 'Informe o desconto de crédito',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),

                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Simular', textScaleFactor: 1.5),
                      onPressed: (){
                        setState(() {
                         _submitSimulation(); 
                        });
                      },
                    ),                 
                  ),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Limpar', textScaleFactor: 1.5),
                      onPressed: (){
                        setState(() {
                         _reset(); 
                        });      
                      },
                    ),                 
                  ),

                ],)),

                Padding(padding: EdgeInsets.all(_minimumPadding * 2),
                child: Text('output', style: textStyle),
                )

              ],
            ),
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/vek.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownConcorrente(String newValueSelected){
    setState(() {
      this._currentConcorrente = newValueSelected;
     
    });
  }

  void _onDropDownAtividade(String newValueSelected){
    setState((){
      this._currentAtividade = newValueSelected;
    });
  }

  String _submitSimulation(){
    //realizar a tabela de taxas mínimas por ramo de atividade;
    //verificar se as taxas calculadas após os descontos oferecidos pelo vendedor
    //são permitidas para o ramo de atividade do cliente

  }

  void _reset(){
    cpfController.text = '';
    telefoneController.text = '';
    emailController.text = '';
    tdcController.text = '';
    ddController.text = '';
    tccController.text = '';
    dcController.text = '';
  }
}
