enum AddFavStatus { initial, loading, error, success }

class AddFavState {
  final AddFavStatus addFavStatus;
  final String message;

  AddFavState({required this.addFavStatus, required this.message});

  factory AddFavState.initial() {
    return AddFavState(addFavStatus: AddFavStatus.initial, message: '');
  }

  AddFavState copyWith({AddFavStatus? addFavStatus, String? message}) {
    return AddFavState(
        addFavStatus: addFavStatus ?? this.addFavStatus,
        message: message ?? this.message);
  }
}
