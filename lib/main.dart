import 'package:flutter/material.dart';
import 'package:hackmobile/EditTask.dart';
import 'package:hackmobile/widgets/Task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Hack Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskWidget> _tasks = [];
  // List<TaskWidget> _taskWidgets = [];

  void _addTask(Task newTask) {
    setState(() {
      _tasks.add(TaskWidget(
        key: newTask.key,
        title: newTask.title,
        description: newTask.description,
        onDismissed: (direction) {
          setState(() {
            _tasks.removeWhere((element) => (element.key == newTask.key));
          });
        },
        onLongPress: () async {
          final changedTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTask(
                screenTitle: "Edit Task",
                key: newTask.key,
                title: newTask.title,
                description: newTask.description,
              ),
            ),
          );
          setState(() {
            // Remove the old task
            _tasks.removeWhere((element) => (element.key == changedTask.key));
            // Create a new one
            _addTask(changedTask);
          });
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          primary: false,
          children: <Widget>[
            SizedBox(height: 24),
            Text(
              "Hello, world!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 24),
            ..._tasks
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTask(screenTitle: "New Task"),
            ),
          );
          _addTask(newTask);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
