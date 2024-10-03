enum LoginStatus {
  initial,
  loading,
  success,
  userNotFound,
  error,
}

class LoginState {
  final LoginStatus loginStatus;
  final String message;
  final String profileStatus;

  LoginState(
      {required this.loginStatus, required this.message, required this.profileStatus});

  factory LoginState.initial(){
    return LoginState(
        loginStatus: LoginStatus.initial, message: '', profileStatus: '');
  }

  LoginState copyWith({
    final LoginStatus? loginStatus,
    final String? message, final String? profileStatus}) {
    return LoginState(loginStatus: loginStatus ?? this.loginStatus,
        message: message ?? this.message,
        profileStatus: profileStatus ?? this.profileStatus);
  }
}