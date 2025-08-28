import 'package:flutter/material.dart';

import 'package:school_app/core/utils/color_const.dart';
import 'package:school_app/core/utils/string_const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          "NIST College",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                upcomingClassesTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: upcomingClasses
                    .map(
                      (item) => Card(
                        child: Column(
                          children: [
                            Image.network(
                              item['image']!,
                              height: 100,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                            Text(item['text']!),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                timetableTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.98,
              child: Card(
                child: Image.network(timetable['image']!, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                announcementsTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...announcements
                .map(
                  (item) => Card(
                    child: ListTile(
                      title: Text(item['title']!),
                      subtitle: Text(item['subtitle']!),
                    ),
                  ),
                )
                .toList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: buttons
                    .map(
                      (label) =>
                          ElevatedButton(onPressed: () {}, child: Text(label)),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
