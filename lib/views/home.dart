import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/category_model.dart';
import 'package:news/helper/data.dart';
import 'package:news/models/article_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<categoryModel> categories = <categoryModel>[];
  List<ArticleModels> articles = <ArticleModels>[];

  bool _loaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getcategory()!;
    getNews();
  }

  ///to fetch the data and load it
  getNews() async {
    News newsclass = News();
    await newsclass.getnew();
    articles = newsclass.news;
    setState(() {
      _loaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Colors.white,
            Text(
              'Daily',
              style: TextStyle(color: Colors.black87, fontSize: 22),
            ),
            Text(
              'News',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: _loaded
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  ///categories
                  Container(
                    height: 80,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageurl: categories[index].imageurl,
                            containerName: categories[index].containerName,
                          );
                        }),
                  ),

                  ///blogs
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          img: articles[index].urltoimage as String,
                          title: articles[index].title as String,
                          desc: articles[index].description as String,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  CategoryTile({this.imageurl, this.containerName});
  final imageurl, containerName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageurl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                containerName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  BlogTile({required this.img, required this.title, required this.desc});
  final String img, title, desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(img),
          Text(title),
          Text(desc),
        ],
      ),
    );
  }
}
