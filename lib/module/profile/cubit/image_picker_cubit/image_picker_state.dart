import 'dart:io';

enum ImagePickerStatus {
  initial,
  uploading,
  succes,
  failed,
}

class ImagePickerState {
  ImagePickerStatus imagePickerStatus;
  String message;
  File? image;

  ImagePickerState(
      {required this.imagePickerStatus, required this.message, this.image});

  factory ImagePickerState.initial() {
    return ImagePickerState(
      imagePickerStatus: ImagePickerStatus.initial,
      message: '',
    );
  }

  ImagePickerState copyWith(
      {final ImagePickerStatus? imagePickerStatus,
      final String? message,
      final File? image}) {
    return ImagePickerState(
      imagePickerStatus: imagePickerStatus ?? this.imagePickerStatus,
      message: message ?? this.message,
      image: image ?? this.image,
    );
  }
}
