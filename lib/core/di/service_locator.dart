import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/environment.dart';
import '../../module/authentication/repository/user_account_repository.dart';
import '../../module/common/repo/session_repository.dart';
import '../security/secured_auth_storage.dart';
import '../storage_services/storage_services.dart';

final sl = GetIt.instance;

void setupLocator(Environment environment) async {
  // env
  sl.registerLazySingleton<Environment>(() => environment);

  // sp
  sl.registerSingletonAsync<SharedPreferences>(
          () async => SharedPreferences.getInstance());

  // modules
  sl.registerSingletonWithDependencies<StorageService>(
        () => StorageService(sharedPreferences: sl()),
    dependsOn: [SharedPreferences],
  );

  sl.registerLazySingleton<AuthSecuredStorage>(() => AuthSecuredStorage());


  /// ************************************** Authentication **************************************

  sl.registerLazySingleton<SessionRepository>(
        () => SessionRepository(
      storageService: sl<StorageService>(),
      authSecuredStorage: sl<AuthSecuredStorage>(),
    ),
  );

  sl.registerLazySingleton<UserAccountRepository>(
        () => UserAccountRepository(
      storageService: sl<StorageService>(),
      sessionRepository: sl<SessionRepository>(),
    ),
  );
}