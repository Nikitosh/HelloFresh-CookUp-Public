import 'package:http/http.dart' as http;

const String URL = "https://backend-uu3z6fczaq-lm.a.run.app/";

Future<int> post(String url, dynamic data) async {
  final response = await http.post(
    Uri.parse('$URL$url'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data,
  );

  return response.statusCode;
}

Future<dynamic> postWith(String url, dynamic data) async {
  final response = await http.post(
    Uri.parse('$URL$url'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: data,
  );

  return response.reasonPhrase;
}

Future<dynamic> get(String url) async {
  http.Response response = await http
      .get(Uri.parse('$URL$url'), headers: {"Accept": "application/json"});
  return response.body;
}
