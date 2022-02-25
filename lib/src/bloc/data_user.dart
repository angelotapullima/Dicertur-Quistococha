import 'package:dicertur_quistococha/core/sharedpreferences/storage_manager.dart';
import 'package:rxdart/rxdart.dart';

class DataUserBloc {
  final _dataUserController = BehaviorSubject<UserModel>();

  Stream<UserModel> get userStream => _dataUserController.stream;

  dispose() {
    _dataUserController.close();
  }

  void obtenerUser() async {
    UserModel userModel = UserModel();
    userModel.idUser = await StorageManager.readData('idUser');
    userModel.idPerson = await StorageManager.readData('idPerson');
    userModel.userNickname = await StorageManager.readData('userNickname');
    userModel.userEmail = await StorageManager.readData('userEmail');
    userModel.userImage = await StorageManager.readData('userImage');
    userModel.personName = await StorageManager.readData('personName');
    userModel.personSurnameP = await StorageManager.readData('personSurnameP');
    userModel.personSurnameM = await StorageManager.readData('personSurnameM');
    userModel.personSurname = await StorageManager.readData('personSurname');
    userModel.idRoleUser = await StorageManager.readData('idRoleUser');
    userModel.roleName = await StorageManager.readData('roleName');
    userModel.versionApp = await StorageManager.readData('versionApp');
    userModel.telefono = await StorageManager.readData('telefono');
    userModel.nacimiento = await StorageManager.readData('nacimiento');
    _dataUserController.sink.add(userModel);
  }
}

Future<UserModel> obtenerUserData() async {
  UserModel userModel = UserModel();
  userModel.idUser = await StorageManager.readData('idUser');
  userModel.idPerson = await StorageManager.readData('idPerson');
  userModel.userNickname = await StorageManager.readData('userNickname');
  userModel.userEmail = await StorageManager.readData('userEmail');
  userModel.userImage = await StorageManager.readData('userImage');
  userModel.personName = await StorageManager.readData('personName');
  userModel.personSurnameP = await StorageManager.readData('personSurnameP');
  userModel.personSurnameM = await StorageManager.readData('personSurnameM');
  userModel.personSurname = await StorageManager.readData('personSurname');
  userModel.idRoleUser = await StorageManager.readData('idRoleUser');
  userModel.roleName = await StorageManager.readData('roleName');
  userModel.versionApp = await StorageManager.readData('versionApp');
  userModel.telefono = await StorageManager.readData('telefono');
  userModel.nacimiento = await StorageManager.readData('nacimiento');
  return userModel;
}

class UserModel {
  String? idUser;
  String? idPerson;
  String? userNickname;
  String? userEmail;
  String? userImage;
  String? personName;
  String? personSurnameP;
  String? personSurnameM;
  String? personSurname;
  String? idRoleUser;
  String? roleName;
  String? versionApp;
  String? telefono;
  String? nacimiento;

  UserModel({
    this.idUser,
    this.idPerson,
    this.userNickname,
    this.userEmail,
    this.userImage,
    this.personName,
    this.personSurnameP,
    this.personSurnameM,
    this.personSurname,
    this.idRoleUser,
    this.roleName,
    this.versionApp,
    this.telefono,
    this.nacimiento,
  });
}
