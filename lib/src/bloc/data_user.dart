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
    userModel.personSurname = await StorageManager.readData('personSurname');
    userModel.idRoleUser = await StorageManager.readData('idRoleUser');
    userModel.roleName = await StorageManager.readData('roleName');
    userModel.versionApp = await StorageManager.readData('versionApp');
    _dataUserController.sink.add(userModel);
  }
}

class UserModel {
  String? idUser;
  String? idPerson;
  String? userNickname;
  String? userEmail;
  String? userImage;
  String? personName;
  String? personSurname;
  String? idRoleUser;
  String? roleName;
  String? versionApp;

  UserModel({
    this.idUser,
    this.idPerson,
    this.userNickname,
    this.userEmail,
    this.userImage,
    this.personName,
    this.personSurname,
    this.idRoleUser,
    this.roleName,
    this.versionApp,
  });
}
