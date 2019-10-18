import 'package:flutter/material.dart';
import 'news_api_helper.dart';

void main() => runApp(MaterialApp(
      home: NewsListPage(),
    ));

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  NetworkHelper getNewsJsonLink = NetworkHelper(countryName: 'in');
  Map newsMap;
  bool fetchedNews = false;

  @override
  void initState() {
    fetchingNewsData();
    super.initState();
  }

  void fetchingNewsData() async {
    fetchedNews = false;
    print('will try to fetch news');
    newsMap = await getNewsJsonLink.fetchNewsMapFromURL();
    print('news fetched and itemCOunt should be ${newsMap['articles'].length}');
    fetchedNews = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Your Times',
          style: TextStyle(
              fontSize: 32, color: Colors.black, fontFamily: 'OldLondon'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                child: Text('getNews'),
                onPressed: () {
                  print(getNewsJsonLink.url);
                  setState(() {});
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: fetchedNews
                  ? HomeScreenNewsCardList(
                      fetchedNews: fetchedNews, newsMap: newsMap)
                  : Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        backgroundColor: Colors.red,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreenNewsCardList extends StatelessWidget {
  const HomeScreenNewsCardList({
    Key key,
    @required this.fetchedNews,
    @required this.newsMap,
  }) : super(key: key);

  final bool fetchedNews;
  final Map newsMap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: newsMap['articles'].length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(newsMap['articles'][index]['title'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: 250,
                        margin: EdgeInsets.all(2.0),
                        child: newsMap['articles'][index]['description'] != null
                            ? Text(newsMap['articles'][index]['description'])
                            : Text('No description provided'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.all(12.0),
                        child: newsMap['articles'][index]['urlToImage'] == null
                            ? Image.asset('assets/defaultimage.png')
                            : Image.network(
                                newsMap['articles'][index]['urlToImage']),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                            newsMap['articles'][index]['source']['name'],
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.share),
                            Icon(Icons.bookmark_border)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.black,
                  height: 2.0,
                ),
              ],
            ),
          );
        });
  }
}
