import 'package:flutter/cupertino.dart';
import 'package:orca/ui/widget/selectable_text_widget.dart';

class GenderListWidget extends StatelessWidget {
  final List<String> genderList;
  final String selectedGender;
  final Function(String) onSelectedGender;

  const GenderListWidget(
      {super.key,
        required this.genderList,
        required this.onSelectedGender,
        required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(genderList.length, (index) {
          bool isSelected = selectedGender==genderList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SelectableTextWidget(
              width: MediaQuery.of(context).size.width,
              height: 50,
              initialColor: CupertinoColors.white,
              fontSize: 16,
              hPadding: 0,
              vPadding: 0,
              borderRadius: 4,
              title: genderList[index],
              isSelected: isSelected,
              onTap:()=> onSelectedGender(genderList[index]),
            ),
          );
        }));
  }
}
