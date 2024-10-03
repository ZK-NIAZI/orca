import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:orca/module/profile/model/about_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  ProfileCubit() : super(ProfileState.initial());

  Future<void> addAboutProfile(String userId, AboutModel profile) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      // Save the profile under the user's unique ID
      await _dbRef.child('profiles').child(userId).update(profile.toJson());
      emit(state.copyWith(profileStatus: ProfileStatus.success));
    } catch (e) {

      emit(state.copyWith(profileStatus: ProfileStatus.error,message: e.toString()));
    }
  }

  Future<void> setSingleValue(String userId, String key,String value) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      // Save the profile under the user's unique ID
      await _dbRef.child('profiles').child(userId).child(key).set(value);
      emit(state.copyWith(profileStatus: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error,message: e.toString()));
    }
  }
  Future<void> setList(String userId, String key,List<String> value) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      // Save the profile under the user's unique ID
      await _dbRef.child('profiles').child(userId).child(key).set(value);
      emit(state.copyWith(profileStatus: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error,message: e.toString()));
    }
  }


  Future<void> setProfileStatus(String userId, String profileStatus) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.loading));
      // Save the profile under the user's unique ID
      await _dbRef.child('profilesStatus').child(userId).set(profileStatus);
      emit(state.copyWith(profileStatus: ProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error,message: e.toString()));
    }
  }

}
