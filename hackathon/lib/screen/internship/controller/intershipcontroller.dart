import 'dart:convert';

import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/internshipmodel.dart';
import 'package:http/http.dart' as http;

class InternshipService {
  static Future<List<InternshipModel>> getInternships() async {
    try {
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
                  "Return ONLY a valid JSON array. No markdown. No explanation. No text before or after JSON."
            },
            {
              "role": "user",
              "content": """
Generate 10 software engineering internships in India.

Return this exact format:

[
  {
    "company": "Google",
    "role": "Software Engineering Intern",
    "location": "Bangalore",
    "duration": "6 Months",
    "stipend": "₹50000/month"
  }
]
"""
            }
          ],
          "temperature": 0.3,
          "max_tokens": 1000,
        }),
      );

      print("STATUS => ${response.statusCode}");
      print("BODY => ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
          "API Error ${response.statusCode}",
        );
      }

      final result = jsonDecode(response.body);

      String content =
          result["choices"][0]["message"]["content"];

      content = content
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      final match = RegExp(
        r'\[[\s\S]*\]',
      ).firstMatch(content);

      if (match == null) {
        throw Exception(
          "No JSON Array Found\n$content",
        );
      }

      final jsonString = match.group(0)!;

      print("JSON STRING =>");
      print(jsonString);

      final List<dynamic> data =
          jsonDecode(jsonString);

      return data
          .map(
            (e) => InternshipModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      print("ERROR => $e");
      rethrow;
    }
  }
}