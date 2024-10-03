import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/module/profile/model/profile_model.dart';
import 'package:orca/module/swip_card/cubit/add_fav_cubit.dart';
import 'package:orca/module/swip_card/widgets/tag_widget.dart';
import '../../../core/di/service_locator.dart';
import '../../authentication/model/sign_up_model.dart';
import '../../authentication/repository/user_account_repository.dart';
import '../../home/widget/user_tile_widget.dart';

enum Swipe { left, right, none }

class DragWidget extends StatelessWidget {
  final int index;
  final String imageUrl;
  final String name;
  final String email;
  final List<String> interest;
  final ProfileModel profileModel;

  final String orientation;
  final String gender;
  final String seeingInterest;
  final String relationship;
  final String age;

  const DragWidget(
      {super.key,
      required this.index,
      required this.imageUrl,
      required this.name,
      required this.email,
      required this.interest,
      required this.profileModel,
      required this.orientation,
      required this.gender,
      required this.seeingInterest,
      required this.relationship,
      required this.age});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFavCubit(),
      child: DragWidgetView(
        index: index,
        imageUrl: imageUrl,
        name: name,
        email: email,
        interest: interest,
        profileModel: profileModel,
        orientation: orientation,
        gender: gender,
        seeingInterest: seeingInterest,
        relationship: relationship,
        age: age,
      ),
    );
  }
}

class DragWidgetView extends StatefulWidget {
  final int index;
  final String imageUrl;
  final String name;
  final String email;
  final List<String> interest;
  final ProfileModel profileModel;
  final String orientation;
  final String gender;
  final String seeingInterest;
  final String relationship;
  final String age;

  const DragWidgetView({
    Key? key,
    required this.index,
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.interest,
    required this.profileModel,
    required this.orientation,
    required this.gender,
    required this.seeingInterest,
    required this.relationship,
    required this.age,
  }) : super(key: key);

  @override
  State<DragWidgetView> createState() => _DragWidgetViewState();
}

class _DragWidgetViewState extends State<DragWidgetView> {
  final userRepo =
      UserAccountRepository(storageService: sl(), sessionRepository: sl());
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);

  @override
  Widget build(BuildContext context) {
    SignUpModel user = userRepo.getUserFromDb();
    return BlocProvider(
      create: (context) => AddFavCubit(),
      child: Center(
        child: Draggable<int>(
          // Data is the value this Draggable stores.
          data: widget.index,
          feedback: Material(
            color: Colors.transparent,
            child: ValueListenableBuilder(
              valueListenable: swipeNotifier,
              builder: (context, swipe, _) {
                return RotationTransition(
                  turns: swipe != Swipe.none
                      ? swipe == Swipe.left
                          ? const AlwaysStoppedAnimation(-15 / 360)
                          : const AlwaysStoppedAnimation(15 / 360)
                      : const AlwaysStoppedAnimation(0),
                  child: Stack(
                    children: [
                      UserTileWidget(
                        height: 600,
                        borderRadius: 15,
                        imageUrl: widget.imageUrl,
                        name: widget.name,
                        about: widget.email,
                        interests: widget.interest,
                        orientation: 'Straight',
                        gender: 'male',
                        seeingInterest: 'women',
                        relationship: 'single',
                        age: '32',
                      ),
                      if (swipe != Swipe.none)
                        Positioned(
                          top: 40,
                          left: swipe == Swipe.right ? 20 : null,
                          right: swipe == Swipe.left ? 20 : null,
                          child: Transform.rotate(
                            angle: swipe == Swipe.right ? 12 : -12,
                            child: TagWidget(
                              text: swipe == Swipe.right
                                  ? 'LIKE ❤️'
                                  : 'DISLIKE 👎',
                              color: swipe == Swipe.right
                                  ? Colors.green[400]!
                                  : Colors.red[400]!,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
            // When Draggable widget is dragged right
            if (dragUpdateDetails.delta.dx.abs() >
                dragUpdateDetails.delta.dy.abs()) {
              if (dragUpdateDetails.delta.dx > 0) {
                swipeNotifier.value = Swipe.right;
              } else {
                swipeNotifier.value = Swipe.left;
              }
            }
          },
          onDragEnd: (drag) {
            if (swipeNotifier.value == Swipe.right) {
              context.read<AddFavCubit>().addToFav(
                  '${user.id}', '${widget.index}', widget.profileModel);
            }
            swipeNotifier.value = Swipe.none;
          },

          childWhenDragging: Container(
            color: Colors.transparent,
          ),

          child: UserTileWidget(
            onUserTap: () {},
            imageUrl: widget.imageUrl,
            name: widget.name,
            about: widget.email,
            interests: widget.interest,
            orientation: widget.orientation,
            gender: widget.gender,
            seeingInterest: widget.seeingInterest,
            relationship: widget.relationship,
            age: widget.age,
          ),
        ),
      ),
    );
  }
}
