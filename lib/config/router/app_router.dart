import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/core/presenter/main/bloc/auth_bloc.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/core/ui/main/screens/loading_screen.dart';
import 'package:teslo_shop/features/login/presenter/main/bloc/login_form_bloc.dart';
import 'package:teslo_shop/features/login/ui/main/auth.dart';
import 'package:teslo_shop/features/products/products.dart';

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/loading',
    refreshListenable: AppRouterNotifier(authBloc),
    redirect: (context, state) {
      final isGoingTo = state.fullPath;
      final authStatus = authBloc.state.authStatus;

      if (authStatus == AuthStatus.checking && isGoingTo == "/loading") {
        return '/loading';
      }
      if (authStatus == AuthStatus.unauthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/loading') return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          final authBloc = context.read<AuthBloc>();

          return BlocProvider(
            create: (context) => LoginFormBloc(
              loginUserCallback: (email, password) {
                authBloc.add(AuthLoginEvent(email, password));
              },
            ),
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],
  );
}
