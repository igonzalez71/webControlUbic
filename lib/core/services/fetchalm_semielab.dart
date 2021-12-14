import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/alm_semielab.dart';

Future<List<Alm_semielab>> fetchAlmSemiElab(String pcbarras, String pstrHTTP) async {
  List<Alm_semielab> lstalm_semielab;
  try{
    if (pcbarras != "" && pstrHTTP != "") {
      pstrHTTP = pstrHTTP + '/Api/AlmSemiElab/ReadSemiElab/' + pcbarras;

      Uri url = Uri.parse(pstrHTTP);

      final response = await http.get(url, headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
      },);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        lstalm_semielab = (json.decode(response.body) as List).map((data) => Alm_semielab.fromJson(data)).toList();
      } else {
        // Si la API no devuelve 200, return lista vacía
        lstalm_semielab = <Alm_semielab>[];
      }
    }else{
      //si el cbarras no tiene nada devolvemos la lista vacía
      lstalm_semielab = <Alm_semielab>[];
    }
  } catch (e) {
    lstalm_semielab = <Alm_semielab>[];
  }
  return lstalm_semielab;
}

Future<List<CCostes>> fetchCCoste(String pstrHTTP) async {
  List<CCostes> lstCCostes;
  lstCCostes = <CCostes>[];
  try{
    if (pstrHTTP != "") {
      Uri url = Uri.parse(pstrHTTP + '/Api/CCostes');
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        lstCCostes = (json.decode(response.body) as List)
            .map((data) => CCostes.fromJson(data))
            .toList();
      }
    }
  } catch (e) {
    lstCCostes = <CCostes>[];
  }
  return lstCCostes;
}

Future<String> AccionAlmSemiElab(Alm_semielab pAlm_semielab, List<CCostes> plstCCostes, String pstrHTTP) async {
  String respuesta = "";
  String strApiSemiElab = "/Api/AlmSemiElab";
  try{
    if (pstrHTTP != "") {
      if (pAlm_semielab.accion == "DELETE") {
        if (pAlm_semielab.id > 0 && pAlm_semielab.ccoste != "") {
          Uri url = Uri.parse(pstrHTTP + strApiSemiElab);
          final http.Response response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'Id': pAlm_semielab.id.toString(),
              'CCoste': pAlm_semielab.ccoste,
              'Accion': pAlm_semielab.accion,
            }),
          );
          if (response.statusCode == 201) {
            respuesta = response.body.replaceAll("\"", "");
          } else {
            respuesta = "ERROR de servidor";
          }
        } else {
          respuesta = "ERROR: Debe informar todos los datos";
        }
      } else if (pAlm_semielab.accion == "UPDATE") {
        if (pAlm_semielab.id > 0 && pAlm_semielab.nave != "" &&
            pAlm_semielab.pasillo != "") {
          Uri url = Uri.parse(pstrHTTP + strApiSemiElab);
          final http.Response response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'Id': pAlm_semielab.id.toString(),
              'Nave': pAlm_semielab.nave,
              'Pasillo': pAlm_semielab.pasillo,
              'Accion': pAlm_semielab.accion,
            }),
          );
          if (response.statusCode == 201) {
            respuesta = response.body.replaceAll("\"", "");
          } else {
            respuesta = "ERROR de servidor";
          }
        } else {
          respuesta = "ERROR: Debe informar todos los datos";
        }
      } else if (pAlm_semielab.accion == "INSERT") {
        String resp = validarCampos(pAlm_semielab, plstCCostes);
        if (resp == '') {
          Uri url = Uri.parse(pstrHTTP + strApiSemiElab);
          final http.Response response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'Idopt': pAlm_semielab.idopt.toString(),
              'Forma': pAlm_semielab.forma.toString(),
              'CCoste': pAlm_semielab.ccoste,
              'Idproy': pAlm_semielab.idproy.toString(),
              'Nave': pAlm_semielab.nave,
              'Pasillo': pAlm_semielab.pasillo,
              'Accion': pAlm_semielab.accion,
            }),
          );
          if (response.statusCode == 201) {
            respuesta = response.body.replaceAll("\"", "");
          } else {
            respuesta = "ERROR de servidor " + response.body.replaceAll("\"", "");
          }
        } else {
          respuesta = resp;
        }
      }
    } else {
      respuesta = "ERROR de conexión con la API";
    }

  } catch (e) {
      respuesta = "ERROR en el " + pAlm_semielab.accion;
  }
  return respuesta;
}


String validarCampos(Alm_semielab pAlm_semielab, List<CCostes> plstCCostes){
  String ret = "";
  try{
    CCostes mccoste = plstCCostes.firstWhere((element) => element.idcc == pAlm_semielab.ccoste, orElse: () => CCostes(idcc: '', ccoste: '', tipo: ''));

    if (pAlm_semielab.ccoste == "" && (pAlm_semielab.idopt == 0 )) {
      ret = "ERROR: Debe informar el Centro de Coste";
    } else if (pAlm_semielab.ccoste == 'N1' || pAlm_semielab.ccoste == 'N2' || pAlm_semielab.ccoste == 'N3') {
      if (pAlm_semielab.idproy == 0) { ret = "ERROR: Debe informar el proyecto"; };
      if (pAlm_semielab.idopt == 0) { ret = "ERROR: Debe informar el pedido";};
    } else if (pAlm_semielab.ccoste == 'SP') {
        if (pAlm_semielab.idopt == 0) { ret = "ERROR: Debe informar el pedido"; };
    } else {
      switch (mccoste.tipo) {
        case 'RN':
          if (pAlm_semielab.forma == 0){ret = "ERROR: Debe informar la forma";}
          if (pAlm_semielab.idopt == 0){ret = "ERROR: Debe informar el pedido";}
          break;
        case 'E':
           if (pAlm_semielab.idproy == 0){ret = "ERROR: Debe informar el proyecto";}
           if (pAlm_semielab.idopt == 0){ret = "ERROR: Debe informar el pedido";}
           break;
        }
    }
    if (pAlm_semielab.nave == '' || pAlm_semielab.pasillo == '') { ret = "ERROR: Debe informar Nave y Pasillo";}

  } catch (e) {
    ret = "ERROR en el " + e.toString();
  }
  return ret;
}

Future<List<Proyectos>> fetchIdProy(String pidPedido, String pstrHTTP) async {
  List<Proyectos> lstProy;
  lstProy = <Proyectos>[];
  try{
    if (pstrHTTP != "" && pidPedido != "") {
      Uri url = Uri.parse(pstrHTTP + '/Api/AlmSemiElab/ReadProyectos/' + pidPedido);
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        lstProy = (json.decode(response.body) as List)
            .map((data) => Proyectos.fromJson(data))
            .toList();
      }
    }
  } catch (e) {
    lstProy = <Proyectos>[];
  }
  return lstProy;
}




