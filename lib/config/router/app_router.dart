import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presenter/bloc/login_form_bloc.dart';
import 'package:teslo_shop/features/products/products.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => BlocProvider(
        create: (context) => LoginFormBloc(
          loginUserCallback: (email, password) {},
        ),
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    ///* Product Routes
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsScreen(),
    ),
  ],

  ///! TODO: Bloquear si no se está autenticado de alguna manera
);
