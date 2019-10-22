import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedNewsPage extends StatelessWidget {
  final String titleFromHomePage;
  final String descriptionFromHomePage;
  final String urlFromHomePage;
  final DateTime timeFromHomePage;
  final String sourceFromHomePage;

  DetailedNewsPage({
    this.descriptionFromHomePage,
    this.timeFromHomePage,
    this.titleFromHomePage,
    this.urlFromHomePage,
    this.sourceFromHomePage,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Text(titleFromHomePage,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'linlibertine_abl')),
            ),
//            description
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: descriptionFromHomePage != null
                  ? Text(descriptionFromHomePage,
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
                tag: titleFromHomePage,
                child: urlFromHomePage == null
                    ? Image.asset(
                        'assets/defaultimage.png',
                        fit: BoxFit.fitWidth,
                      )
                    : Image.network(urlFromHomePage),
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
              child: Text("By $sourceFromHomePage",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
//            date
            Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Text(
                "${timeFromHomePage.day}-${timeFromHomePage.month}-${timeFromHomePage.year}",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
