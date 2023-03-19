import 'package:flutter/material.dart';
import 'package:gpt/widgets/text_and_voice_feild.dart';

class ToggleButton extends StatefulWidget {
  final InputMode _inputMode;
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final bool _isReplying;
  const ToggleButton(
      {super.key,
      required InputMode inputMode,
      required sendTextMessage,
      required sendVoiceMessage,
      required isReplying})
      : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: CircleBorder(),
          padding: EdgeInsets.all(15)),
      onPressed: widget._isReplying
          ? null
          : widget._inputMode == InputMode.text
              ? widget._sendTextMessage
              : widget._sendVoiceMessage,
      child: Icon(widget._inputMode == InputMode.text ? Icons.send : Icons.mic),
    );
  }
}
