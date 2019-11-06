
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:simuladorcomparativo/fechamento_csv.dart';
import 'package:simuladorcomparativo/rejeitados_csv.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simulador Comparativo',
    home: SIForm(),
    theme: ThemeData(
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
 

  static const Map<String, double> _ramoAtividade = {
    'Industrial': 2.5,
    'Comercial': 3.5,
    'Prestação de Serviços': 3.2
  };

  var _currentAtividade = 2.5;

  final _minimumPadding = 6.0;

  TextEditingController cpfController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController tdcController = TextEditingController();
  TextEditingController ddController = TextEditingController();
  TextEditingController tccController = TextEditingController();
  TextEditingController dcController = TextEditingController();
  TextEditingController ramoController = TextEditingController();

  var now = new DateTime.now();

  String infoDebText = " ";
  String infoCredText = " ";

  Widget infoConf;

  String statusAceita = "Proposta Confirmada";
  String statusRejeita = "Proposta Rejeitada";


  List<Widget> confirmButtons(BuildContext context) {
      return [
        new MaterialButton(
          height: 40.0,
          minWidth: 100.0,
          color: Theme.of(context).accentColor,
          textColor: Theme.of(context).primaryColorDark,
          child: new Text("Confirmar", style: new TextStyle(fontSize: 20.0)),
          onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FechamentoCSV();
                    }));
                  },
          splashColor: Colors.black,
        ),
        new MaterialButton(
          height: 40.0,
          minWidth: 100.0,
          color: Theme.of(context).accentColor,
          textColor: Colors.red,
          child: new Text('Cancelar',
          style: new TextStyle(fontSize: 20.0)),
          onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RejeitadoCSV();
                    }));
                  },
        ),
      ];
    }   



  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;

    return Scaffold(
        appBar: AppBar(
          title: Text('Simulador Comparativo Vek'),
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
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          labelText: 'Concorrente *',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
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
                          onChanged: (String newValueSelected) {
                            //Code to execute, when a menu item is selected from dropdown
                            _onDropDownConcorrente(newValueSelected);
                          },
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          labelText: 'Ramo de Atividade *',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      child: DropdownButtonHideUnderline(




                        child: DropdownButton<double>(
                          isDense: true,
                          items: _ramoAtividade
                              .map((atividade, value) {
                                return MapEntry(
                                  atividade,
                                  DropdownMenuItem<double>(
                                    value: value,
                                    child: Text(atividade),
                                  ),
                                );
                              })
                              .values
                              .toList(),                             
                          value: _currentAtividade,
                          onChanged: (double newValueSelected) {
                            //Code to execute, when a menu item is selected from dropdown
                            _onDropDownAtividade(newValueSelected);
                          },          
                        ),








                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
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
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text('Simular', textScaleFactor: 1.5),
                            onPressed: () {
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
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 5),
                  child: Text(infoDebText, style: textStyle),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(infoCredText, style: textStyle),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding),
                  child: infoConf,
                ),
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

  void _onDropDownConcorrente(String newValueSelected) {
    setState(() {
      this._currentConcorrente = newValueSelected;
    });
  }

  void _onDropDownAtividade(double newValueSelected) {
    setState(() {
      this._currentAtividade = newValueSelected;
    });
  }

    void _submitSimulation() {
   

    double taxaDebito = double.parse(tdcController.text);
    double descontoDebito = double.parse(ddController.text);

    double debCalc = (taxaDebito - descontoDebito);

    double taxaCredito = double.parse(tccController.text);
    double descontoCredito = double.parse(dcController.text);

    double credCalc = (taxaCredito - descontoCredito);

    if (debCalc < (_currentAtividade)){
      infoDebText = "Taxas de débito calculadas não são permitidas para o ramo de atividade informado.";
    }  else if (debCalc >= (_currentAtividade)){
       infoDebText = "Taxas de débito calculadas são permitidas!";
    }

     if (credCalc < (_currentAtividade)){
      infoCredText = "Taxas de crédito calculadas não são permitidas para o ramo de atividade informado.";
     }  else if (credCalc >= (_currentAtividade)){
      infoCredText = "Taxas de crédito calculadas são permitidas!";
     }

     if (debCalc >= (_currentAtividade) && credCalc >= (_currentAtividade)){

       infoConf = Container(
                    margin: EdgeInsets.all(2),
                    padding: const EdgeInsets.all(40.0),
                    child: new Column(
                      children: confirmButtons(context),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  );
    } 
 
  }

   
  void _reset() {

    cpfController.text = '';
    telefoneController.text = '';
    emailController.text = '';
    tdcController.text = '';
    ddController.text = '';
    tccController.text = '';
    dcController.text = '';
    _currentConcorrente = _concorrentes[0];
    infoDebText = " ";
    infoCredText = " ";
    infoConf = null;
  }

}

class Associate extends SIForm {

final String _currentConcorrente;
final String cpfController;
final String telefoneController;
final String emailController;
final String _currentAtividade;
final String tdcController;
final String ddController;
final String debCalc;
final String tccController;
final String dcController;
final String credCalc;
final String statusAceita;
final String statusRejeita;
final String now;

Associate(this._currentConcorrente, 
          this.cpfController,
          this.telefoneController,
          this.emailController,
          this._currentAtividade,
          this.tdcController,
          this.ddController,
          this.debCalc,
          this.tccController,
          this.dcController,
          this.credCalc,
          this.statusAceita,
          this.statusRejeita,
          this.now);

 static List<Associate> associateList() {
    return [
      Associate('Concorrente: ','CPF/CNPJ: ','Telefone: ','Email: ',
                'Ramo de Atividade: ','Taxa Débito Concorrente: ','Desconto Débito: ','% desconto Débito: ','Taxa Crédito Concorrente: ','Desconto Crédito: ',
                '% desconto Crédito: ','Status positivo: ','Status Negativo: ','Data do Aceite: ')
    ];         
 
 
 }
}



 



