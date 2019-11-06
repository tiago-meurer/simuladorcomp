import 'package:flutter/material.dart';
import 'package:simuladorcomparativo/main.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:path_provider/path_provider.dart';





class FechamentoCSV extends StatelessWidget {

  String file;

  get associateList => Associate;

  
@override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Dados Salvos!'),
          ),
        );
}


getCsv() async {

 

 List<List<dynamic>> rows = List<List<dynamic>>();
    for (int i = 0; i <associateList.length;i++) {

    List<dynamic> row = List();
    row.add(associateList[i]._currentConcorrente);
    row.add(associateList[i].cpfController);
    row.add(associateList[i].telefoneController);
    row.add(associateList[i].emailController);
    row.add(associateList[i]._currentAtividade);
    row.add(associateList[i].tdcController);
    row.add(associateList[i].ddController);
    row.add(associateList[i].debCalc);
    row.add(associateList[i].tccController);
    row.add(associateList[i].dcController);
    row.add(associateList[i].credCalc);
    row.add(associateList[i].statusAceita);
    row.add(associateList[i].now);
    rows.add(row);
  }

 await SimplePermissions.requestPermission(Permission. WriteExternalStorage);
  bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
  if(checkPermission) {

//store file in documents folder

    String dir = (await getExternalStorageDirectory()).absolute.path + "/simuladorcomparativo/csv/";
    file = "$dir";
    print(" FILE " + file);  
        File f = new File(file + "filename.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
  }


}

}



