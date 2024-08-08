import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final ticketListProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await http.get(Uri.parse('http://192.168.78.102:3001/flights'));

    final List<dynamic> data = jsonDecode(response.body);
    print(data);
    return data;
});