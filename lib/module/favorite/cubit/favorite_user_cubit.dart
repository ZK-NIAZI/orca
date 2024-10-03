import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../profile/model/profile_model.dart';
import 'favorite_user_state.dart';

class FavoriteUserCubit extends Cubit<FavoriteUserState> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  FavoriteUserCubit() : super(FavoriteUserState.initial());

  Future<void> fetchAllProfiles(String userId) async {
    emit(state.copyWith(
        favoriteUserStatus: FavoriteUserStatus.loading, message: 'loading'));
    try {
      final snapshot = await _dbRef.child('Favorite').child(userId).once();
      if (snapshot.snapshot.value != null) {
        //print('the fetched data is ${snapshot.snapshot.value}');

        final profilesList = snapshot.snapshot.value as List<dynamic>;
        //final profilesMap = snapshot.snapshot.value as Map<dynamic,dynamic>;

        List<ProfileModel> profiles = [];

        /*profilesMap.forEach((key, value) {
          try {
            final profile = ProfileModel.fromJson(Map<String, dynamic>.from(value));
            profiles.add(profile);
          } catch (e) {
            print('Error parsing profile for key $key: $e');
          }
        });*/

        for (var value in profilesList) {
          try {
            // Convert each profile map into a ProfileModel
            final profile =
                ProfileModel.fromJson(Map<String, dynamic>.from(value));
            profiles.add(profile);
          } catch (e) {
            print('Error parsing profile: $e');
          }
        }

        emit(state.copyWith(
            favoriteUserStatus: FavoriteUserStatus.succes,
            favUsers: profiles,
            message: 'Data fetched successfully'));
      } else {
        emit(state.copyWith(
            favoriteUserStatus: FavoriteUserStatus.error,
            message: 'No profiles found'));
      }
    } catch (e) {
      emit(state.copyWith(
          favoriteUserStatus: FavoriteUserStatus.error,
          message: 'Please Select 3 profiles as Favorite to see Favorite List'));
      print(e.toString());
    }
  }
}
