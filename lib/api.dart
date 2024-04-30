import 'dart:convert';

import 'package:http/http.dart' as http;

class APIRepository {
  Future<String> getPythonOutput(String code) async {
    try {
      final response = await http.post(
        Uri.http('localhost:3000', 'run-python'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'code': code}),
      );
      final decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      final output = decodedResponse['output'] as String;
      return output;
    } catch (e) {
      return 'Error calling API';
    }
  }

  APIRepository._privateConstructor();

  static final APIRepository _instance = APIRepository._privateConstructor();

  factory APIRepository() {
    return _instance;
  }
}

final apiRepository = APIRepository();
