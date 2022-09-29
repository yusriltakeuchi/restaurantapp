import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/core/viewmodels/schedule/schedule_provider.dart';
import 'package:restaurantapp/ui/constant/constant.dart';
import 'package:restaurantapp/ui/widgets/dialog/snackbar_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Setting",
          style: styleTitle.copyWith(
            fontSize: setFontSize(55),
            color: Colors.white,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ScheduleProvider(),
        child: const SettingBody(),
      ),
    );
  }
}

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScheduleProvider.instance(context).getSchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(30),
        vertical: setHeight(30),
      ),
      child: Consumer<ScheduleProvider>(
        builder: (context, scheduleProv, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _settingItem(
                title: "Restaurant Notification",
                description: "Enable push notification",
                value: scheduleProv.isScheduled,
                onChange: (value) {
                  if (Platform.isAndroid) {
                    ScheduleProvider.instance(context).setSchedule(value);
                  } else {
                    showSnackbar(
                      title: "This feature only for Android Devices",
                      color: primaryColor
                    );
                  }
                }
              )
            ],
          );
        },
      ),
    );
  }

  Widget _settingItem({
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChange,
  }) {
    return InkWell(
      onTap: () => onChange(!value),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: styleTitle.copyWith(
                  fontSize: setFontSize(40),
                  color: blackColor,
                ),
              ),
              Text(
                description,
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(40),
                  color: grayColor,
                ),
              ),
            ],
          ),
          Switch.adaptive(
            value: value,
            onChanged: (value) => onChange(value),
          )
        ],
      ),
    );
  }
}
