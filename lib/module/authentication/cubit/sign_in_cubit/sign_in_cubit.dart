import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orca/module/authentication/cubit/sign_in_cubit/sign_in_state.dart';
import '../../../common/repo/session_repository.dart';
import '../../model/sign_up_model.dart';
import '../../repository/user_account_repository.dart';

class SignInCubit extends Cubit<LoginState> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  SignInCubit(this.sessionRepository, this.userAccountRepository)
      : super(LoginState.initial());
  SessionRepository sessionRepository;
  UserAccountRepository userAccountRepository;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {

        await sessionRepository.setLoggedIn(true);
        await userAccountRepository.saveUserInDb(SignUpModel(
            id: credential.user?.uid,
            name: credential.user?.displayName ?? '',
            email: email,
            password: password));

        emit(state.copyWith(
            loginStatus: LoginStatus.success, message: "Login successfully!"));
      } else {
        emit(state.copyWith(
            loginStatus: LoginStatus.error, message: "User not found"));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            loginStatus: LoginStatus.error,
            message: "No user found for that email"));
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            loginStatus: LoginStatus.error,
            message: "Wrong password provided for that user"));
      } else if (e.code == 'network-request-failed') {
        emit(state.copyWith(
            loginStatus: LoginStatus.error,
            message: "Internet connection error please try again"));
      } else if (e.code == 'invalid-credential') {
        emit(state.copyWith(
            loginStatus: LoginStatus.error,
            message: "Email or password is incorrect"));
      } else {
        emit(
            state.copyWith(loginStatus: LoginStatus.error, message: e.message));
      }
    } catch (e) {
      emit(state.copyWith(
          loginStatus: LoginStatus.error, message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      //start loading
      emit(state.copyWith(loginStatus: LoginStatus.loading));

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final userId = userCredential.user?.uid;
        final email = userCredential.user?.email;
        final displayName = userCredential.user?.displayName ?? '';

        await userAccountRepository.saveUserInDb(SignUpModel(
          id: userId,
          name: displayName,
          email: email ?? '',
          password: '',
        ));

        await sessionRepository.setLoggedIn(true);
        emit(state.copyWith(
            loginStatus: LoginStatus.success, message: 'Sign In Successfully'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(state.copyWith(
            loginStatus: LoginStatus.error, message: "Email is not valid"));
      } else if (e.code == 'user-not-found') {
        emit(state.copyWith(
            loginStatus: LoginStatus.error, message: "User not found"));
      } else {
        emit(
            state.copyWith(loginStatus: LoginStatus.error, message: e.message));
      }
      emit(state.copyWith(
          loginStatus: LoginStatus.error,
          message: e.toString())); // Handle errors appropriately
    }
  }

  Future<void> fetchProfileStatus(String userId) async {
    try {
      //emit(state.copyWith(loginStatus: LoginStatus.loading));

      // Fetch the profile status from the database
      DatabaseEvent event = await _dbRef.child('profilesStatus').child(userId).once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        // Assuming the value is a string, you can get it like this
        String profileStatus = snapshot.value as String;
        emit(state.copyWith(loginStatus: LoginStatus.success, profileStatus: profileStatus));
      }else{

        emit(state.copyWith(loginStatus: LoginStatus.success, profileStatus: 'initial'));
      }
    } catch (e) {
      //emit(state.copyWith(loginStatus: LoginStatus.error, message: e.toString()));
    }
  }



}
