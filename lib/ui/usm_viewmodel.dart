import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../core/services/fetchalm_semielab.dart';
import '../core/models/alm_semielab.dart';


class USMViewModel extends ChangeNotifier {

// variables BUSCAR
  Future<List<Alm_semielab>> _lstalm_semielabF = Future.value(<Alm_semielab>[]);
  Future<String> respuesta = Future.value("");
  List<Alm_semielab> _lstalm_semielab = <Alm_semielab>[];
  List<Alm_semielab> get lstalm_semielab => _lstalm_semielab;

  TextEditingController _idPedido = new TextEditingController();
  TextEditingController get idPedido => _idPedido;
  bool _boolbuscar = false;
  bool get boolbuscar => _boolbuscar;

  SemiElabDataSource _semiElabDataSource = new SemiElabDataSource(semielabData:  <Alm_semielab>[]);
  SemiElabDataSource get semiElabDataSource => _semiElabDataSource;

  String _selectCC = "";
  String get selectCC => selectCC;
  Future<List<CCostes>> _lstCCostesF = Future.value(<CCostes>[]);
  List<CCostes> _lstCCostes = <CCostes>[];
  List<CCostes> get lstCCostes => _lstCCostes;
  TextEditingController _qrTextController = TextEditingController();
  TextEditingController get qrTextController => _qrTextController;

// variables AÑADIR
  TextEditingController _idPedidoA = new TextEditingController();
  TextEditingController get idPedidoA => _idPedidoA;
  String _selectACC = "";
  String get selectACC => selectACC;
  TextEditingController _qrTextAController = TextEditingController();
  TextEditingController get qrTextAController => _qrTextAController;
  TextEditingController _Forma = new TextEditingController();
  TextEditingController get Forma => _Forma;
  TextEditingController _IdProy = new TextEditingController();
  TextEditingController get IdProy => _IdProy;
  TextEditingController _NPalet = new TextEditingController();
  TextEditingController get NPalet => _NPalet;
  TextEditingController _Nave = new TextEditingController();
  TextEditingController get Nave => _Nave;
  TextEditingController _Pasillo = new TextEditingController();
  TextEditingController get Pasillo => _Pasillo;


  String _strHTTP = "http://192.168.1.34:8080";

  init() {
    try{
      //Configura una transmisión para recibir eventos en este canal.
      _lstalm_semielab = <Alm_semielab>[];
      _lstCCostesF = fetchCCoste(_strHTTP);
      _lstCCostesF.then((u) => cargarCC(u));
      _boolbuscar = true;

    } catch (e) {
      print(e);
    }
 }

  initmenu(bool popcionmenu){
    if (popcionmenu) {
      _boolbuscar = true;
    } else{
      _boolbuscar = false;
    }
    notifyListeners();
  }

  cargarCC(List<CCostes> olstCCostes){
      _lstCCostes = olstCCostes;
      _selectACC = "SP";
      notifyListeners();
  }

  getSelectedCCoste(String value){
    if (_boolbuscar) {
      _selectCC = value;
    }else{
      _selectACC = value;
    }
  }

  String getDefaultCC(){
    String ret = "";
    if (_boolbuscar) {
      if (_selectCC != "" && _selectCC != null) {
        ret = _selectCC;
      } else {
        ret = "SP";
      }
    } else {
      if (_selectACC != "" && _selectACC != null) {
        ret = _selectACC;
      } else {
        ret = "SP";
      }

    }
    return ret;
  }

