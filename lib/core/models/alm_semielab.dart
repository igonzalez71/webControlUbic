//Clases que contienen la estructura de los JSON que se utilizaran para la llamada a las APIS
//tanto de respuesta a los GET, como de llamada a los POST
class Alm_semielab {
  int id;
  int idopt;
  int forma;
  String ccoste;
  String idproy;
  int npalet;
  String nave;
  String pasillo;
  String accion;
  //Constructor
  Alm_semielab({required this.id, required this.idopt, required this.forma, required this.ccoste, required this.idproy, required this.npalet, required this.nave, required this.pasillo, required this.accion });

  factory Alm_semielab.fromJson(Map<String, dynamic> json) {
    return Alm_semielab(
      id: json['Id'],
      idopt: json['Idopt'],
      forma: json['Forma'],
      ccoste: json['CCoste'],
      idproy: json['Idproy'],
      npalet: json['Npalet'],
      nave: json['Nave'],
      pasillo: json['Pasillo'],
      accion: "",
    );
  }
}

class CCostes {
  final String idcc;
  final String ccoste;
  //Constructor
  CCostes({required this.idcc, required this.ccoste });

  factory CCostes.fromJson(Map<String, dynamic> json) {
    return CCostes(
      ccoste: json['CCoste'],
      idcc: json['IdCC'],
    );
  }
}

