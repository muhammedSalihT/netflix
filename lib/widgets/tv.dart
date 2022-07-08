import 'package:flutter/material.dart';
import 'package:netflix/utils/colors.dart';
import 'package:netflix/utils/text.dart';

class TvShows extends StatelessWidget {
  final List tvShows;
  const TvShows({Key? key, required this.tvShows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(text: "Tv Shows", color: Colors.white, size: 26),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: tvShows.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          width: 140,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration:  BoxDecoration(image: DecorationImage(
                                  image: NetworkImage('https://image.tmdb.org/t/p/w500'+tvShows[index]['poster_path']))),
                              ),
                              SizedBox(
                                child: ModifiedText(text: tvShows[index]['original_name'] !=null? tvShows[index]['original_name']: 'Loading',color: kColorWhite,size: 15),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 5,)
                      ],
                    ),
                  );

                }),
          )
        ],
      ),
    );
  }
}
