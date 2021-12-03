import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'usm_viewmodel.dart';
import 'dialogs.dart';


widgetUbuscar(USMViewModel oModel, BuildContext ocontext, double dwidth, double dheight) =>
    Container(
        child: Row(children: [
          Expanded(
            child: Column(
                children: <Widget>[
                  Center(
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
                          controller: oModel.qrTextController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: "Cógido QR",
                          ),
                          onChanged: (value) {oModel.CargarPedidoFromQR(value);},
                        ),
                      ),
                    ),
                  ),
                  Center(
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
                  ),
                  Center(
                    heightFactor: 1,
                    child: Padding(
                        padding: EdgeInsets.only(
                          top: dheight * 0.02,
                          left: dwidth / 10,
                          right: dwidth / 10,
                        ),
                        child: SfDataGridTheme(
                            data: SfDataGridThemeData(headerColor: const Color(0xffe3e8a3)),
                            child: SfDataGrid(
                              source: oModel.semiElabDataSource,
                              columnWidthMode: ColumnWidthMode.fill,
                              selectionMode: SelectionMode.single,
                              onCellTap:  (DataGridCellTapDetails details) async {
                                if (details.column.columnName == "delete"){
                                  final String strOK = await showDeleteDialog(ocontext, oModel);
                                  var idsemielab = oModel.semiElabDataSource
                                      .effectiveRows[details.rowColumnIndex
                                      .rowIndex - 1].getCells()[0].value;
                                  var ccorigen = oModel.semiElabDataSource
                                      .effectiveRows[details.rowColumnIndex
                                      .rowIndex - 1].getCells()[2].value;
                                  oModel.deleteubicsemielab(idsemielab, ccorigen, strOK);
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

                              ],
                            ))),
                  ),
                ]),
          ),
        ])
    );

