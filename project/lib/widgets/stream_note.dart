import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/task_widgets.dart';
import '../data/firestore.dart';

class Stream_note extends StatelessWidget {
  final bool done;
  Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final noteslist = Firestore_Datasource().getNotes(snapshot);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: noteslist.length,
          itemBuilder: (context, index) {
            final note = noteslist[index];
            return Dismissible(
              key: UniqueKey(),
              // background: Container(
              //   color: Colors.red,
              //   alignment: Alignment.centerRight,
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Icon(Icons.delete, color: Colors.white),
              // ),
              confirmDismiss: (direction) async {
                if (!done) {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirm Delete'),
                      content: Text('Are you sure you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                }
                return true;
              },
              onDismissed: (direction) {
                Firestore_Datasource().deleteNote(note.id);
              },
              child: Task_Widget(note),
            );
          },
        );
      },
    );
  }
}
