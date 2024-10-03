import 'dart:convert';

import 'package:orca/module/authentication/model/sign_up_model.dart';

import '../../../constants/keys.dart';
import '../../../core/storage_services/storage_services.dart';
import '../../../utils/logger/logger.dart';
import '../../common/repo/session_repository.dart';


class UserAccountRepository {
  StorageService storageService;
  SessionRepository sessionRepository;

  UserAccountRepository({required this.storageService, required this.sessionRepository});
  final _log = logger(UserAccountRepository);

  Future<void> saveUserInDb(SignUpModel userModel) async {
    final userMap = userModel.toJson();
    await storageService.setString(StorageKeys.user, json.encode(userMap));
    _log.i('user saved in db');
  }

  SignUpModel getUserFromDb() {
    final userString = storageService.getString(StorageKeys.user);
    if (userString.isNotEmpty) {
      final Map<String, dynamic> userMap = jsonDecode(userString);
      SignUpModel userModel = SignUpModel.fromJson(userMap);
      _log.i('user loaded from local db $userModel');
      return userModel;
    } else {
      return SignUpModel.empty;
    }
  }

  Future<void> removeUserFromDb() async {
    await storageService.remove(StorageKeys.user);
    _log.i('user removed from db');
  }

  Future<void> logout() async {
    await sessionRepository.setLoggedIn(false);
    await sessionRepository.removeToken();
    await removeUserFromDb();
    _log.i('logout successfully');
  }


}