import 'package:http/http.dart' as http;
import 'dart:convert';

class apiHandler {
  static List<dynamic> checkNull(List<dynamic> data) {
    for (var dat in data) {
      if (dat['image_url'] == null) {
        dat['image_url'] = 'https://comnplayscience.eu/app/images/notfound.png';
      }
      if (dat['content'] == null) {
        if (dat['description'] != null) {
          dat['content'] = dat['description'];
        } else {
          dat['content'] = 'No content';
        }
      }
      if (dat['description'] == null) {
        dat['description'] = 'No description';
      }
    }
    return data;
  }

  static Future<Map> getNews(List<String> parameter) async {
    // Real: pub_124249313445c3671fd4d175e97415511a437
    // Reserve: pub_13699438c8b63ce784777146929c925c17dbd
    // Reserve2: pub_14276b8a4fbf8db4357d71da5be8e97b4a76b
    String rawUrl =
        "https://newsdata.io/api/1/news?apikey=pub_14276b8a4fbf8db4357d71da5be8e97b4a76b";
    for (var par in parameter) {
      rawUrl = '$rawUrl&$par';
    }
    var url = Uri.parse(rawUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      checkNull(jsonResponse['results']);
      return jsonResponse;
    }
    throw Exception(response.reasonPhrase);
  }
}
