import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toder/controllers/controller_one.dart';
import 'package:toder/models/data_model.dart';
import 'package:toder/models/user_model.dart';
import 'package:toder/services/helpers/data_helper.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)!.settings.arguments as List;
    int index = args[0];
    UserModel userModel = args[1];
    String?title;
    String?des;
    String? date;
    String? time;

    return Consumer<ControllerOne>(builder: (context, p, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
          title: const Text("Update Todo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder(
              stream: DataHelper.dataHelper.readTodo(email: userModel.email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      TextFormField(
                        onChanged: (v){
                         title = v;
                        },
                        initialValue: snapshot.data!.docs[index]['title'],
                        decoration: const InputDecoration(
                          hintText: "title",
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        onChanged: (v){
                         des = v;
                        },
                        initialValue: snapshot.data!.docs[index]['des'],
                        decoration: const InputDecoration(
                          hintText: "description",
                        ),
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
                                DateTime d =
                                    DateTime(0, 0, 0, t!.hour, t.minute);
                                p.changeTime(time: d.toLocal());

                                time = t.format(context).toString();

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

                               date = formatDate;

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
                      CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          child: const Text("Update"),
                          onPressed: () {
                            DataHelper.dataHelper.updateTodo(
                                email: userModel.email,
                                id: snapshot.data!.docs[index]['id'],
                                title: title?? snapshot.data!.docs[index]['title'],
                                des: des?? snapshot.data!.docs[index]['des'],
                                time: time?? snapshot.data!.docs[index]['time'],
                                date:date?? snapshot.data!.docs[index]['date']);
                            Navigator.of(context).pop();
                          }),
                    ],
                  );
                }
                return const Text("");
              }),
        ),
      );
    });
  }
}
