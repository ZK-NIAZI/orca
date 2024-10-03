part of 'profile_cubit.dart';

enum ProfileStatus{
  initial,
  loading,
  error,
  success
}
class ProfileState {
  ProfileStatus profileStatus;
  String message;

  ProfileState({required this.profileStatus, required this.message});

  factory ProfileState.initial(){
    return ProfileState(profileStatus: ProfileStatus.initial, message: '');
  }

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    String? message})
  {
    return ProfileState(profileStatus: profileStatus?? this.profileStatus, message: message?? this.message);
  }
}
