import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission2/provider/preferencesprovider.dart';
import 'package:submission2/provider/schedulingprovider.dart';
import 'package:submission2/widget/customdialog.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Material(
          child: ListTile(
            title: const Text('Restaurant Notification'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: provider.isDailyNewsActive,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledNews(value);
                      provider.enableDailyNews(value);
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
