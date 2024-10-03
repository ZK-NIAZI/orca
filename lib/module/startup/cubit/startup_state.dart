part of 'startup_cubit.dart';

enum Status {
  none,
  unauthenticated,
  authenticated,
  loading,
  error,
  success
}

class StartupState  {
  final Status status;
  final String profileStatus;

  const StartupState( {required this.status,required this.profileStatus,});

  factory StartupState.initial() {
    return const StartupState(
      status: Status.none, profileStatus: '',
    );
  }

  StartupState copyWith({
    Status? status,
    SignUpModel? userModel,
    String? profileStatus,
  }) {
    return StartupState(
      status: status ?? this.status, profileStatus: profileStatus??this.profileStatus,
    );
  }

  @override
  List<Object?> get props => [status];
}