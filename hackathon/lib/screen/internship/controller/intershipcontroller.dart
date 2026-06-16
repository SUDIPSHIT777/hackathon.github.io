import 'dart:convert';

import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/internshipmodel.dart';
import 'package:http/http.dart' as http;

class InternshipService {
  static Future<List<InternshipModel>> getInternships({String? role}) async {
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
                  "Return ONLY a valid JSON array. No markdown. No explanation.",
            },
            {
              "role": "user",
              "content": role == null || role.trim().isEmpty
                  ? """
Generate 10 software engineering internships in India.

IMPORTANT:
- Use real companies.
- Provide the official internship/careers application URL.
- applyUrl must be a valid URL.

Return ONLY:

[
  {
    "company": "Google",
    "role": "Software Engineering Intern",
    "location": "Bangalore",
    "duration": "6 Months",
    "stipend": "₹50000/month",
    "applyUrl": "https://careers.google.com"
  }
]
"""
                  : """
Generate 10 internships in India for the role: $role.

IMPORTANT:
- Use real companies.
- Provide the official internship/careers application URL.
- applyUrl must be a valid URL.

Return ONLY:

[
  {
    "company": "Google",
    "role": "$role",
    "location": "Bangalore",
    "duration": "6 Months",
    "stipend": "₹50000/month",
    "applyUrl": "https://careers.google.com"
  }
]
""",
            },
          ],
          "temperature": 0.3,
          "max_tokens": 1000,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception("API Error ${response.statusCode}");
      }

      final result = jsonDecode(response.body);

      String content = result["choices"][0]["message"]["content"];

      content = content.replaceAll("```json", "").replaceAll("```", "").trim();

      final match = RegExp(r'\[[\s\S]*\]').firstMatch(content);

      if (match == null) {
        throw Exception("No JSON Array Found");
      }

      final List<dynamic> data = jsonDecode(match.group(0)!);

      return data
          .map((e) => InternshipModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
