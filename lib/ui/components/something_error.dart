import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';

class SomethingError extends StatelessWidget {
  final String message;
  final VoidCallback action;
  final String actionTitle;

  const SomethingError({
    Key key,
    this.message,
    this.action,
    this.actionTitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 48,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Gap.l, Gap.m, Gap.l, Gap.zero),
            child: Text(
              message ?? "Terjadi kesalahan, coba beberapa saat lagi",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(top: Gap.m),
              child: RaisedButton(
                  onPressed: action, child: Text(actionTitle ?? "Coba lagi")),
            )
        ],
      ),
    );
  }
}
