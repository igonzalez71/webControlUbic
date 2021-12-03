//Clases que contienen la estructura de los JSON que se utilizaran para la llamada a las APIS
//tanto de respuesta a los GET, como de llamada a los POST
class Alm_semielab {
  final int id;
  final int idopt;
  final int forma;
  final String ccoste;
  final String idproy;
  final int npalet;
  final String nave;
  final String pasillo;
  //Constructor
  Alm_semielab({required this.id, required this.idopt, required this.forma, required this.ccoste, required this.idproy, required this.npalet, required this.nave, required this.pasillo });

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

