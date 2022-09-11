import 'package:flutter/material.dart';
import 'package:one_page_app/models/feed_model.dart';
import 'package:one_page_app/services/services.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class OnePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  List<Datum> listFeed = [];
  bool isLastPage = false;
  List<String> sortByValues = [
    'recent',
    'oldest',
  ];
  late String currentSortOrder;

  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    //set initial sort order
    currentSortOrder = sortByValues[0];
    // fetch initial feed data
    fetchFeed();
    // listen for when to fetch more feed data
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetchFeed();
      }
    });
  }

  Future fetchFeed() async {
    var lastFeedId = 0;

    if (listFeed.isNotEmpty) {
      lastFeedId = listFeed.last.id ?? 0;
    }

    final feedData =
        await getFeed(lastPostId: lastFeedId, order: currentSortOrder);

    setState(() {
      listFeed.addAll(feedData.data as Iterable<Datum>);
    });
  }

  String timeAgo(DateTime fatchedDate) {
    DateTime currentDate = DateTime.now();

    var different = currentDate.difference(fatchedDate);

    if (different.inDays > 365) {
      return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (different.inDays > 30) {
      return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (different.inDays > 7) {
      return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (different.inDays > 0) {
      return "${different.inDays} ${different.inDays == 1 ? "day" : "days"} ago";
    }
    if (different.inHours > 0) {
      return "${different.inHours} ${different.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (different.inMinutes > 0) {
      return "${different.inMinutes} ${different.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    if (different.inMinutes == 0) return 'Just Now';

    return fatchedDate.toString();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.black87,
            child: Column(children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Sort by:',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.black,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: currentSortOrder,
                          items: sortByValues.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                '${items[0].toUpperCase()}${items.substring(1).toLowerCase()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newSortValue) {
                            listFeed.clear();

                            setState(() {
                              currentSortOrder = newSortValue!;
                            });

                            fetchFeed();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: controller,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 3,
                  ),
                  itemCount: listFeed.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    print('length ${listFeed.length}');

                    if (index < listFeed.length) {
                      final author = listFeed[index];
                      DateTime date = DateTime.fromMillisecondsSinceEpoch(
                          author.timestamp! * 1000);
                      var timeAgo = timeago.format(date);

                      return Container(
                        color: Colors.black87,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                            author.authorAvatarUrl.toString()),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                author.authorName.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '@${author.authorName.toString().replaceAll(' ', '')}',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            timeAgo,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      //  Text(snapshot.data!.data![index].),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    author.title != null || author.title == ""
                                        ? author.title.toString()
                                        : 'No POST',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    author.text.toString(),
                                    maxLines: 4,
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
                                  author.totalPostViews.toString(),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      );
}
