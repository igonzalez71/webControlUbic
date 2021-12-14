import 'package:flutter/material.dart';
import 'usm_viewmodel.dart';



widgetUAdd(USMViewModel oModel, BuildContext ocontext, double dwidth, double dheight) =>
    SingleChildScrollView(
        child: Row(children: [
          Expanded(
            child: Column(
                children: <Widget>[
                  widgetQR(ocontext, oModel, dwidth, dheight),
                  widgetId(oModel),
                  widgetotnum(oModel, dwidth, dheight),
                  widgetCC(oModel, dwidth, dheight),
                  widgetForma(oModel, dwidth, dheight),
                  widgetIdProy(oModel, dwidth, dheight),
                  widgetNPalet(oModel, dwidth, dheight),
                  widgetNave(oModel, dwidth, dheight),
                  widgetPasillo(oModel, dwidth, dheight),
                  widgetBotonera(oModel, ocontext, dwidth, dheight),
                  SizedBox(height: 10)
                ]),
          ),
        ])
    );


widgetQR(BuildContext oContext, USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: 10,
      right: 10,
    ),
    child: Row(
        children: <Widget>[
          Expanded(
            child: ExpansionTile(
              title: Text('QR'),
              children: <Widget>[
                ListTile(title: Text(oModel.qrA)),
              ],
            ),

          ),
          Expanded(
              child: Card(
                elevation: 8,
                shadowColor: const Color(0xffe3e8a3),
                shape:  OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
                child: TextFormField(
                  readOnly: oModel.readfields,
                  controller: oModel.qrTextAController,
                  focusNode: oModel.focusNodeA,
                  maxLines: null,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(
                        'assets/images/ic_qr.png', width: 30, height: 30, fit: BoxFit.cover),
                  ),
                  onChanged: (value) {oModel.CargarPedidoFromQR(value);
                  },
                ),
              )
          ),
          FloatingActionButton(
                heroTag: 'refrescarQR',
                backgroundColor: Color(0xffe3e8a3),
                mini: true,
                tooltip: 'Refrescar QR',
                child: new Icon(Icons.clear, color: Colors.black87),
                onPressed: () {oModel.RefrescarCampos();
                FocusScope.of(oContext).requestFocus(oModel.focusNodeA);

                }),
        ]
    )
);

widgetId(USMViewModel oModel) => Visibility(
  visible: false,
  child: TextFormField(
    readOnly: oModel.readfields,
    controller: oModel.idSMA,
  ),
);


widgetotnum(USMViewModel oModel, double dwidth, double dheight) => Padding(
          padding: EdgeInsets.only(
            top: dheight * 0.01,
            left: 10,
            right: 10,
          ),
          child: Card(
            elevation: 8,
            shadowColor: const Color(0xffe3e8a3),
            shape:  OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
            child: TextField(
              readOnly: oModel.readfields,
              decoration: InputDecoration(
                labelText: 'Nº Pedido Óptimus:',
                filled: true,
                fillColor: oModel.readfields == true ? Color(0xffeeeeee): Colors.white,
                contentPadding: EdgeInsets.all(1),
              ),
              controller: oModel.idPedidoA,
              onSubmitted: (value) {oModel.CargarCamposPedido(value, "");},
            ),
          ),
);

widgetCC(USMViewModel oModel, double dwidth, double dheight) => Padding(
      padding: EdgeInsets.only(
        top: dheight * 0.01,
          left: 10,
          right: 10,
      ),
      child: Card(
          elevation: 8,
          color: oModel.readfields == true ? Color(0xffeeeeee): Colors.white,
          shadowColor: const Color(0xffe3e8a3),
          shape:  OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
          child: Column(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft, child:Text("CCoste.:", style: TextStyle(fontSize: 12, color: Colors.grey))),
                StatefulBuilder(builder: (BuildContext context, StateSetter dropDownState){
                  return DropdownButton<String>(
                      value: oModel.getDefaultCC(),
                      isExpanded: true,
                      //hint: new Text("CCoste:"),
                      onChanged: (newValue) {
                        if (oModel.readfields == false){
                        dropDownState(() {
                          oModel.getSelectedCCoste(newValue!);
                        }); }},
                      items: oModel.lstCCostes.map((fc) =>
                          DropdownMenuItem<String>(
                            child: Text(fc.ccoste),
                            value: fc.idcc,
                          )
                      ).toList());
                }),
              ]))
);

