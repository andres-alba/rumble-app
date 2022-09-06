
import 'package:flutter/material.dart';

class OnePage extends StatefulWidget {

  @override
  // ignore: library_private_types_in_public_api
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            Padding(
              padding:
                   EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
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
                  // Container(
                  //   height:200,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //         // render the list
                  //         itemCount: snapshot.data!.length,
                  //         itemBuilder: (BuildContext context, index) => Card(
                  //           margin:  EdgeInsets.all(10),
                  //           // render list item
                  //           child: ListTile(
                  //             contentPadding:  EdgeInsets.all(10),
                  //             title: Text(snapshot.data![index]['title']),
                  //             subtitle: Text(snapshot.data![index]['body']),
                  //           ),
                  //         )),
                  // ),
                ],
              ),
            ),
          ],
        ),
      );
}
