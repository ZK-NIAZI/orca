import 'package:flutter/material.dart';
import 'package:orca/utils/extensions/extended_context.dart';

class DetailWidget extends StatelessWidget {
  final String detail;
  DetailWidget({super.key,required this.detail});

  @override
  Widget build(BuildContext context) {
    return Text('$detail',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.titleLarge!
            .copyWith(fontWeight: FontWeight.w400, height: 2.0,));
  }
  }
