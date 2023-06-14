import 'dart:convert';
import 'package:news/models/article_news.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/article_news.dart';

class News {
  List<ArticleModels> news = [];

  Future<void> getnew() async {
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2022-11-13&to=2022-11-13&sortBy=popularity&apiKey=e123c773339545a7842a00db43bc81bb";
    // var response = await http.get(Uri.parse(
    //     'https://newsapi.org/v2/everything?q=apple&from=2022-11-13&to=2022-11-13&sortBy=popularity&apiKey=e123c773339545a7842a00db43bc81bb'));
    dynamic response = await http.get(Uri.parse(url));

    ///first we will get the request from that url.....used dynamic for change later
    dynamic jsondata = JsonDecoder(response.body);

    ///will decode/convert the json file

    ///as onsite theirs an status which equal to ok then we have that full article
    if (jsondata['status'] == "ok") {
      jsondata['articles'].forEach((element) {
        if (jsondata['urlToImage'] != null && jsondata['description'] != null) {
          //will get all the info by article
          ArticleModels articlemodel = ArticleModels(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urltoimage: element['urlToImage'],
            content: element['content'],
            // publishedat: element['publishedAt'],
          );
          news.add(articlemodel);
        }
      });
    }
  }
}
