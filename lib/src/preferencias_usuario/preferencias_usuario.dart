import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get token {
    return _prefs!.getString('token') ?? '';
  }

  set token(String value) {
    _prefs!.setString('token', value);
  }

  String get nombreUsuario {
    return _prefs!.getString('nombre') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs!.setString('nombre', value);
  }

  String get apellidoUsuario {
    return _prefs!.getString('apellido') ?? '';
  }

  set apellidoUsuario(String value) {
    _prefs!.setString('apellido', value);
  }

  int? get gananciaMaxima {
    return _prefs!.getInt('gananciaMaxima');
  }

  set gananciaMaxima(int? value) {
    _prefs!.setInt('gananciaMaxima', value!);
  }

  String get imageUsuario {
    return _prefs!.getString('image') ?? '';
  }

  set imageUsuario(String value) {
    _prefs!.setString('image', value);
  }

  String get cvUsuario {
    return _prefs!.getString('cvUsuario') ?? '';
  }

  set cvUsuario(String value) {
    _prefs!.setString('cvUsuario', value);
  }

  String get correoUsuario {
    return _prefs!.getString('correo') ?? '';
  }

  set correoUsuario(String correo) {
    _prefs!.setString('correo', correo);
  }

  String get sexo {
    return _prefs!.getString('sexo') ?? '';
  }

  set sexo(String value) {
    _prefs!.setString('sexo', value);
  }
}
