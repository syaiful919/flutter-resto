import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.s),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
