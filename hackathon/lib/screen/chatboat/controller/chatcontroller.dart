import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hi, Sarah! 👋\nI'm your Career Compass Assistant. Ready to navigate your career path?",
      isUser: false,
    ),
  ];

  List<ChatMessage> get messages => _messages;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage() async {
    if (textController.text.trim().isEmpty) return;

    String userText = textController.text.trim();

    // 1. Add User Message
    _messages.add(ChatMessage(text: userText, isUser: true));
    textController.clear();
    _scrollToBottom();
    notifyListeners();

    // 2. Fetch Bot Response
    await _fetchOpenRouterResponse(userText);
  }

  Future<void> _fetchOpenRouterResponse(String prompt) async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiKey = dotenv.env['apikey'];
      final apiUrl = dotenv.env['api'];

      if (apiKey == null || apiUrl == null) {
        throw Exception("API Key or URL is missing in .env");
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
          'HTTP-Referer': 'https://your-app-url.com',
          'X-Title': 'Career Compass App',
        },
        body: jsonEncode({
          'model': 'meta-llama/llama-3-8b-instruct:free',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a helpful Career Compass Assistant.',
            },
            {'role': 'user', 'content': prompt},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply = data['choices'][0]['message']['content'];
        _messages.add(ChatMessage(text: botReply, isUser: false));
      } else {
        _messages.add(
          ChatMessage(
            text: "Error: ${response.statusCode} - ${response.body}",
            isUser: false,
          ),
        );
      }
    } catch (e) {
      _messages.add(
        ChatMessage(text: "Something went wrong: $e", isUser: false),
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
