import 'dart:async';
import 'dart:convert';

import 'package:hm_help/src/models/propuesta.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class PropuestasProvider {
  final token = PreferenciasUsuario().token;
  final _propuestasStreamController =
      StreamController<List<Propuesta>>.broadcast();
  final _propuestasTotalStreamController = StreamController<String>.broadcast();

  Function(List<Propuesta>) get propuestasSink =>
      _propuestasStreamController.sink.add;

  Function(String) get propuestasTotalSink =>
      _propuestasTotalStreamController.sink.add;

  Stream<List<Propuesta>> get propuestasStream =>
      _propuestasStreamController.stream;

  Stream<String> get propuestasTotalStream =>
      _propuestasTotalStreamController.stream;

  void dispose() {
    _propuestasStreamController.close();
    _propuestasTotalStreamController.close();
  }

  static String _url = 'mahamtr1-001-site1.ctempurl.com';
  static String _path = 'api/Propuesta/GetMyPropuestas';

  final url = Uri.http(_url, _path);

  Future<List<Propuesta>> getPropuestas() async {
    final propuestas = await _procesarRespuesta();

    final existing = Set<Propuesta>();
    final unique =
        propuestas.where((propuestas) => existing.add(propuestas)).toList();

    propuestasSink(unique);

    return propuestas;
  }

  Future<List<Propuesta>> recargar(String idPropuesta) async {
    final propuestas = await _procesarRespuesta();
    final existing = Set<Propuesta>();
    final unique =
        propuestas.where((propuestas) => existing.add(propuestas)).toList();

    unique.removeWhere((element) => element.id == idPropuesta);
    propuestasSink(unique);

    return propuestas;
  }

  Future<List<Propuesta>> _procesarRespuesta() async {
    final peticion = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    bool isOk = verifyConnection(peticion);

    if (isOk) {
      final decodedData = json.decode(peticion.body);

      final propuestas = new Propuestas.fromJsonList(decodedData);

      return propuestas.items;
    } else {
      return [];
    }
  }

  Future<String> montoTotal() async {
    List<Propuesta> propuestas = await getPropuestas();

    double total = propuestas.fold(0, (sum, item) => sum + item.monto!);

    propuestasTotalSink(total.toString());

    return total.toString();
  }

  void removePropuesta(String propuestaId) async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';
    String _path = 'api/Propuesta/DeletePropuestaById';

    final url = Uri.http(_url, _path);
    final jsonbody = {'id': propuestaId};

    final peticion = await http.delete(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(jsonbody));

    bool isOk = verifyConnection(peticion);
    print(peticion.body);

    isOk
        ? print('Propuesta removida con exito')
        : print('Propuesta no removida');
  }

  bool verifyConnection(http.Response peticion) {
    if (peticion.statusCode != 200) {
      return false;
    } else
      return true;
  }
}