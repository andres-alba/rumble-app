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
  String dropdownvalue = 'Recent';
  var items = [
    'Recent',
    'Oldest',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.black87,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Sort by:',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
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
                                height: 3,
                              ),
                          itemCount: snapshot.data!.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final author = snapshot.data!.data![index];

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
                                                author.authorAvatarUrl.toString()
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(author.authorName.toString(),
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
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
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
                          }),
                    );
                  }
                },
                // By default, show a loading spinner.
              )
            ],
          ),
        ),
      );
}
