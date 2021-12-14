import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'usm_viewmodel.dart';
import 'dialogs.dart';


widgetUbuscar(USMViewModel oModel, BuildContext ocontext, double dwidth, double dheight) =>
    SingleChildScrollView(
        child: Row(children: [
          Expanded(
            child: Column(
                children: <Widget>[
                  widgetQR(ocontext, oModel, dwidth, dheight),
                  widgetPedido(oModel, dwidth, dheight),
                  widgetList(oModel, ocontext, dwidth, dheight),

                ]),
          ),
        ])
    );

widgetQR(BuildContext oContext, USMViewModel oModel, double dwidth, double dheight) => Padding(
    padding: EdgeInsets.only(
        top: 10,
        left: 10,
        ),
    child: Row(
          children: <Widget>[
            SizedBox(
                width: dwidth / 3,
                child: ExpansionTile(
                  title: Text('QR'),
                  children: <Widget>[
                    ListTile(title: Text(oModel.qr)),
                  ],
                ),

            ),

            SizedBox(
                width: dwidth / 3,
                child: Card(
                elevation: 8,
                shadowColor: const Color(0xffe3e8a3),
                shape:  OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
                  child: TextField(
                    controller: oModel.qrTextController,
                    focusNode: oModel.focusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                          'assets/images/ic_qr.png', width: 30, height: 30, fit: BoxFit.cover),
                    ),
                    onChanged: (value) {oModel.CargarPedidoFromQR(value);},
                  ),
                )
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 25,
              child: FloatingActionButton(
                  heroTag: 'refrescarQR',
                  backgroundColor: Color(0xffe3e8a3),
                  mini: true,
                  tooltip: 'Refrescar QR',
                  child: new Icon(Icons.clear, color: Colors.black87),
                  onPressed: () {oModel.RefrescarCampos();
                  FocusScope.of(oContext).requestFocus(oModel.focusNode);
                  }),
            ),
          ]
      )
);

widgetPedido(USMViewModel oModel, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
    padding: EdgeInsets.only(
      top: dheight * 0.02,
      left: 10,
    ),
    child: Card(
        elevation: 8,
        shadowColor: const Color(0xffe3e8a3),
        shape:  OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffe3e8a3), width: 1)),
        child: TextField(
          controller: oModel.idPedido,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: 'Nº Pedido Óptimus:',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(1),
          ),
          onSubmitted: (value) {oModel.CargarList(value);},
        )
    ),

  ),
);

widgetList(USMViewModel oModel, BuildContext ocontext, double dwidth, double dheight) => Center(
  heightFactor: 1,
  child: Padding(
      padding: EdgeInsets.only(
        top: dheight * 0.02,
        left: 10,
      ),
      child: SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: const Color(0xffe3e8a3)),
          child: SfDataGrid(
            source: oModel.semiElabDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            selectionMode: SelectionMode.single,
            allowEditing: true,
            onCellTap:  (DataGridCellTapDetails details) async {
              if (details.column.columnName == "delete") {
                final String strOK = await showDeleteDialog(ocontext, oModel);
                var idsemielab = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[0].value;
                var ccorigen = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[2].value;
                oModel.deleteubicsemielab(idsemielab, ccorigen, strOK);
                oModel.futureReturnAPI.then((u) => oModel.refreshResponse(u));
                oModel.futureReturnAPI.then((u) => ScaffoldMessenger.of(ocontext).hideCurrentSnackBar());
                oModel.futureReturnAPI.then((u) => ScaffoldMessenger.of(ocontext).showSnackBar(SnackBar(content: Text(oModel.responseController.text))) ) ;

              }else if (details.column.columnName == "editar"){
                var idSM = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[0].value.toString();
                var npalet = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[1].value.toString();
                var cc = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[2].value;
                var forma = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[3].value.toString();
                var idproy = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[4].value;
                var nave = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[5].value;
                var pasillo = oModel.semiElabDataSource
                    .effectiveRows[details.rowColumnIndex
                    .rowIndex - 1].getCells()[6].value;
                oModel.EditSM(idSM, npalet, cc, forma, idproy, nave, pasillo);
              }
            },
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'id',
                  allowEditing: false,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('ID'),
                  )),
              GridColumn(
                  columnName: 'npalet',
                  allowEditing: false,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Npalet'),
                  )),
              GridColumn(
                  columnName: 'ccoste',
                  allowEditing: false,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('CCoste'),
                  )),
              GridColumn(
                  columnName: 'forma',
                  allowEditing: false,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Forma'),
                  )),
              GridColumn(
                  columnName: 'idproy',
                  allowEditing: false,
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Idproy'),
                  )),
              GridColumn(
                  columnName: 'nave',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Nave'),
                  )),
              GridColumn(
                  columnName: 'pasillo',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Pasillo'),
                  )),
              GridColumn(
                  columnName: 'delete',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Borrar'),
                  )),
              GridColumn(
                  columnName: 'editar',
                  label: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text('Editar'),
                  )),

            ],
          ))),
);
