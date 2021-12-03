import 'package:flutter/material.dart';
import 'dart:async';
import 'usm_viewmodel.dart';


Future<String> showDeleteDialog(BuildContext context, USMViewModel omodel) async {
  return await showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Estás Seguro?"),
      content:  Container(
        height: 100,
        width: 200,
        child: Column(
        children: <Widget>[
          StatefulBuilder(builder: (BuildContext context, StateSetter dropDownState){
          return DropdownButton<String>(
                    value: omodel.getDefaultCC(),
                    isExpanded: true,
                    hint: new Text("CCoste Destino:"),
                    onChanged: (newValue) {
                        dropDownState(() {
                          omodel.getSelectedCCoste(newValue!);
                        }); },
                    items: omodel.lstCCostes.map((fc) =>
                        DropdownMenuItem<String>(
                          child: Text(fc.ccoste),
                          value: fc.idcc,
                        )
                    ).toList());
                  }),
          ])),
      actions: <Widget>[
        ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 90, height: 35),
            child: ElevatedButton(
              child: const Text("Cancelar", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              onPressed: (){ Navigator.of(context).pop("");
              },
            )),
        ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 90, height: 35),
            child: ElevatedButton(
              child: const Text("Borrar", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              onPressed: (){ Navigator.of(context).pop("OK");
              },
            ))
      ],
    );
  }
  );
}


Future<String> showMessageDialog(BuildContext context, USMViewModel omodel, String message) async {
  return await showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      title: Text("AVISO"),
      content:  Container(
          height: 100,
          width: 200,
          child: Text(message),
      ),
      actions: <Widget>[
        ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 90, height: 35),
            child: ElevatedButton(
              child: const Text("Cancelar", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              onPressed: (){ Navigator.of(context).pop("");
              },
            )),
        ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 90, height: 35),
            child: ElevatedButton(
              child: const Text("Borrar", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
              onPressed: (){ Navigator.of(context).pop(omodel.selectCC);
              },
            ))
      ],
    );
  }
  );
}
