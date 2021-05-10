import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackmobile/EditTask.dart';
import 'package:hackmobile/services/AuthService.dart';
import 'package:hackmobile/widgets/Task.dart';

class FirebaseAdapter {
  FirebaseFirestore firestore;
  FirebaseAdapter(this.firestore);

  getTasksFromUser(User user) {
    return firestore
        .collection('tasks')
        .where('user', isEqualTo: user.uid)
        .snapshots();
  }

  getTasksFromSnapshot(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Task> list = snapshot.data?.docs?.map((DocumentSnapshot doc) {
      final Map<String, dynamic> data = doc.data();
      return new Task(
        key: data['key'],
        title: data['title'],
        description: data['description'],
      );
    })?.toList();

    return list;
  }

  deleteTask(String id) {
    firestore.collection('tasks').doc(id).delete();
  }

  createTask(Task task, User user) {
    firestore.collection('tasks').doc(task.key).set(<String, dynamic>{
      'user': user.uid,
      'key': task.key,
      'title': task.title,
      'description': task.description,
    });
  }

  updateTask(Task task) {
    firestore.collection('tasks').doc(task.key).update(<String, dynamic>{
      'title': task.title,
      'description': task.description
    });
  }
}

final FirebaseAdapter firebase =
    new FirebaseAdapter(FirebaseFirestore.instance);
