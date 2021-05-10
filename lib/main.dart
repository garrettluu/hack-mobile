import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackmobile/EditTask.dart';
import 'package:hackmobile/SignIn.dart';
import 'package:hackmobile/database/FirebaseAdapter.dart';
import 'package:hackmobile/services/AuthService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final FirebaseAdapter firebase =
      new FirebaseAdapter(FirebaseFirestore.instance);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialize firebase asynchronously
  final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    // Wait until firebase finishes initializing to start the app
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            home: StreamBuilder<User>(
              stream: authService.authStateChanges(),
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return MyHomePage(
                        title: 'Hack Mobile', user: snapshot.data);
                  } else {
                    return SignIn();
                  }
                }

                return Text("Loading");
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamBuilder<QuerySnapshot> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = MyApp.firebase.getTasksFromUser(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _tasks,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTask(screenTitle: "New Task"),
            ),
          );
          if (newTask != null) {
            MyApp.firebase.createTask(newTask, widget.user);
          }
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
