import 'dart:convert';
import 'package:http/http.dart' as http;


class Web3FormsService {
// Replace this with your Web3Forms access key when ready.
// To get a key, sign up at https://web3forms.com
  final String accessKey = '5e44e805-82c4-4699-8db0-9290972057f9';


  Future<http.Response> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    final uri = Uri.parse('https://api.web3forms.com/submit');
    final payload = {
      'access_key': accessKey,
      'name': name,
      'email': email,
      'message': message,
    };
    final res = await http.post(uri,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(payload));
    return res;
  }
}