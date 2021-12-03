import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'usm_viewmodel.dart';
import 'dialogs.dart';


widgetUAdd(USMViewModel oModel, BuildContext ocontext, double dwidth, double dheight) =>
    Container(
        child: Row(children: [
          Expanded(
            child: Column(
                children: <Widget>[
                  widgetQR(oModel, dwidth, dheight),
                  widgetotnum(oModel, dwidth, dheight),
                  widgetCC(oModel, dwidth, dheight),
                  widgetForma(oModel, dwidth, dheight),
                  widgetIdProy(oModel, dwidth, dheight),
                  widgetNPalet(oModel, dwidth, dheight),
                  widgetNave(oModel, dwidth, dheight),
                  widgetPasillo(oModel, dwidth, dheight),
                  widgetBotonera(oModel,dwidth, dheight),
                ]),
          ),
        ])
    );

widgetQR(USMViewModel oModel, double dwidth, double dheight) => Center(
            heightFactor: 1,
            child: Padding(
                padding: EdgeInsets.only(
                top: dheight * 0.10,
                left: dwidth / 10,
                right: dwidth / 10,
                ),
                child: Card(
                  elevation: 8,
                  shadowColor: const Color(0xffe3e8a3),
                  shape:  OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
                  child: TextField(
                    controller: oModel.qrTextAController,
                    maxLines: 6,
                    decoration: InputDecoration(
                    hintText: "Cógido QR",
                    ),
                    onChanged: (value) {oModel.CargarPedidoFromQR(value);},
                  ),
                ),
            ),
);

widgetotnum(USMViewModel oModel, double dwidth, double dheight) => Center(
        heightFactor: 1,
        child: Padding(
          padding: EdgeInsets.only(
            top: dheight * 0.02,
            left: dwidth / 10,
            right: dwidth / 10,
          ),
          child: Card(
            elevation: 8,
            shadowColor: const Color(0xffe3e8a3),
            shape:  OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Nº Pedido Óptimus:',
              ),
              controller: oModel.idPedidoA,
            ),
          ),
        ),
);

widgetCC(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
      padding: EdgeInsets.only(
        top: dheight * 0.02,
        left: dwidth / 10,
        right: dwidth / 10,
      ),
      child: Card(
          elevation: 8,
          shadowColor: const Color(0xffe3e8a3),
          shape:  OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
          child: Column(
              children: <Widget>[
                StatefulBuilder(builder: (BuildContext context, StateSetter dropDownState){
                  return DropdownButton<String>(
                      value: oModel.getDefaultCC(),
                      isExpanded: true,
                      hint: new Text("CCoste:"),
                      onChanged: (newValue) {
                        dropDownState(() {
                          oModel.getSelectedCCoste(newValue!);
                        }); },
                      items: oModel.lstCCostes.map((fc) =>
                          DropdownMenuItem<String>(
                            child: Text(fc.ccoste),
                            value: fc.idcc,
                          )
                      ).toList());
                }),
              ]))
  ),
);

widgetForma(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: dwidth / 10,
      right: dwidth / 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Forma:',
        ),
        controller: oModel.Forma,
      ),
    ),
  ),
);

widgetIdProy(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: dwidth / 10,
      right: dwidth / 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Id.Proy:',
        ),
        controller: oModel.IdProy,
      ),
    ),
  ),
);

widgetNPalet(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: dwidth / 10,
      right: dwidth / 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'N.Palet:',
        ),
        controller: oModel.NPalet,
      ),
    ),
  ),
);

widgetNave(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: dwidth / 10,
      right: dwidth / 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Nave:',
        ),
        controller: oModel.Nave,
      ),
    ),
  ),
);

widgetPasillo(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: dwidth / 10,
      right: dwidth / 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Pasillo:',
        ),
        controller: oModel.Pasillo,
      ),
    ),
  ),
);

widgetBotonera(USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
        top: dheight * 0.02,
        left: dwidth / 9,
        right: dwidth / 9),
        child: Row(
            children: <Widget>[
              SizedBox(
                width: (dwidth / 2) - (dwidth / 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffe3e8a3),
                  ),
                  onPressed: () {
                  },
                  child: Text('Aceptar', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            SizedBox(width: 25),
            SizedBox(
                  width: (dwidth / 2) - (dwidth / 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffe3e8a3),
                    ),
                    onPressed: () {
                    },
                    child: Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ]
        )
);

