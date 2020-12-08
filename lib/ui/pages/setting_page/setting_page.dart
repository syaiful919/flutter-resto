import 'package:flutter/material.dart';
import 'package:resto/viewmodel/setting_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.reactive(
      onModelReady: (model) {},
      viewModelBuilder: () => SettingViewModel(),
      builder: (_, model, __) => Scaffold(
        body:
            Container(alignment: Alignment.center, child: Text("Setting page")),
      ),
    );
  }
}
