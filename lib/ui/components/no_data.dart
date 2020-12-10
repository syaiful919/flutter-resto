import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        message ?? "Tidak ada data",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
