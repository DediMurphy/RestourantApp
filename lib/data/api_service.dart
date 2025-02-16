import 'dart:convert';
import 'dart:math';

import 'package:restourantapp/model/tourism_detail_response.dart';
import 'package:restourantapp/model/tourism_list_response.dart';
import 'package:http/http.dart' as http;

// langkah 4
class ApiServices {
  static const String _baseUrl = "https://tourism-api.dicoding.dev";

  // get data list
  Future<TourismListResponse> getTourismList() async {
      
      final response = await http.get(Uri.parse("$_baseUrl/list"));

      if (response.statusCode == 200) {
        return TourismListResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load tourism list');
      }
  }

  Future<TourismDetailResponse> getTourismDetail(int id) async {
   final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
 
 
   if (response.statusCode == 200) {
     return TourismDetailResponse.fromJson(jsonDecode(response.body));
   } else {
     throw Exception('Failed to load tourism detail');
   }
 }
}