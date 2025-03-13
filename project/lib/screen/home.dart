import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/const/colors.dart';
import 'package:project/screen/add_note_screen.dart';
import 'package:project/widgets/stream_note.dart';
import 'package:project/screen/login.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:project/data/firestore.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _spokenText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColors,
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: show,
          child: FloatingActionButton(
            onPressed: () {
              _showNoteOptions(context);
            },
            backgroundColor: custom_green,
            child: Icon(Icons.add, size: 30),
          ),
        ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: Colors.grey.shade200,
                width: double.infinity,
                child: Text(
                  'Tasks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Stream_note(false),
              SizedBox(height: 12),
              Divider(thickness: 1.5, color: Colors.grey.shade400),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: Colors.grey.shade200,
                width: double.infinity,
                child: Text(
                  'Completed Tasks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Stream_note(true),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoteOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.text_fields),
                title: Text("Nhập văn bản"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_Screen(),
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.mic),
                title: Text("Nhập bằng giọng nói"),
                onTap: () {
                  Navigator.of(context).pop();
                  _startListening();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _spokenText = result.recognizedWords;
          });

          if (_spokenText.isNotEmpty) {
            _saveVoiceNote();
          }
        },
      );
    }
  }

  void _saveVoiceNote() async {
    int taskCount = await _getTaskCount();
    String title = "Task $taskCount";

    Firestore_Datasource().addNote(
      _spokenText,
      title,
      1, // Mặc định dùng ảnh đầu tiên
    );

    setState(() {
      _isListening = false;
      _spokenText = "";
    });
  }

  Future<int> _getTaskCount() async {
    var snapshot = await Firestore_Datasource()
        .stream(false)
        .first; // Lấy danh sách task chưa hoàn thành

    return snapshot.docs.length + 1;
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LogIN_Screen(() {})),
      (route) => false,
    );
  }
}
