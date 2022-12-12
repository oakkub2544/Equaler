import 'package:http/http.dart' as http;
import 'dart:convert';

//class that manage data from api
class ApiHandler {
  //change news results
  static List<dynamic> changeResultsMethod(List<dynamic> data) {
    for (var dat in data) {
      //remove time from pubDate
      dat['pubDate'] = dat['pubDate'].substring(0, dat['pubDate'].indexOf(" "));
      //if image_url not exist or url is incorrrect set it to default image
      if (dat['image_url'] == null || dat['image_url'].length <= 4) {
        dat['image_url'] =
            'https://comnplayscience.eu/app/images/notfound.png'; //set default image
      }
      //if news content not exist change its value
      if (dat['content'] == null) {
        //if news description exist change news content to news description
        if (dat['description'] != null) {
          dat['content'] = dat['description'];
        }
        //if not then no content
        else {
          dat['content'] = 'No content';
        }
      }
      //if news description not exist then no description
      if (dat['description'] == null) {
        dat['description'] = 'No description';
      }
    }
    return data;
  }

  static Future<Map> getNewsMethod(List<String> parameter) async {
    // Real: pub_124249313445c3671fd4d175e97415511a437
    // Reserve: pub_13699438c8b63ce784777146929c925c17dbd
    // Reserve2: pub_14276b8a4fbf8db4357d71da5be8e97b4a76b
    String rawUrl =
        "https://newsdata.io/api/1/news?apikey=pub_124249313445c3671fd4d175e97415511a437";
    // adding parameter to url for more specific query
    for (var par in parameter) {
      rawUrl = '$rawUrl&$par';
    }
    var url = Uri.parse(rawUrl);
    //get response from api provider
    var response = await http.get(url);
    //if successfully call api provider and get data back
    if (response.statusCode == 200) {
      //decode response json to utf8
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      changeResultsMethod(jsonResponse['results']);
      return jsonResponse;
    }
    //if unsuccessfully call api provider and don't get data back
    throw Exception(response.reasonPhrase);
  }
}