    CargarPedidoFromQR(String pPedidoQR){
    try {
        List<String> lstCC = pPedidoQR.split("cc:");
        if (lstCC.length > 2) {
          if (_boolbuscar) {
            _qrTextController.text = "cc:";
          } else {
            _qrTextAController.text = "cc:";
          }
        }

      if (_boolbuscar) {
          List<String> lstBarcode = pPedidoQR.split("otnum:");
          if (lstBarcode.length > 1) {
            List<String> lstBarcode1 = lstBarcode[1].split("\n");
            if (lstBarcode1.length > 1) {
              _idPedido.text = lstBarcode1[0];
              CargarList(_idPedido.text);
            }
          }
      }else{
          List<String> lstBarcodeCC = pPedidoQR.split("cc:");
          if (lstBarcodeCC.length > 1) {
            List<String> lstBarcodeCC1 = lstBarcodeCC[1].split("\n");
            if (lstBarcodeCC1.length > 1 ) {
              for (CCostes cc in _lstCCostes) {
                if (cc.idcc == lstBarcodeCC1[0]) {
                  _selectACC = lstBarcodeCC1[0];
                  notifyListeners();
                }
              }
            }
          }
          List<String> lstBarcodeOT = pPedidoQR.split("otnum:");
          if (lstBarcodeOT.length > 1) {
             List<String> lstBarcodeOT1 = lstBarcodeOT[1].split("\n");
             if (lstBarcodeOT1.length > 1) {
                _idPedidoA.text = lstBarcodeOT1[0];
             }
          }
          List<String> lstBarcodeF = pPedidoQR.split("forma:");
          if (lstBarcodeF.length > 1) {
            List<String> lstBarcodeF1 = lstBarcodeF[1].split("\n");
            if (lstBarcodeF1.length > 1) {
              _Forma.text = lstBarcodeF1[0];
            }
          }
          List<String> lstBarcodeIdP = pPedidoQR.split("idproy:");
          if (lstBarcodeIdP.length > 1) {
            List<String> lstBarcodeIdP1 = lstBarcodeIdP[1].split("\n");
            if (lstBarcodeIdP1.length > 1) {
              _IdProy.text = lstBarcodeIdP1[0];
            }
          }
          List<String> lstBarcodeNPal = pPedidoQR.split("npalet:");
          if (lstBarcodeNPal.length > 1) {
            List<String> lstBarcodeNPal1 = lstBarcodeNPal[1].split("\n");
            if (lstBarcodeNPal1.length > 1) {
              _NPalet.text = lstBarcodeNPal1[0];
            }
          }
      }

    } catch (e) {
      print(e);
    }
  }

  CargarList(String pidPedido){
    try{
        _lstalm_semielabF = fetchAlmSemiElab(_idPedido.text, _strHTTP);
        _lstalm_semielabF.then((u) => refreshList(u));
    } catch (e) {
      print(e);
    }
  }


  refreshList(List<Alm_semielab> lstAlmSemiElab){
    try{
        _lstalm_semielab = lstAlmSemiElab;
        _semiElabDataSource.buildDataGridRows(_lstalm_semielab);
        _semiElabDataSource.updateDataGridSource();
        notifyListeners();

      } catch (e) {
        print(e);
      }
  }

  deleteubicsemielab(int idsemielab, String ccorigen, String strOK){

    try{
      if (strOK == "OK") {
        if (idsemielab > 0 && _selectCC != "") {
          if (ccorigen != _selectCC) {
          respuesta = deleteAlmSemiElab(idsemielab, _selectCC, _strHTTP);
          respuesta.then((u) => CargarList(_idPedido.text));

          } else {
            print("No se puede borrar, CC origen igual al CC destino");
          }
        }
      }
      _selectCC = "";
    } catch (e) {
      print(e);
    }


  }

}

class SemiElabDataSource extends DataGridSource {

  /// Creates the semielab data source class with required details.
  SemiElabDataSource({required List<Alm_semielab> semielabData}) {
    buildDataGridRows(semielabData);
  }

  List<DataGridRow> _semielabData = [];
  @override
  List<DataGridRow> get rows => _semielabData;

  void buildDataGridRows(List<Alm_semielab> semielabData) {
    _semielabData = semielabData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<int>(columnName: 'id', value: e.id),
      DataGridCell<int>(columnName: 'npalet', value: e.npalet),
      DataGridCell<String>(columnName: 'ccoste', value: e.ccoste),
      DataGridCell<int>(columnName: 'forma', value: e.forma),
      DataGridCell<String>(columnName: 'idproy', value: e.idproy),
      DataGridCell<String>(columnName: 'nave', value: e.nave),
      DataGridCell<String>(columnName: 'pasillo', value: e.pasillo),
      DataGridCell<String>(columnName: 'delete', value: ''),
    ]))
        .toList();
  }



  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: (e.columnName == 'delete') ?
                Icon(Icons.delete, color: Colors.black): Text(e.value.toString(), overflow: TextOverflow.ellipsis),
            );
        }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}
