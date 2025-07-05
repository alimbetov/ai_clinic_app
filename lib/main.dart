import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authorization/presentation/blocs/auth_bloc.dart';
import 'features/authorization/presentation/blocs/auth_state.dart';
import 'features/authorization/presentation/views/login_page.dart';
import 'features/authorization/domain/use_cases/login_user.dart';
import 'features/authorization/data/data_sources/auth_remote_data_source.dart';
import 'features/authorization/data/repositories/auth_repository_impl.dart';
import 'features/authorization/presentation/views/splash_screen.dart';
import 'features/image_processing/data/data_sources/image_remote_data_source.dart';
import 'features/image_processing/data/repositories/image_repository_impl.dart';
import 'features/image_processing/domain/use_cases/upload_image.dart';
import 'features/image_processing/presentation/blocs/image_bloc.dart';
import 'features/image_processing/presentation/views/home_page.dart';

void main() {
  final authRemote = AuthRemoteDataSource();
  final authRepo = AuthRepositoryImpl(authRemote);
  final loginUser = LoginUser(authRepo);

  //final imageRemote = ImageRemoteDataSource();
  // final imageRepo = ImageRepositoryImpl(imageRemote);

  final imageRepo = ImageRepositoryImpl(
    baseUrl: 'http://10.0.2.2:8000/api',
    useMock: true,
  );

  final uploadImage = UploadImage(imageRepo);

  runApp(MyApp(
    authBloc: AuthBloc(loginUser),
    imageBloc: ImageBloc(uploadImage),
  ));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final ImageBloc imageBloc;

  const MyApp({super.key, required this.authBloc, required this.imageBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: imageBloc),
      ],
      child: MaterialApp(
        title: 'AI Clinic',
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) return const SplashScreen();
            if (state is AuthAuthenticated) return const HomePage();
            if (state is AuthError) return const LoginPage();
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
