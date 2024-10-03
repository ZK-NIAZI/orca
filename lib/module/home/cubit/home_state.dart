import '../../profile/model/profile_model.dart';

enum HomeStatus { initial, loading, error, succes }

class HomeState {
  final HomeStatus homeStatus;
  final String message;
  final List<ProfileModel> profiles;

  HomeState(
      {required this.homeStatus, required this.message, required this.profiles});

  factory HomeState.initial() {
    return HomeState(
        homeStatus: HomeStatus.initial, message: '', profiles: []);
  }

  HomeState copyWith(
      {HomeStatus? homeStatus, String? message, List<ProfileModel>? profiles}) {
    return HomeState(
        homeStatus: homeStatus ?? this.homeStatus,
        message: message ?? this.message,
        profiles: profiles ?? this.profiles);
  }
}
