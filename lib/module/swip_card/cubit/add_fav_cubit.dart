import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../profile/model/profile_model.dart';
import 'add_fav_state.dart';


class AddFavCubit extends Cubit<AddFavState> {

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  AddFavCubit() : super(AddFavState.initial());

  Future<void> addToFav(String userId,String favId, ProfileModel profile) async {
    try {
      emit(state.copyWith(addFavStatus: AddFavStatus.loading));
      print('adding favorite status ${state.addFavStatus}');
      // Save the profile under the user's unique ID
      await _dbRef.child('Favorite').child(userId).child(favId).update(profile.toJson());
      emit(state.copyWith(addFavStatus: AddFavStatus.success));
      print('adding favorite status ${state.addFavStatus}');
    } catch (e) {
      emit(state.copyWith(addFavStatus: AddFavStatus.error,message: e.toString()));
      print('adding favorite status ${state.addFavStatus}');
    }
  }
}
