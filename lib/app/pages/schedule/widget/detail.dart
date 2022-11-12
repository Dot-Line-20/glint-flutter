import 'package:flutter/material.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/pages/schedule/widget/add.dart';

class DetailSchedule extends StatelessWidget {
  final Schedule schedule;

  const DetailSchedule({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          schedule.name,
          style: AppTextTheme.T4,
        ),
        actions: [
          IconButton(
            onPressed: () => PickSchedule(parentId: schedule.id).show(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      Text("일정", style: AppTextTheme.T3),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.description),
                      Text(schedule.content, style: AppTextTheme.T3),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
