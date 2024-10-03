import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerState.initial());


  final FirebaseStorage _storage = FirebaseStorage.instance;
  // Example for Firebase Realtime Database
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future pickAndUploadImage(String userId) async {
    emit(state.copyWith(imagePickerStatus: ImagePickerStatus.uploading));
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        File imageFile = File(image.path);
        await uploadImage(imageFile,userId);
        emit(state.copyWith(
            imagePickerStatus: ImagePickerStatus.succes, image: imageFile));
        print('the picked Image is $imageFile');


      } else {
        emit(state.copyWith(
            imagePickerStatus: ImagePickerStatus.failed,
            message: 'Failed to pick image...'));
      }
    } on PlatformException catch (e) {
      emit(state.copyWith(
          imagePickerStatus: ImagePickerStatus.failed,
          message: 'Failed to pick image: $e'));
      print('Failed to pick image: $e');
    }
  }

  Future<void> uploadImage(File imageFile,String userId) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('images/$fileName');

      // Upload the image file
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      // Check if the upload was successful
      if (snapshot.state == TaskState.success) {
        // Get the download URL of the uploaded image
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the profile under the user's unique ID in the database
        await _dbRef.child('profiles').child(userId).update({
          'imageUrl': downloadUrl,
        });

        emit(state.copyWith(
          imagePickerStatus: ImagePickerStatus.succes,
          message: 'Image uploaded and saved successfully!',
        ));
      } else {
        emit(state.copyWith(
          imagePickerStatus: ImagePickerStatus.failed,
          message: 'Failed to upload image',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        imagePickerStatus: ImagePickerStatus.failed,
        message: 'Upload error: $e',
      ));
      print('Upload error: $e');
    }
  }



  Future<void> listenForPermissions() async {
    final status = await Permission.mediaLibrary.status;
    if (status.isDenied) {
      await requestForPermission();
    }
  }

  Future<void> requestForPermission() async {
    await Permission.mediaLibrary.request();
  }
}
