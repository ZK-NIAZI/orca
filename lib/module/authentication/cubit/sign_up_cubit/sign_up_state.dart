part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, loading, success, failed }

class SignUpState {
  final SignUpStatus signUpStatus;
  final String message;

  SignUpState({required this.signUpStatus, required this.message});

  factory SignUpState.initial() {
    return SignUpState(signUpStatus: SignUpStatus.initial, message: '');
  }

  SignUpState copyWith({final SignUpStatus? signUpStatus, final String? message}) {
    return SignUpState(signUpStatus: signUpStatus?? this.signUpStatus, message: message??this.message);
  }
}
