import 'main.dart';
import 'package:flutter/material.dart';

class DetailedNewsPage extends StatelessWidget {
  final String titleFromHomePage;
  final String descriptionFromHomePage;
  final String urlFromHomePage;
  final DateTime timeFromHomePage;
  final String sourceFromHomePage;

  DetailedNewsPage(
      {this.descriptionFromHomePage,
      this.timeFromHomePage,
      this.titleFromHomePage,
      this.urlFromHomePage,
      this.sourceFromHomePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('India'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[Icon(Icons.more_vert), Icon(Icons.share)],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(titleFromHomePage,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            Center(
              child: descriptionFromHomePage != null
                  ? Text(descriptionFromHomePage)
                  : Text('No description provided'),
            ),
            urlFromHomePage == null
                ? Image.asset(
                    'assets/defaultimage.png',
                    fit: BoxFit.fitWidth,
                  )
                : Image.network(urlFromHomePage),
            Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
            Text("By $sourceFromHomePage",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text(
              "${timeFromHomePage.day}-${timeFromHomePage.month}-${timeFromHomePage.year}",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
