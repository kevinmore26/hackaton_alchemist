import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackaton_rimac/models/score.dart';
import 'package:http/http.dart' as http; 

class ScoresProvider extends GetConnect {
  String url = 'http://127.0.0.1:5000/api/scores/1';

  Future<List<Score>> fetchScores() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Score> scores = Score.fromJsonList(data);
        return scores;
      } else {
        Get.snackbar('Request Denied', 'Failed to load scores',
            backgroundColor: Colors.red, colorText: Colors.white);
        return [];
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while fetching scores',
          backgroundColor: Colors.red, colorText: Colors.white);
      return [];
    }
  }
}
