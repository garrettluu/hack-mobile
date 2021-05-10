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
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('tasks')
          .where('user', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        List<Task> _tasks = getTasksFromSnapshot(snapshot);
        return ListView.builder(
          primary: false,
          itemCount: _tasks == null ? 1 : _tasks.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 24),
                  Text(
                    "Hello, world!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 24),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      authService.signOut();
                    },
                  ),
                  SizedBox(height: 24),
                ],
              );
            }
            index -= 1;
            if (_tasks[index] != null) {
              final currentWidget = TaskWidget(
                key: Key(_tasks[index].key),
                title: _tasks[index].title,
                description: _tasks[index].description,
                onDismissed: (direction) {
                  deleteTask(_tasks[index].key.toString());
                  _tasks.remove(_tasks[index]);
                },
                onLongPress: () async {
                  final newTask = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTask(
                          screenTitle: "Edit Task", task: _tasks[index]),
                    ),
                  );
                  updateTask(newTask);
                },
              );
              return currentWidget;
            }
            return null;
          },
        );
      },
    );
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
