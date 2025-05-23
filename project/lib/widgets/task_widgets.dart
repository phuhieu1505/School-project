import 'package:flutter/material.dart';
import 'package:project/const/colors.dart';
import 'package:project/data/firestore.dart';
import 'package:project/model/notes_model.dart';
import 'package:project/screen/edit_screen.dart';

import '../screen/notification_time_screen.dart';
import '../screen/task_detail_screen.dart';

class Task_Widget extends StatefulWidget {
  Note _note;

  Task_Widget(this._note, {super.key});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDone;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TaskDetailScreen(note: widget._note),
          ));
        },
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                taskImages(),
                SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget._note.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Checkbox(
                            activeColor: custom_green,
                            value: isDone,
                            onChanged: (value) {
                              setState(() {
                                isDone = !isDone;
                              });
                              Firestore_Datasource()
                                  .isDone(widget._note.id, isDone);
                            },
                          )
                        ],
                      ),
                      Text(
                        widget._note.subtitle,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400),
                      ),
                      Spacer(),
                      edit_time()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget edit_time() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Nút hiển thị thời gian, nhấn vào để điều hướng đến màn hình cài đặt thông báo
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationTimeScreen(note: widget._note), // Điều hướng tới screen mới
              ));
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: custom_green,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    Image.asset('images/icon_time.png'),
                    SizedBox(width: 10),
                    Text(
                      widget._note.time,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Edit_Screen(widget._note),
              ));
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xffE2F6F1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    Image.asset('images/icon_edit.png'),
                    SizedBox(width: 10),
                    Text(
                      'edit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget taskImages() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/${widget._note.image}.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
