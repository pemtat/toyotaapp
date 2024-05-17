import 'package:flutter/material.dart';
import 'package:toyotamobile/Styles/boxdecoration.dart';
import 'package:toyotamobile/Styles/margin.dart';

class BoxContainer extends StatelessWidget {
  final List<Widget>? children;
  final Widget? child;
  final double? paddingCustom;

  const BoxContainer({
    Key? key,
    this.children,
    this.child,
    this.paddingCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingCustom ?? PaddingApp),
      decoration: BoxDetail(),
      width: MediaQuery.of(context).size.width,
      child: child ??
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children ?? [],
          ),
    );
  }
}
