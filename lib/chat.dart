import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:knee_app/bottomNavbar.dart';
import 'package:knee_app/rating_bar.dart';
import 'package:knee_app/splash_screen.dart';
import 'package:knee_app/x_rays_page.dart';
import 'Messages.dart';
import 'navbar.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.removeObserver(this);
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BottomNavBar.navKey.currentState?.toggleBottomNavBar(true);
    } else if (state == AppLifecycleState.paused) {
      BottomNavBar.navKey.currentState?.toggleBottomNavBar(false);
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    BottomNavBar.navKey.currentState?.toggleBottomNavBar(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI Assistant",
          style: TextStyle(color: Color(0xFFF0F8FF)),
        ),
        backgroundColor: const Color(0xFF06607B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>BottomNavBar()),
            );
          },
        ),
      ),
      body: Container(
          color: const Color(0xFFF0F8FF),
          child: Column(
            children: [
              Expanded(child: MessagesScreen(messages: messages)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                color: const Color(0xFF06607B),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: const Icon(Icons.send),
                      color: const Color(0xFFF0F8FF),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print("Message Is Empty");
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }
}
