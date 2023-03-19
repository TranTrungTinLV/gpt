import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt/providers/chats_provider.dart';

import 'package:gpt/widgets/chatitem.dart';
import 'package:gpt/widgets/text_and_voice_feild.dart';

class ChatGPT extends StatelessWidget {
  const ChatGPT({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('GPT DEMO')),
        ),
        body: Column(children: [
          Expanded(
            child: ProviderScope(
              child: Consumer(builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider).reversed.toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextAndVoiceFeild(),
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
