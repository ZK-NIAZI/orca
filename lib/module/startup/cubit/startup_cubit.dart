import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/authentication/model/sign_up_model.dart';
import '../../common/repo/session_repository.dart';
part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  StartupCubit({
    required SessionRepository sessionRepository,
  })  :
        _sessionRepository = sessionRepository,
        super(StartupState.initial());

  final SessionRepository _sessionRepository;

  void init() async {
    await Future.delayed(const Duration(seconds: 5));

    bool isLoggedIn = _sessionRepository.isLoggedIn();
    print("isLoggedIn----$isLoggedIn");
    if (isLoggedIn) {
      emit(state.copyWith(status: Status.authenticated));
    } else {
      emit(state.copyWith(status: Status.unauthenticated));
    }

  }

  Future<void> fetchProfileStatus(String userId) async {
    try {
      //emit(state.copyWith(status: Status.loading));

      // Fetch the profile status from the database
      DatabaseEvent event = await _dbRef.child('profilesStatus').child(userId).once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        // Assuming the value is a string, you can get it like this
        String profileStatus = snapshot.value as String;
        emit(state.copyWith(status: Status.authenticated, profileStatus: profileStatus));


      } else {

        emit(state.copyWith(status: Status.authenticated, profileStatus: 'initial'));
      }
    } catch (e) {
      //emit(state.copyWith(status: Status.error, profileStatus: e.toString()));
    }
  }

}