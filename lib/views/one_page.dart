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
  List<Datum> listFeed = [];

  @override
  void initState() {
    futureFeed = getFeed();
    fetch();

    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    final feedData = await getFeed();
    setState(() {
      listFeed.addAll(feedData.data as Iterable<Datum>);
    });
  }

  bool isLastPage = false;
  String dropdownvalue = 'Recent';
  var items = [
    'Recent',
    'Oldest',
  ];
  final controller = ScrollController();

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
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
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
                                        radius: 20.0,
                                        backgroundImage: NetworkImage(
                                            author.authorAvatarUrl.toString()),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            author.authorName.toString(),
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                          Text(
                                            author.timestamp.toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
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
