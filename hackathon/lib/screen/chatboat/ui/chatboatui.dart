import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:hackathon/model/chatboatmodel.dart';
import 'package:hackathon/screen/chatboat/controller/chatcontroller.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final Color bgColor = const Color(0xFF0B1325);
  final Color surfaceColor = const Color(0xFF151F32);
  final Gradient primaryGradient = const LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFF00E676)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChatProvider>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color.fromARGB(255, 14, 24, 47),
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(radius: 16, child: Text("CC")),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Career Coach",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.greenAccent[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    if (chatProvider.messages.isEmpty) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 30,
                          right: 30,
                          bottom: MediaQuery.of(context).viewInsets.bottom > 0
                              ? 20
                              : 0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF151F32),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF00E5FF,
                                    ).withOpacity(.2),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.assistant_navigation,
                                  size: 50,
                                  color: Color(0xFF00E5FF),
                                ),
                              ),

                              const SizedBox(height: 24),

                              const Text(
                                "Career Compass AI",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "Your personal career advisor.\nAsk anything about careers, skills, degrees, jobs, placements, and future opportunities.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 32),

                              _suggestionChip(
                                "Which degree is best after Science?",
                              ),
                              const SizedBox(height: 10),

                              _suggestionChip(
                                "How do I become a Software Engineer?",
                              ),
                              const SizedBox(height: 10),

                              _suggestionChip(
                                "Top careers in Artificial Intelligence",
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: chatProvider.scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        return _buildChatBubble(chatProvider.messages[index]);
                      },
                    );
                  },
                ),
              ),

              // Loading Indicator
              Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  return chatProvider.isLoading
                      ? const LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: Color(0xFF00E5FF),
                          minHeight: 2,
                        )
                      : const SizedBox(height: 2);
                },
              ),

              _buildInputArea(context, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessageModel message) {
    bool isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        constraints: const BoxConstraints(
          maxWidth: 350,
        ), // Increased slightly for code blocks
        decoration: BoxDecoration(
          color: isUser ? null : surfaceColor,
          gradient: isUser ? primaryGradient : null,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 20),
          ),
          boxShadow: isUser
              ? [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        // --- NEW GPT MARKDOWN WIDGET ---
        child: GptMarkdown(
          message.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, ChatProvider provider) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: chatProvider.isLoading
                          ? Colors.white.withOpacity(0.04)
                          : Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: TextField(
                    controller: chatProvider.textController,
                    enabled: !chatProvider.isLoading, // 🔒 disables typing
                    style: TextStyle(
                      color: chatProvider.isLoading
                          ? Colors.white38
                          : Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: chatProvider.isLoading
                          ? "Waiting for response..."
                          : "Type a message...",
                      hintStyle: TextStyle(
                        color: chatProvider.isLoading
                            ? Colors.grey[700]
                            : Colors.grey[500],
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    onSubmitted: chatProvider.isLoading
                        ? null // 🔒 blocks Enter key too
                        : (_) => chatProvider.sendMessage(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: chatProvider.isLoading
                    ? null
                    : chatProvider.sendMessage, // 🔒 blocks tap
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: chatProvider.isLoading
                        ? const LinearGradient(
                            colors: [Color(0xFF2A3A4A), Color(0xFF2A3A4A)],
                          )
                        : primaryGradient,
                    boxShadow: chatProvider.isLoading
                        ? []
                        : [
                            BoxShadow(
                              color: const Color(0xFF00E5FF).withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _suggestionChip(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
