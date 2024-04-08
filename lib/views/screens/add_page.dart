import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toder/controllers/controller_one.dart';
import 'package:toder/models/user_model.dart';
import 'package:toder/services/helpers/data_helper.dart';
import 'package:toder/services/helpers/notifications_helper.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel acc = ModalRoute.of(context)!.settings.arguments as UserModel;

    DateTime? time;

    return Consumer<ControllerOne>(builder: (context, p, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Your Todo"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CupertinoTextField(
                  controller: p.titleController,
                  placeholder: "title",
                  autocorrect: true,
                  enabled: true,
                  autofocus: true,
                  suffix: const Icon(Icons.title_outlined),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 22),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemGroupedBackground,
                      borderRadius: BorderRadius.circular(15)),
                ),
                const SizedBox(height: 30),
                CupertinoTextField(
                  controller: p.desController,
                  maxLines: 1,
                  placeholder: "description",
                  autocorrect: true,
                  enabled: true,
                  suffix: const Icon(Icons.description_outlined),
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 22),
                  decoration: BoxDecoration(
                      color: CupertinoColors.systemGroupedBackground,
                      borderRadius: BorderRadius.circular(15)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          TimeOfDay? t = await showTimePicker(
                              context: context, initialTime: p.timeMy);
                          DateTime d = DateTime(0, 0, 0, t!.hour, t.minute);
                          p.changeTime(time: d.toLocal());

                          time = d;
                          p.time = t.format(context).toString();

                          log(p.time!);
                        },
                        icon: const Icon(
                          Icons.watch_later_outlined,
                          color: CupertinoColors.activeBlue,
                        )),
                    IconButton(
                        onPressed: () async {
                          DateTime? d = await showDatePicker(
                              context: context,
                              initialDate: p.mydate,
                              firstDate: DateTime(1947),
                              lastDate: DateTime.now().add(
                                const Duration(days: 1),
                              ),
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              initialDatePickerMode: DatePickerMode.day,
                              onDatePickerModeChange: (date) =>
                                  p.changeDate(date: p.mydate));

                          String formatDate =
                              DateFormat('yyyy-MM-dd').format(d!);

                          p.date = formatDate;

                          log(p.date!);
                        },
                        icon: const Icon(
                          Icons.calendar_today,
                          color: CupertinoColors.activeBlue,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        child: const Text("Add"),
                        onPressed: () {
                          DataHelper.dataHelper.addTodo(
                            email: acc.email,
                            title: p.titleController.text,
                            des: p.desController.text,
                            time: p.time!,
                            date: p.date!,
                          );
                          NotificationsHelper.notificationsHelper.scheduleNotification(scheduledDate: time!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Todo Add SuccessFully")),
                          );
                          p.titleController.clear();
                          p.desController.clear();
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
