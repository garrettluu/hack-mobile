import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({Key key, this.title, this.description}) : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 37.0, right: 37, bottom: 22),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.check),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    description,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.19),
              offset: Offset(0, 3),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
