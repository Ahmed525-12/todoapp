import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/model/task.dart';

CollectionReference<Task> getTaskCollection() {
  var typedcollection = FirebaseFirestore.instance
      .collection("Tasks")
      .withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson());
  return typedcollection;
}

Future<void> addTasks(Task task) {
  var collection = getTaskCollection();
  var docfor = collection.doc();
  task.id = docfor.id;
  return docfor.set(task);
}

void addTasksid(Task task) {
getTaskCollection().doc(task.id).update(task.toJson());
}

void deletTask(Task task) {
  getTaskCollection().doc(task.id).delete();
}

Future<QuerySnapshot<Task>> getTasks(DateTime dateTime) {
  return getTaskCollection()
      .where("date",
          isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
      .get();
}

Stream<QuerySnapshot<Task>> listenTasks(DateTime dateTime) {
  return getTaskCollection()
      .where("date",
          isEqualTo: DateUtils.dateOnly(dateTime).microsecondsSinceEpoch)
      .snapshots();
}
