import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'fullscreen_image.dart';

class DetailedNewsPage extends StatelessWidget {
  final Map articleMap;
  final String countryName;

  DetailedNewsPage(this.articleMap, this.countryName);

  @override
  Widget build(BuildContext context) {
    DateTime articleTime = DateTime.parse(articleMap['publishedAt']);
    return Scaffold(
      appBar: AppBar(
//        backgroundColor: Colors.white,
        title: Text(
          countryName,
          style: TextStyle(color: Colors.grey, fontSize: 24),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.blueGrey,
            onPressed: () {
              Share.share(
                  '${articleMap['title']}\n ${articleMap['description']}\n ${articleMap['url']} ');
            },
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.more_vert,
            color: Colors.blueGrey,
          ),
          SizedBox(
            width: 7,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //title
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text(articleMap['title'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'linlibertine_abl')),
            ),
//            description

//            image
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Hero(
                tag: articleMap['title'],
                child: GestureDetector(
                  onTap: () {
                    if (articleMap['urlToImage'] != null) {
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) =>
                                  FullScreenImage(articleMap['urlToImage'])));
                    }
                  },
                  child: articleMap['urlToImage'] == null
                      ? Image.asset(
                          'assets/defaultimage.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        )
                      : Image.network(articleMap['urlToImage']),
                ),
              ),
            ),
//            image caption
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: articleMap['description'] != null
                  ? Text(articleMap['description'],
                      style: TextStyle(
                        fontFamily: 'linlibertine_dr',
                        fontSize: 16,
                        color: Colors.grey,
                      ))
                  : Text(
                      'No description provided',
                      textAlign: TextAlign.center,
                    ),
            ),
//            source name
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text("By ${articleMap['source']['name']}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
//            date
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text(
                "${articleTime.day}-${articleTime.month}-${articleTime.year}",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: articleMap['content'] != null
                  ? Text(articleMap['content']
                      .substring(0, articleMap['content'].length - 13))
                  : Text(''),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14, 4, 14, 8),
              child: InkWell(
                splashColor: null,
                child: Text(
                  'Read Full News',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  launch(articleMap['url']);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
