import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/chatboatmodel.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];
  List<ChatMessageModel> get messages => _messages;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Automatically start the chat with a greeting
  ChatProvider() {
    _addInitialMessage();
  }

  void _addInitialMessage() {
    _messages.add(
      ChatMessageModel(
        text:
            "Hi there! 👋 I'm your Career Compass Assistant.\n\n"
            "Whether you're looking to switch careers, prepare for an interview, "
            "or figure out your next learning steps, I'm here to help.\n\n"
            "What career path are you interested in exploring today?",
        isUser: false,
      ),
    );
  }

  Future<void> sendMessage() async {
    if (textController.text.trim().isEmpty) return;

    String userText = textController.text.trim();

    // 1. Add user message to UI
    _messages.add(ChatMessageModel(text: userText, isUser: true));
    textController.clear();
    _scrollToBottom();
    notifyListeners();

    // 2. Fetch bot response
    await _fetchAIResponse(userText);
  }

  Future<void> _fetchAIResponse(String prompt) async {
    _isLoading = true;
    notifyListeners();

    try {
      // General Career Coach Context
      String systemContext =
          "You are a helpful, empathetic, and expert Career Coach. "
          "Your goal is to guide the user through their career journey, offer actionable advice, "
          "interview tips, resume building strategies, and learning roadmaps. "
          "Keep replies conversational, encouraging, and clear. Use markdown for readability, "
          "but avoid overwhelming the user with massive walls of text.";

      List<Map<String, String>> messageHistory = [
        {'role': 'system', 'content': systemContext},
      ];

      // Limit history to the last 8 messages to save tokens and prevent crashes
      final recentMessages = _messages.length > 8
          ? _messages.sublist(_messages.length - 8, _messages.length - 1)
          : _messages.sublist(0, _messages.length - 1);

      for (var msg in recentMessages) {
        messageHistory.add({
          'role': msg.isUser ? 'user' : 'assistant',
          'content': msg.text,
        });
      }

      messageHistory.add({'role': 'user', 'content': prompt});

      final response = await http.post(
        Uri.parse(AppConfig.api),
        headers: {
          'Authorization': 'Bearer ${AppConfig.apikey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-chat",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a strict JSON API. Never return text outside JSON.",
            },
            {"role": "user", "content": prompt},
          ],
          "max_tokens": 500,
          "temperature": 0.3,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['choices'][0]['message']['content'];
        _messages.add(ChatMessageModel(text: botReply, isUser: false));
      } else {
        // Detailed Error Handling
        String errorDetail = "API Error ${response.statusCode}";
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['error'] != null &&
              errorData['error']['message'] != null) {
            errorDetail += ": ${errorData['error']['message']}";
          } else {
            errorDetail += "\nBody: ${response.body}";
          }
        } catch (_) {
          errorDetail += "\nBody: ${response.body}";
        }

        _messages.add(ChatMessageModel(text: errorDetail, isUser: false));
      }
    } catch (e) {
      _messages.add(
        ChatMessageModel(text: "System Error Caught:\n$e", isUser: false),
      );
    } finally {
      _isLoading = false;
      _scrollToBottom();
      notifyListeners();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
