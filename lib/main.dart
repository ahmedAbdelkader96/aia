// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Conversational AI App',
//       home: VoiceControlScreen(),
//     );
//   }
// }
//
// class VoiceControlScreen extends StatefulWidget {
//   @override
//   _VoiceControlScreenState createState() => _VoiceControlScreenState();
// }
//
// class _VoiceControlScreenState extends State<VoiceControlScreen> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   void _listen() async {
//     if (!_isListening) {
//       await _speech.initialize();
//       _isListening = true;
//       _speech.listen(onResult: (result) {
//         setState(() {
//           _text = result.recognizedWords;
//         });
//       });
//     } else {
//       _speech.stop();
//       _isListening = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Voice Control')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Recognized Text: $_text'),
//             ElevatedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:aia/chat/controller/controller.dart';
import 'package:aia/chat/screens/Chat.dart';
import 'package:aia/global/bloc_providers/bloc_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await ChatController().initializeSpeechToText();
   runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return


      MultiBlocProvider(
        providers: BlocProviders.providers,
        child: MaterialApp(
          title: 'AIA App',
          home: ChatScreen(),
        ),
      );
  }
}






