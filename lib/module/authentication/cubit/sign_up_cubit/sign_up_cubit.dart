import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orca/module/authentication/model/sign_up_model.dart';
import 'package:orca/module/authentication/repository/user_account_repository.dart';

import '../../../common/repo/session_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth;

  SignUpCubit(this._auth, this.sessionRepository, this.userAccountRepository)
      : super(SignUpState.initial());
  SessionRepository sessionRepository;
  UserAccountRepository userAccountRepository;

  Future<void> signUp(String name, String email,
      String password) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.loading));
    try {
      //await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
          email: email, password: password);
      print('id of the user is ${credential.user?.uid}');
      if (credential.user != null) {
        await sessionRepository.setLoggedIn(true);
        await userAccountRepository.saveUserInDb(SignUpModel(
            id:credential.user?.uid,
            name: name,
            email: email,
            password: password));
      }
      emit(state.copyWith(signUpStatus: SignUpStatus.success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'week-password') {
        emit(state.copyWith(
            signUpStatus: SignUpStatus.failed,
            message: "The password provided is to week"));
      } else if (e.code == 'email-already-in-use') {
        emit(state.copyWith(
            signUpStatus: SignUpStatus.failed,
            message: "Account already exists for that email"));
      } else if (e.code == 'network-request-failed') {
        emit(state.copyWith(
            signUpStatus: SignUpStatus.failed,
            message: "Internet connection failed"));
      } else {
        emit(state.copyWith(
            signUpStatus: SignUpStatus.failed, message: e.message));
      }
    } catch (e) {
      emit(state.copyWith(
          signUpStatus: SignUpStatus.failed, message: e.toString()));
    }
  }
}