widgetForma(USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.01,
        left: 10,
        right: 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        readOnly: oModel.readfields,
        decoration: InputDecoration(
          labelText: 'Forma:',
          filled: true,
          fillColor: oModel.readfields == true ? Color(0xffeeeeee): Colors.white,
          contentPadding: EdgeInsets.all(1),
        ),
        controller: oModel.Forma,
      ),
    ),
);

widgetIdProy(USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.01,
      left: 10,
      right: 10,
    ),
    child: Card(
        elevation: 8,
        color: oModel.readfields == true ? Color(0xffeeeeee): Colors.white,
        shadowColor: const Color(0xffe3e8a3),
        shape:  OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
        child: Column(
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child:Text("Idproy.:", style: TextStyle(fontSize: 12, color: Colors.grey))),
              StatefulBuilder(builder: (BuildContext context, StateSetter dropDownState){
                return DropdownButton<String>(
                    value: oModel.getDefaultProy(),
                    isExpanded: true,
                    //hint: new Text("IdProy.:"),
                    onChanged: (newValue) {
                      if (oModel.readfields == false){
                        dropDownState(() {
                          oModel.getSelectedIdProy(newValue!);
                        }); }},
                    items: oModel.lstIdProy.map((fc) =>
                        DropdownMenuItem<String>(
                          child: Text(fc.idproy),
                          value: fc.idproy,
                        )
                    ).toList());
              }),
            ])
    )
);



widgetNPalet(USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.01,
        left: 10,
        right: 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'N.Palet:',
          filled: true,
          fillColor: Color(0xffeeeeee),
          contentPadding: EdgeInsets.all(1),
        ),
        controller: oModel.NPalet,
      ),
    ),
);

widgetNave(USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.01,
        left: 10,
        right: 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Nave:',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(1),
        ),
        controller: oModel.Nave,
      ),
    ),
);

widgetPasillo(USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.01,
        left: 10,
        right: 10,
    ),
    child: Card(
      elevation: 8,
      shadowColor: const Color(0xffe3e8a3),
      shape:  OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Pasillo:',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(1),
        ),
        controller: oModel.Pasillo,
      ),
    ),
);

widgetBotonera(USMViewModel oModel, BuildContext ocontext, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
        top: dheight * 0.01,
        left: 15
    ),
    child: Flex(
                  direction: dwidth >=768 ? Axis.horizontal : Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff337ab7),
                        ),
                        onPressed: () {
                          oModel.updateubicsemielab("", "", "", "", "", "CANCEL");
                        },
                        child: Text('Cancelar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(width: 25, height: 25),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff337ab7),
                        ),
                        onPressed: () {
                          oModel.refreshResponse("Procesando...");
                          oModel.updateubicsemielab(oModel.idSMA.text, oModel.idPedidoA.text, oModel.Forma.text, oModel.Nave.text, oModel.Pasillo.text, "" );
                          oModel.futureReturnAPI.then((u) => oModel.refreshResponse(u));
                          oModel.futureReturnAPI.then((u) => ScaffoldMessenger.of(ocontext).hideCurrentSnackBar());
                          oModel.futureReturnAPI.then((u) => ScaffoldMessenger.of(ocontext).showSnackBar(SnackBar(content: Text(oModel.responseController.text))) ) ;
                          ScaffoldMessenger.of(ocontext).showSnackBar(SnackBar(content: Text(oModel.responseController.text)));
                        },
                        child: Text('Aceptar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
              ]
          )
);

