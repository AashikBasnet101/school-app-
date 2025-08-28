import 'package:flutter/material.dart';

import 'package:school_app/core/utils/color_const.dart';
import 'package:school_app/core/utils/string_const.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,

        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Image
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            const SizedBox(height: 10),
            Text(
              profileDetails['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              profileDetails['rollNo']!,
              style: const TextStyle(color: Colors.blue),
            ),
            Text(
              profileDetails['classInfo']!,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                profileDetails['editProfile']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            // Contact Info
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                contactInfo[0]['label']!.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ...contactInfo
                .map(
                  (item) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Text(
                        item['label']!,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 2),
                      Text(item['value']!),
                    ],
                  ),
                )
                .toList(),
            const SizedBox(height: 20),
            // Attendance
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                attendance['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  attendance['title']!,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(attendance['percentage']!),
              ],
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: attendance['progressValue'] as double,
              color: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            // Achievements
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                achievements[0]['title']!.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ...achievements
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(item['icon']),
                        ),
                        const SizedBox(width: 10),
                        Text(item['title']),
                      ],
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
