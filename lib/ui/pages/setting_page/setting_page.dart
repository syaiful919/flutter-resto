import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto/ui/components/coming_soon_dialog.dart';
import 'package:resto/viewmodel/setting_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => SettingViewModel(),
      builder: (_, model, __) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Pengaturan",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: ListView(
          children: [
            SwitchListTile(
              title: Text("Notifikasi"),
              subtitle: Text("Aktifkan notifikasi"),
              value: model.isDailyNotificationActive,
              onChanged: (val) {
                if (Platform.isAndroid) {
                  model.toogleDailyNotification(val);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => comingSoonDialog(context),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
