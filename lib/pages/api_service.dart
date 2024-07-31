import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('https://api.npoint.io/b181a1cad095f3ac8132'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erorr');
    }
  }
}
