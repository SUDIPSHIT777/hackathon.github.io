import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/chatboatmodel.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];
  List<ChatMessageModel> get messages => _messages;

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage() async {
    if (textController.text.trim().isEmpty) return;

    final userMessage = textController.text.trim();

    _messages.add(ChatMessageModel(text: userMessage, isUser: true));

    textController.clear();
    notifyListeners();

    await _getAIReply(userMessage);
  }

  Future<void> _getAIReply(String message) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(AppConfig.api),
        headers: {
          "Authorization": "Bearer ${AppConfig.apikey}",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "deepseek/deepseek-chat",
          "messages": [
            {
              "role": "system",
              "content": """
You are Career Compass AI, an expert Career Advisor.

Your responsibilities:
- Help students choose careers, streams, degrees, and skills.
- Suggest learning paths and career roadmaps.
- Recommend courses, certifications, and technologies.
- Explain career opportunities, salaries, and future scope.
- Provide clear, encouraging, and practical advice.
- Answer in simple language suitable for students.

Rules:
- Be concise but informative.
- Use bullet points when helpful.
- If asked unrelated questions, politely redirect toward education, careers, skills, jobs, and professional growth.
- Never mention you are an AI model.
""",
            },
            {"role": "user", "content": message},
          ],
          "temperature": 0.7,
          "max_tokens": 700,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final aiReply =
            data["choices"][0]["message"]["content"] ?? "No response";

        _messages.add(ChatMessageModel(text: aiReply, isUser: false));
      } else {
        _messages.add(
          ChatMessageModel(
            text: "Error: ${response.statusCode}",
            isUser: false,
          ),
        );
      }
    } catch (e) {
      _messages.add(ChatMessageModel(text: "Error: $e", isUser: false));
    }

    _isLoading = false;
    notifyListeners();

    _scrollToBottom();
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
