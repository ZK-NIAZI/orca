import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../model/profile_model.dart';
part 'profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  final DatabaseReference _dbRef;

  ProfileDataCubit(this._dbRef) : super(ProfileDataState.initial());

  Future<void> fetchProfile(String userId) async {
    emit(state.copyWith(profileDataStatus: ProfileDataStatus.loading,message: 'loading'));
    try {
      final snapshot = await _dbRef.child('profiles').child(userId).once();
      if (snapshot.snapshot.value != null) {
        final profile = ProfileModel.fromJson(Map<String, dynamic>.from(snapshot.snapshot.value as Map));
        emit(state.copyWith(profileDataStatus: ProfileDataStatus.succes,profile: profile,message: 'data fetch succesully'));
      } else {
        emit(state.copyWith(profileDataStatus: ProfileDataStatus.error,message:'Profile not found'));
      }
    } catch (e) {
      emit(state.copyWith(profileDataStatus: ProfileDataStatus.error,message: e.toString()));
    }
  }
}
