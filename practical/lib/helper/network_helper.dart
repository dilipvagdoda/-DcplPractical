import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practical/model/user_details_model.dart';
import 'package:practical/model/user_model.dart';

class NetworkHelper {
  static const String baseUrl = 'https://api.github.com';

  Future<List<User>> fetchUsers({int since = 0}) async {
    final response = await http.get(Uri.parse('$baseUrl/users?since=$since'));
    if (response.statusCode == 200) {
      print("page====================${since}");
      final List<dynamic> usersJson = json.decode(response.body);
      return usersJson.map((userJson) => User(
        id: userJson['id'],
        username: userJson['login'],
        avatarUrl: userJson['avatar_url'],
      )).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  Future<UserDetails> fetchUserProfile(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));
    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return UserDetails(
        id: userJson['id'],
        username: userJson['login'],
        avatarUrl: userJson['avatar_url'],
        company: userJson['company'],
        blog: userJson['blog'],
        followers: userJson['followers'],
        following: userJson['following'],
      );
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }

}