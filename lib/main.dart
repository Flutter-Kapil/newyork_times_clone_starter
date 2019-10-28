import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newyork_times_clone_starter/detailed_article_page.dart';
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
    print('will try to fetch news');
    newsMap = await getNewsJsonLink.fetchNewsMapFromURL();
    print('news fetched and itemCOunt should be ${newsMap['articles'].length}');
    fetchedNews = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Icon(
              Icons.more_vert,
              color: Colors.black38,
            )
          ],
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Your Times',
            style: TextStyle(
                fontSize: 32, color: Colors.black, fontFamily: 'OldLondon'),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.fromLTRB(7, 0, 7, 12),
            unselectedLabelStyle:
                TextStyle(color: Colors.black38, fontSize: 18),
            indicatorColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black, fontSize: 19),
            labelColor: Colors.black,
            isScrollable: true,
            onTap: (x) {
              fetchedNews = false;
              if (x == 0) getNewsJsonLink = NetworkHelper(countryName: 'in');
              if (x == 1) getNewsJsonLink = NetworkHelper(countryName: 'au');
              if (x == 2) getNewsJsonLink = NetworkHelper(countryName: 'us');
              if (x == 3) getNewsJsonLink = NetworkHelper(countryName: 'nz');
              if (x == 4) getNewsJsonLink = NetworkHelper(countryName: 'id');
              fetchingNewsData();
              setState(() {});
            },
            tabs: <Widget>[
              Text(
                "India",
              ),
              Text("Australia"),
              Text("USA"),
              Text("NewZealand"),
              Text("Indonesia"),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 15,
                child: RefreshIndicator(
                  onRefresh: () async {
                    fetchingNewsData();
                    print('news refreshed');

                    setState(() {});
                  },
                  child: fetchedNews
                      ? HomeScreenNewsCardList(
                          fetchedNews: fetchedNews, newsMap: newsMap)
                      : Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                            backgroundColor: Colors.red,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreenNewsCardList extends StatelessWidget {
  final bool fetchedNews;
  final Map newsMap;

  HomeScreenNewsCardList({
    this.fetchedNews,
    this.newsMap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: newsMap['articles'].length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,
            onTap: () {
              print('tapped');
              Navigator.push(
                  (context),
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailedNewsPage(newsMap['articles'][index])));
            },
            contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            title: Container(
//              height: 200,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  //title
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      newsMap['articles'][index]['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'linlibertine_r'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      strutStyle: StrutStyle(height: 1),
                    ),
                  ),
//                  description and image
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
//                            width: 250,
                            margin: EdgeInsets.all(2.0),
                            child: newsMap['articles'][index]['description'] !=
                                    null
                                ? Text(
                                    newsMap['articles'][index]['description'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontFamily: 'linlibertine_dr'),
                                    strutStyle: StrutStyle(height: 1),
                                  )
                                : Text('No description provided'),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
//                            width: 150,
                            margin: EdgeInsets.all(2.0),
                            child: Hero(
                              tag: newsMap['articles'][index]['title'],
                              child: newsMap['articles'][index]['urlToImage'] !=
                                      null
                                  ? Image.network(
                                      newsMap['articles'][index]['urlToImage'],
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset('assets/defaultimage.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
//                  source , time,  bookmark and share icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: <Widget>[
                              Text(newsMap['articles'][index]['source']['name'],
                                  style: TextStyle(color: Colors.grey)),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                    '${DateTime.now().difference(DateTime.parse(newsMap['articles'][index]['publishedAt'])).inHours} hour(s) ago',
                                    style: TextStyle(color: Colors.grey)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: Colors.blueGrey,
                              ),
                              Icon(
                                Icons.bookmark_border,
                                color: Colors.blueGrey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    color: Colors.black12,
                    height: 2.0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
