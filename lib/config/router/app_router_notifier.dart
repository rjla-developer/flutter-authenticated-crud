import 'package:flutter/material.dart';
import 'package:teslo_shop/core/presenter/main/bloc/auth_bloc.dart';

class AppRouterNotifier extends ChangeNotifier {
  final AuthBloc authBloc;
  AuthStatus _authStatus = AuthStatus.checking;

  AppRouterNotifier(this.authBloc) {
    authBloc.stream.listen((authState) {
      print(
          'Escuchando cambio en App Router Notifier: ${authState.authStatus}');
      _authStatus = authState.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
