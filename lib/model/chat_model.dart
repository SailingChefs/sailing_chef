import 'package:flutter/material.dart';

class ChatMessageModel {
  final String text;
  final ImageProvider? image;
  final bool isMe;

  ChatMessageModel({required this.text, this.image, required this.isMe});
}
