import 'dart:convert';
import 'dart:developer';
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/model/degreeModel.dart';
import 'package:http/http.dart' as http;

 Future<DegreeResponseModel?> getDegreesAI(
  String stream,
) async {
  String prompt = """
Return the most popular degrees for the stream: $stream

Return ONLY valid JSON.

{
  "degrees":[
    {
      "title":"",
      "duration":"",
      "salary":""
    }
  ]
}

Rules:
- Return 8 degrees
- duration example: 4 Years
- salary example: ₹ 5 - 12 LPA
- JSON only
- No markdown
""";
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
            "content": "You are a strict JSON API. Return JSON only.",
          },
          {"role": "user", "content": prompt},
        ],
        "temperature": 0.2,
      }),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      var data = result["choices"][0]["message"]["content"];

      data = data.replaceAll("```json", "").replaceAll("```", "").trim();

      return DegreeResponseModel?.fromJson(jsonDecode(data));
    }
  } catch (e) {
    log("Stream AI Error: $e");
  }

  return null;
}
