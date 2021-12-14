import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/services/fetchalm_semielab.dart';
import '../core/models/alm_semielab.dart';


class USMViewModel extends ChangeNotifier {

  var _strHTTP;

// variables BUSCAR
  Future<List<Alm_semielab>> _lstalm_semielabF = Future.value(<Alm_semielab>[]);
  Future<String> _futureReturnAPI = Future.value("");
  Future<String> get futureReturnAPI => _futureReturnAPI;
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
  String _qr = "";
  String get qr => _qr;
  DataGridController _dataGridController = DataGridController();
  DataGridController get dataGridController => _dataGridController;
  FocusNode _focusNode = FocusNode();
  FocusNode get focusNode => _focusNode;

// variables AÑADIR
  TextEditingController _idSMA = new TextEditingController();
  TextEditingController get idSMA => _idSMA;
  TextEditingController _idPedidoA = new TextEditingController();
  TextEditingController get idPedidoA => _idPedidoA;
  String _selectACC = "";
  String get selectACC => selectACC;
  TextEditingController _qrTextAController = TextEditingController();
  TextEditingController get qrTextAController => _qrTextAController;
  String _qrA = "";
  String get qrA => _qrA;

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
  TextEditingController _responseController = new TextEditingController();
  TextEditingController get responseController => _responseController;
  bool _readfields = false;
  bool get readfields => _readfields;
  FocusNode _focusNodeA = FocusNode();
  FocusNode get focusNodeA => _focusNodeA;



//Rutines REFRESH i init
  init() {
    try{
       //_strHTTP = dotenv.env['api_url'];
      _strHTTP = "http://192.168.1.39:8080";
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
    RefrescarCampos();
    notifyListeners();
  }

  RefrescarCampos(){
    _responseController.text = "";
    _readfields = false;

    if (_boolbuscar) {
      _qrTextController.text = "";
      _qr = "";
      _idPedido.text = "";
      CargarList(_idPedido.text);
    } else {
      _qrTextAController.text = "";
      _qrA = "";
      _idSMA.text = "";
      _idPedidoA.text = "";
      _Forma.text = "";
      _IdProy.text = "";
      _NPalet.text = "";
      _Nave.text = "";
      _Pasillo.text = "";
    }
  }

  refreshResponse(String contenido) {
    _responseController.text = contenido;
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

  //Funciones de carga del datagrid
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


  //Funció que és cridada desdel buscar / Edit i inicialitza el camps d'AÑADIR-
  EditSM(String idSM, String npalet, String cc, String forma, String idproy, String nave, String pasillo)
  {
    _boolbuscar = false;
    _idSMA.text = idSM;
    _idPedidoA.text = _idPedido.text;
    _NPalet.text = npalet;
    _selectACC = cc;
    _Forma.text = forma;
    _IdProy.text = idproy;
    _Nave.text = nave;
    _Pasillo.text = pasillo;
    _readfields = true;
    _responseController.text = "";
    notifyListeners();
  }

//Funció que carrega els camps llegint del QR
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
          List<String> lstBarcodeNPal = pPedidoQR.split("npalet:");
          if (lstBarcodeNPal.length > 1) {
            List<String> lstBarcodeNPal1 = lstBarcodeNPal[1].split("\n");
            if (lstBarcodeNPal1.length > 1) {
              _qr = _qrTextController.text;
              _qrTextController.text = "QR leído";
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
              _qrA = _qrTextAController.text;
              _qrTextAController.text = "QR leído";
            }
          }
      }

    } catch (e) {
      print(e);
    }
  }

//Funció cridada que borra un registre del semielaborado
  deleteubicsemielab(int idsemielab, String ccorigen, String strOK){

    try{
      if (strOK == "OK") {
        if (idsemielab > 0 ) {
          if (ccorigen != _selectCC && _selectCC != "") {
            Alm_semielab oAlm_semielab = new Alm_semielab(id: idsemielab, idopt: 0, forma: 0, ccoste: _selectCC, idproy: "", npalet: 0, nave: "", pasillo: "", accion: "DELETE");
            _futureReturnAPI = AccionAlmSemiElab(oAlm_semielab, _strHTTP);
            _futureReturnAPI.then((u) => CargarList(_idPedido.text));

          } else if (ccorigen == _selectCC || _selectCC == "") {
            _futureReturnAPI = Avisos("No puede borrarse el idSemiElab: " + idsemielab.toString() + ", CC origen igual al CC destino");
          }
        }
      }
      _selectCC = "";
    } catch (e) {
      _futureReturnAPI = Avisos("ERROR $e");
    }
  }

  Future<String> Avisos(String message) async {
    String respuesta = message;
    return respuesta;
  }


//Funció cridada des del AÑADIR, que et fa l'INSERT o l'UPDATE del Semielaborado
  updateubicsemielab(String pidsemielab, String pidPedido, String pIdProy, String pForma, String pnave, String ppasillo, String pAccion){
    try{
      if (pAccion!= "CANCEL"){
        if (pidsemielab != "" && pidsemielab != "0" && pnave != "" && ppasillo != "") {
          Alm_semielab oAlm_semielab = Alm_semielab(id: int.parse(pidsemielab),
              idopt: 0,
              forma: 0,
              ccoste: "",
              idproy: "",
              npalet: 0,
              nave: pnave,
              pasillo: ppasillo,
              accion: "UPDATE");
          _futureReturnAPI = AccionAlmSemiElab(oAlm_semielab, _strHTTP);
          _futureReturnAPI.then((u){
            RefrescarCampos();
            _boolbuscar = true;
             CargarList(_idPedido.text);
             notifyListeners();
          });
        } else {
          Alm_semielab oAlm_semielab = Alm_semielab(id: 0,
              idopt: int.parse(pidPedido),
              forma: int.parse(pForma),
              ccoste: _selectACC,
              idproy: pIdProy,
              npalet: 0,
              nave: pnave,
              pasillo: ppasillo,
              accion: "INSERT");
          _futureReturnAPI = AccionAlmSemiElab(oAlm_semielab, _strHTTP);
          _futureReturnAPI.then((u){
            if (u.toString().toUpperCase().contains("NPALET:")) {
              RefrescarCampos();
              notifyListeners();
            }
          });
        }
      } else {
        RefrescarCampos();
        _boolbuscar = true;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }


}


//Classe pel tractament del datagrid del Buscar
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
      DataGridCell<String>(columnName: 'editar', value: ''),
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
                Icon(Icons.delete, color: Colors.black): (e.columnName == 'editar') ? Icon(Icons.edit, color: Colors.black): Text(e.value.toString(), overflow: TextOverflow.ellipsis),
            );
        }).toList());
  }



  void updateDataGridSource() {
    notifyListeners();
  }
}
