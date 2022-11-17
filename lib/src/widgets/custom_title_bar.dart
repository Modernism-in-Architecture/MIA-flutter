import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers.dart';


class CustomTitleBar extends ConsumerWidget{

  const CustomTitleBar({Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appBarTitleProvider);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 40,
              child: Image.asset("lib/assets/images/mia-logo.png")
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              alignment: Alignment.center,
              child: Text(
                  title
              ),
          )
        ]
    );
  }
}
