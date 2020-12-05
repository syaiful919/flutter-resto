import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Tidak ada data",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
