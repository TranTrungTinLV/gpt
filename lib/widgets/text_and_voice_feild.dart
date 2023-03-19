import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt/models/chat_model.dart';
import 'package:gpt/providers/chats_provider.dart';
import 'package:gpt/services/api_handle.dart';
import 'package:gpt/services/voice_handle.dart';
import '../widgets/toggle_button.dart';

enum InputMode { text, voice }

class TextAndVoiceFeild extends ConsumerStatefulWidget {
  @override
  ConsumerState<TextAndVoiceFeild> createState() => _TextAndVoiceFeildState();
}

class _TextAndVoiceFeildState extends ConsumerState<TextAndVoiceFeild> {
  InputMode _inputMode = InputMode.voice;
  TextEditingController _messageController = TextEditingController();
  final AIHandler _openAI = AIHandler();
  final VoiceHandler voiceHandler = VoiceHandler();
  var _isReplying = false;

  @override
  void initState() {
    voiceHandler.initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _openAI.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: _messageController,
          onChanged: (value) {
            value.isNotEmpty
                ? setInputMode(InputMode.text)
                : setInputMode(InputMode.voice);
          },
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
        )),
        ToggleButton(
          isReplying: _isReplying,
          inputMode: _inputMode,
          sendTextMessage: () {
            final message = _messageController.text;
            _messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        ),
      ],
    );
  }

  void setInputMode(InputMode inputmode) {
    setState(() {
      _inputMode = inputmode;
    });
  }

  void sendVoiceMessage() async {
    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
    } else {
      final result = await voiceHandler.startListening();
      sendTextMessage(result);
    }
  }

  void sendTextMessage(String message) async {
    setState(() {
      _isReplying = true;
    });
    addToList(message, true, DateTime.now().toString());
    addToList('Typing...', false, 'typing');
    InputMode.voice;

    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addToList(aiResponse, false, DateTime.now().toString());
    setState(() {
      _isReplying = false;
    });
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void addToList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
    ));
  }
}
