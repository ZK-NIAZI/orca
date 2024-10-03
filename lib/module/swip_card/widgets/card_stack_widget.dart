import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orca/module/profile/model/profile_model.dart';

import 'drag_widget.dart';

class CardsStackWidget extends StatefulWidget {
  List<ProfileModel> profiles;

  CardsStackWidget({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget> {
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ValueListenableBuilder(
            valueListenable: swipeNotifier,
            builder: (context, swipe, _) => Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: List.generate(widget.profiles.length, (index) {
                return DragWidget(
                  index: index,
                  imageUrl: '${widget.profiles[index].imageUrl}',
                  name: widget.profiles[index].name,
                  email: widget.profiles[index].about,
                  interest: widget.profiles[index].intersets,
                  orientation: widget.profiles[index].orientation,
                  gender: widget.profiles[index].gender,
                  seeingInterest: widget.profiles[index].seeingInterest,
                  relationship: widget.profiles[index].relationship,
                  age: widget.profiles[index].age,

                  profileModel: widget.profiles[index],
                );
              }),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) {
              setState(() {
                widget.profiles.removeAt(index);
              });
            },
          ),
        ),
        Positioned(
          right: 0,
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) {
              setState(() {
                widget.profiles.removeAt(index);
              });
            },
          ),
        ),
      ],
    );
  }
}
