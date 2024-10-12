part of 'auth_bloc.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final UserAccountModel? userAccount;
  final String errorMessage;
  const AuthState(
      {this.authStatus = AuthStatus.checking,
      this.userAccount,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    UserAccountModel? userAccount,
    String? errorMessage,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      userAccount: userAccount ?? this.userAccount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [authStatus, userAccount ?? '', errorMessage];
}
