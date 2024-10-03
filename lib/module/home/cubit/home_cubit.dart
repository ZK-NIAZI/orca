import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../profile/model/profile_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DatabaseReference _dbRef;

  HomeCubit(this._dbRef) : super(HomeState.initial());

  Future<void> fetchAllProfiles() async {
    emit(state.copyWith(homeStatus: HomeStatus.loading, message: 'loading'));
    try {
      final snapshot = await _dbRef.child('profiles').once();
      if (snapshot.snapshot.value != null) {

        final profilesMap = snapshot.snapshot.value as Map<dynamic, dynamic>;

        List<ProfileModel> profiles = [];
        profilesMap.forEach((key, value) {
          try {
            final profile =
                ProfileModel.fromJson(Map<String, dynamic>.from(value));
            profiles.add(profile);
          } catch (e) {
            print('Error parsing profile for key $key: $e');
          }
        });
        emit(state.copyWith(homeStatus: HomeStatus.succes, profiles: profiles, message: 'Data fetched successfully'));
      } else {
        emit(state.copyWith(
            homeStatus: HomeStatus.error, message: 'No profiles found'));
      }
    } catch (e) {
      emit(state.copyWith(homeStatus: HomeStatus.error, message: e.toString()));
    }
  }
}
