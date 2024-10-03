import 'package:flutter/material.dart';
import 'package:orca/utils/extensions/extended_context.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text('$title:',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.titleLarge!
            .copyWith(fontWeight: FontWeight.w700, height: 2.0));
  }
}
class TitleWidgetTwo extends StatelessWidget {
  final String title;

  const TitleWidgetTwo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text('$title:',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.titleLarge!.copyWith(height: 2.0,fontWeight: FontWeight.w600,));
  }
}
