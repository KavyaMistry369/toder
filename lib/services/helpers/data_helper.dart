import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toder/models/data_model.dart';

class DataHelper {
  DataHelper._();

  static final DataHelper dataHelper = DataHelper._();

  FirebaseFirestore fire = FirebaseFirestore.instance;

  Future<void> addTodo({
    required String title,
    required String des,
    required String time,
    required String date,
    required String email,
  }) async {
    final docRef =
    fire.collection('users').doc(email).collection('todos').doc();

    DataModel dataModel = DataModel(title,des,date,time,docRef.id);

    await docRef.set(dataModel.toJson()).then((value) {
      return print("Successfully Add");
    }, onError: (e) => print("Error $e"));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readTodo(
      {required String email}) {
    return fire.collection('users').doc(email).collection('todos').snapshots();
  }

  Future<void> updateTodo({
    required String email,
    required String id,
    required String title,
    required String des,
    required String time,
    required String date,
  }) {
    DataModel dataModel = DataModel(title,des,date,time,id);
    log(id);
    return fire
        .collection('users')
        .doc(email)
        .collection('todos')
        .doc(id)
        .update(dataModel.toJson());
  }

  Future<void> deleteTodo({required String email, required String id}) {
    log(id);
    return fire
        .collection('users')
        .doc(email)
        .collection('todos')
        .doc(id)
        .delete();
  }
}
