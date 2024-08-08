class ApiFlutterConnectMysql {
  /*
  ! Conexion de la BD a archivos dentro de htdocs
  */

  // !Ip del equipo, pc, laptop
  static const _ipHost = "192.168.0.100";
  // ! nombre de la carpeta en htdocs
  static const _nameFolder = "ApiFlutterConnectMysql";

  static const _hostConnect = "http://"+ _ipHost + "/" + _nameFolder;

  /*
  ! Conexion de la BD a archivos especoficos deontro de HTDOCS
  */

  static const _newFile = "/servicios/login.php";
  //static const login = _hostConnect + _newFile;
  static const login = _hostConnect + _newFile;

  static const _newFileProductos = "/servicios/productos.php";
  static const productos = _hostConnect + _newFileProductos;
}
