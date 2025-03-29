import 'package:aia/chat/bloc/speech_bloc/speech_bloc.dart';
import 'package:flutter/material.dart';

class AnimatedRecordButton extends StatefulWidget {
  const AnimatedRecordButton({
    super.key,
    required this.onPressed,
    required this.speechState,
  });

  final Function() onPressed;
  final SpeechState speechState;

  @override
  State<AnimatedRecordButton> createState() => _AnimatedRecordButtonState();
}

class _AnimatedRecordButtonState extends State<AnimatedRecordButton>
    with SingleTickerProviderStateMixin {
  void _toggleIcon() {
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      child: GestureDetector(
        onTap: _toggleIcon,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1.0).animate(animation),
              child: child,
            );
          },
          child: Container(
            key: ValueKey<bool>(widget.speechState is SpeechListening),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Icon(
              widget.speechState is SpeechListening
                  ? Icons.square
                  : Icons.keyboard_voice_outlined,
              size: 33.0,
              color:
                  widget.speechState is SpeechListening
                      ? Colors.red
                      : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
