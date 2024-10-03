import 'package:flutter/cupertino.dart';
import 'package:orca/module/profile/widget/text_rounded_container_widget.dart';

class InterestDisplayList extends StatelessWidget {
  final double borderRadius;

  final List<String> interestList;
  const InterestDisplayList({super.key, required this.interestList,  this.borderRadius=6});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: List.generate(interestList.length, (index){
        return TextRoundedContainerWidget(title: interestList[index], isSelected: false, onTap: (){},borderRadius: borderRadius,);

      })
    );
  }
}
