import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/config/router/app_router.dart';
import 'package:teslo_shop/core/services/key_value_storage_service_impl.dart';
import 'package:teslo_shop/features/login/data/main/repositories/login_repository_impl.dart';
import 'package:teslo_shop/core/presenter/main/bloc/auth_bloc.dart';

void main() async {
  await Environment.initEnironment();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            loginRepository: LoginRepositoryImpl(),
            keyValueStorageService: KeyValueStorageServiceImpl(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: AppTheme().getTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
