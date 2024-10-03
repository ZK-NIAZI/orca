import 'package:flutter/cupertino.dart';
import 'package:orca/module/profile/widget/text_rounded_container_widget.dart';

class InterestListWidget extends StatelessWidget {
  final List<String> interestList;
  final List<String> selectedInterest;
  final Function(String) onSelectedInterests;

  const InterestListWidget(
      {super.key,
      required this.interestList,
      required this.onSelectedInterests,
      required this.selectedInterest});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 20,
        runSpacing: 10,
        children: List.generate(interestList.length, (index) {
          bool isSelected = selectedInterest.contains(interestList[index]);
          return TextRoundedContainerWidget(
            title: interestList[index],
            isSelected: isSelected,
            onTap:()=> onSelectedInterests(interestList[index]),
          );
        }));
  }
}
