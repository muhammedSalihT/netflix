import 'package:flutter/material.dart';
import 'package:netflix/utils/text.dart';
import 'package:netflix/widgets/top_rating.dart';
import 'package:netflix/widgets/trending.dart';
import 'package:netflix/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

 void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        textTheme:
        Theme.of(context).textTheme.apply(
      bodyColor: Colors.white,
      // displayColor: Colors.pinkAccent,
    ),
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];

  final String apikey = "cbf993dee362f007e50177122ed7a343";

  final readAccesToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYmY5OTNkZWUzNjJmMDA3ZTUwMTc3MTIyZWQ3YTM0MyIsInN1YiI6IjYyYzdiMWM3ZjY1OTZmMDA0ZDc5NDkxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kSN7VOD86w2gejIjFXoTnlTtb64vFq_JzA6ckj-dhCA";

  loadMovies() async {
    TMDB tmdbWithCoustemLogs = TMDB(ApiKeys(apikey, readAccesToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trendingResult = await tmdbWithCoustemLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCoustemLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCoustemLogs.v3.tv.getPopular();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult["results"];
      tv = tvResult["results"];
    });
    print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const ModifiedText(text: "NetFlix",color: Colors.red,size: 40,)),
      body: ListView(
        children: [
          TvShows(tvShows: tv),
          TopRatedMovies(topRating:topRatedMovies),
          TrendingMovies(trending:trendingMovies)
        ],
      ),
    );
  }
}
