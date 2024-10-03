import '../../profile/model/profile_model.dart';

enum FavoriteUserStatus { initial, loading, error, succes }

class FavoriteUserState {
  FavoriteUserStatus favoriteUserStatus;
  final String message;
  final List<ProfileModel> favUsers;

  FavoriteUserState({required this.favoriteUserStatus,
    required this.message,
    required this.favUsers});

  factory FavoriteUserState.initial() {
    return FavoriteUserState(
        favoriteUserStatus: FavoriteUserStatus.initial,
        message: '',
        favUsers: []);
  }

  FavoriteUserState copyWith({FavoriteUserStatus? favoriteUserStatus,
    String? message,
    List<ProfileModel>? favUsers}) {
    return FavoriteUserState(
        favoriteUserStatus: favoriteUserStatus ?? this.favoriteUserStatus,
        message: message ?? this.message,
        favUsers: favUsers?? this.favUsers);
  }
}
