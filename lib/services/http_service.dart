import 'package:http/http.dart' as http;

class HttpService {
  static Map<String, String> headers = {
    'token': 'eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz'
  };

  static Future<http.Response?> postApi({
    required String url,
    Map<String, String>? header,
    dynamic body,
  }) async {
    try {
      header = header ?? {};
      header.addAll(headers);
      return await http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } catch (e) {
      throw (e.toString());
    }
  }
}
