import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/alm_semielab.dart';

Future<List<Alm_semielab>> fetchAlmSemiElab(String cbarras, String strHTTP) async {
  List<Alm_semielab> lstalm_semielab;
  try{
    if (cbarras != "") {
      strHTTP = strHTTP + '/Api/AlmSemiElab/ReadSemiElab/' + cbarras;

      Uri url = Uri.parse(strHTTP);

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

Future<List<CCostes>> fetchCCoste(String strHTTP) async {
  List<CCostes> lstCCostes;
  try{
    Uri url = Uri.parse(strHTTP + '/Api/CCostes');
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      lstCCostes = (json.decode(response.body) as List)
          .map((data) => CCostes.fromJson(data))
          .toList();
    } else {
      lstCCostes = <CCostes>[];
    }
  } catch (e) {
    lstCCostes = <CCostes>[];
  }
  return lstCCostes;
}

Future<String> deleteAlmSemiElab(int idSemiElab, String CCDestino, String strHTTP) async {
  String respuesta = "";
  String strApiSemiElab = "/Api/AlmSemiElab";
  try{
    if ( idSemiElab > 0 && CCDestino != "") {
      Uri url = Uri.parse(strHTTP + strApiSemiElab);
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'Id': idSemiElab.toString(),
          'CCoste': CCDestino,
        }),

      );
      if (response.statusCode == 201) {
        respuesta = response.body.replaceAll("\"", "");
      } else {
        respuesta =  "ERROR de servidor";
      }

    }else{
      respuesta = "ERROR: Debe informar todos los datos";
    }

  } catch (e) {
    respuesta = "Sin conexión a Internet!";
  }
  return respuesta;
}


