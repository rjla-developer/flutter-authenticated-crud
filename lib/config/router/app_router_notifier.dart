import 'package:flutter/material.dart';
import 'package:teslo_shop/core/presenter/main/bloc/auth_bloc.dart';

class AppRouterNotifier extends ChangeNotifier {
  final AuthBloc authBloc;
  AuthStatus _authStatus = AuthStatus.checking;

  AppRouterNotifier(this.authBloc) {
    // Esto escucha los cambios en el estado de autenticación del AuthBloC
    authBloc.stream.listen((authState) {
      _authStatus = authState.authStatus;
      notifyListeners();
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
