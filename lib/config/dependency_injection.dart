import 'package:ai_clinic_app/features/authorization/data/data_sources/auth_remote_data_source.dart';
import 'package:ai_clinic_app/features/authorization/data/repositories/auth_repository_impl.dart';
import 'package:ai_clinic_app/features/authorization/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

import '../features/authorization/domain/use_cases/login_user.dart';
import '../features/authorization/presentation/blocs/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => AuthRemoteDataSource());
}
