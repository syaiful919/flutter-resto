import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:resto/data/preferences/preferences_helper.dart';
import 'package:resto/utils/background_service.dart';
import 'package:resto/utils/date_time_helper.dart';
import 'package:stacked/stacked.dart';

class SettingViewModel extends BaseViewModel {
  SharedPreferencesHelper _pref;

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<void> firstLoad() async {
    _pref = await SharedPreferencesHelper.getInstance();
    _getDailyNotificationPreferences();
  }

  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive = _pref.getBool(DAILY_NOTIFICATION) ?? false;
    notifyListeners();
  }

  void toogleDailyNotification(bool value) {
    _pref.putBool(DAILY_NOTIFICATION, value);
    _getDailyNotificationPreferences();
    _scheduledNotification(value);
  }

  Future<bool> _scheduledNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Notification Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(minutes: 1),
        1,
        BackgroundService.randomRestaurantCallback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Notification Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
