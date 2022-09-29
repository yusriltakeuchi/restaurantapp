import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/utils/background/backgorund_service_utils.dart';
import 'package:restaurantapp/core/utils/date/date_utils.dart';
import 'package:restaurantapp/core/utils/schedule/schedule_utils.dart';
import 'package:restaurantapp/injector.dart';

class ScheduleProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections 
  ///=========================
 
  /// Schedule status
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Dependency injection
  final scheduleUtils = locator<ScheduleUtils>();

  ///=========================
  /// Function Logic Sections 
  ///=========================

  /// Instance provider
  static ScheduleProvider instance(BuildContext context)
  => Provider.of(context, listen: false);
  
  void setSchedule(bool value) async {
    _isScheduled = value;
    scheduleUtils.setSchedule(_isScheduled);
    notifyListeners();

    if (_isScheduled) {
      AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundServiceUtils.callback,
        startAt: DateTimeFormat.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      await AndroidAlarmManager.cancel(1);
    }
  }

  void getSchedule() async {
    final schedule = await scheduleUtils.getSchedule();
    _isScheduled = schedule;
    notifyListeners();
  }

  /// Set event search
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}