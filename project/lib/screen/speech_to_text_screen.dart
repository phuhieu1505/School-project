// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// class SpeechToTextScreen extends StatefulWidget {
//   @override
//   _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
// }
//
// class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = "Nhấn vào micro để bắt đầu nói";
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   void _startListening() async {
//     bool available = await _speech.initialize();
//     if (available) {
//       setState(() => _isListening = true);
//       _speech.listen(onResult: (result) {
//         setState(() {
//           _text = result.recognizedWords;
//         });
//       });
//     }
//   }
//
//   void _stopListening() {
//     setState(() => _isListening = false);
//     _speech.stop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Nhận diện giọng nói")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Center(
//                 child: Text(
//                   _text,
//                   style: TextStyle(fontSize: 18),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             FloatingActionButton(
//               onPressed: _isListening ? _stopListening : _startListening,
//               backgroundColor: _isListening ? Colors.red : Colors.green,
//               child: Icon(_isListening ? Icons.stop : Icons.mic, size: 30),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }