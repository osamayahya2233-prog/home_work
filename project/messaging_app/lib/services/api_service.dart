import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/api_user.dart';

class ApiService {
  Future<List<ApiUser>> fetchUsers() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('API Error: ${res.statusCode}');
    }

    final list = jsonDecode(res.body) as List;
    return list.map((e) => ApiUser.fromJson(e)).toList();
  }
}
