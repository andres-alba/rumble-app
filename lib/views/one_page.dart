import 'package:flutter/material.dart';
import 'package:one_page_app/models/feed_model.dart';
import 'package:one_page_app/services/services.dart';

class OnePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  late Future<Feed> futureFeed;
  @override
  void initState() {
    futureFeed = getFeed();

    super.initState();
  }

  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 80),
            const Text('One Page',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  //wordSpacing: 1.2,
                  height: 1.3,
                )),
            const SizedBox(
              height: 20,
            ),

            FutureBuilder<Feed>(
              future: futureFeed,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                              height: 1,
                            ),
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.black87,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: NetworkImage(
                                                snapshot.data!.data![index]
                                                    .authorAvatarUrl
                                                    .toString()),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          const SizedBox(width: 5,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.data![index]
                                                    .authorName
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              ),
                                              Text(
                                                snapshot.data!.data![index]
                                                    .timestamp
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          //  Text(snapshot.data!.data![index].),
                                        ],
                                      ),
                                      const SizedBox(height:5),
                                      Text(
                                        snapshot.data!.data![index].title !=
                                                    null ||
                                                snapshot.data!.data![index]
                                                        .title ==
                                                    ""
                                            ? snapshot.data!.data![index].title
                                                .toString()
                                            : 'No POST',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        snapshot.data!.data![index].text
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      
                                      Icons.thumb_up_sharp,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      snapshot.data!.data![index].totalPostViews
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height:10),
                              ],
                            ),
                          );
                        }),
                  );

                  //Text(snapshot.data!.data![0].authorId.toString());
                }
              },

              // By default, show a loading spinner.
            )
          ],
        ),
      );
}
