import 'package:flutter/material.dart';
import 'package:hackmobile/widgets/Task.dart';

class EditTask extends StatefulWidget {
  EditTask({Key key, this.screenTitle, this.task}) : super(key: key);
  final String screenTitle;
  final Task task;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final controllerName = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerName.text = widget.task?.title ?? "";
    controllerDescription.text = widget.task?.description ?? "";
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.screenTitle)),
        body: Padding(
          padding: const EdgeInsets.only(top: 24, left: 48, right: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.check),
                  Text("Task name"),
                ],
              ),
              TextField(
                controller: controllerName,
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Icon(Icons.subject),
                  Text("Description"),
                ],
              ),
              TextField(
                controller: controllerDescription,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.task != null) {
              widget.task.title = controllerName.text;
              widget.task.description = controllerDescription.text;
            }
            Navigator.pop(
              context,
              widget.task ??
                  Task(
                    key: UniqueKey(),
                    title: controllerName.text,
                    description: controllerDescription.text,
                  ),
            );
          },
          child: Icon(Icons.send),
        ),
      ),
    );
  }
}
