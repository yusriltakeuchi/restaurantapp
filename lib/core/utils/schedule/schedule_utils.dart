import 'package:restaurantapp/core/utils/global/shared_manager.dart';

class ScheduleUtils {
  final _key = "schedule_restaurant";

  Future<bool> getSchedule() async {
    final shared = SharedManager<bool>();
    return await shared.read(_key) ?? false;
  }

  Future<void> setSchedule(bool value) {
    final shared = SharedManager<bool>();
    return shared.store(_key, value);
  }
}