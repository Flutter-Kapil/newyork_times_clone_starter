import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedNewsPage extends StatelessWidget {
  final Map articleMap;

  DetailedNewsPage(this.articleMap);

  @override
  Widget build(BuildContext context) {
    DateTime articleTime = DateTime.parse(articleMap['publishedAt']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'India',
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
          Icon(
            Icons.share,
            color: Colors.blueGrey,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: articleMap['description'] != null
                  ? Text(articleMap['description'],
                      style: TextStyle(
                          fontFamily: 'linlibertine_dr', fontSize: 16))
                  : Text(
                      'No description provided',
                      textAlign: TextAlign.center,
                    ),
            ),
//            image
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Hero(
                tag: articleMap['title'],
                child: articleMap['urlToImage'] == null
                    ? Image.asset(
                        'assets/defaultimage.png',
                        fit: BoxFit.fitWidth,
                      )
                    : Image.network(articleMap['urlToImage']),
              ),
            ),
//            image caption
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                    color: Colors.grey, fontFamily: 'linlibertine_dr'),
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
            Text(articleMap[''])
          ],
        ),
      ),
    );
  }
}
