import 'package:flutter/material.dart';

class Task {
  Task({this.key, this.title, this.description});
  final Key key;
  String title;
  String description;
}

class TaskWidget extends StatelessWidget {
  const TaskWidget(
      {Key key,
      this.title,
      this.description,
      this.onDismissed,
      this.onLongPress})
      : super(key: key);
  final String title;
  final String description;
  final onDismissed;
  final onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 37, right: 37, bottom: 22),
      child: Dismissible(
        key: key,
        onDismissed: onDismissed,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(description, textAlign: TextAlign.left),
                    ],
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
