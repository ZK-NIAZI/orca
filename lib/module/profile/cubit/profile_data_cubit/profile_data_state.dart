part of 'profile_data_cubit.dart';

enum ProfileDataStatus { initial,loading, error, succes }

class ProfileDataState {
  final ProfileDataStatus profileDataStatus;
  final String message;
  final ProfileModel? profile;

  ProfileDataState(
      {required this.profileDataStatus, required this.message, this.profile});

  factory ProfileDataState.initial() {
    return ProfileDataState(
      profileDataStatus: ProfileDataStatus.initial,
      message: '',
      profile: null
    );
  }

  ProfileDataState copyWith({ProfileDataStatus? profileDataStatus,
    String? message,
    ProfileModel? profile}) {
    return ProfileDataState(
        profileDataStatus: profileDataStatus ?? this.profileDataStatus,
        message: message ?? this.message,
        profile: profile ?? this.profile,
    );
  }
}
