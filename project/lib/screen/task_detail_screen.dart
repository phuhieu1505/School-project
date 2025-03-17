import 'package:flutter/material.dart';
import 'package:project/model/notes_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final Note note;

  TaskDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              note.subtitle,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey),
                SizedBox(width: 10),
                Text(
                  'Created at: ${note.time}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  note.isDone ? Icons.check_circle : Icons.circle_outlined,
                  color: note.isDone ? Colors.green : Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  note.isDone ? 'Completed' : 'Pending',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}