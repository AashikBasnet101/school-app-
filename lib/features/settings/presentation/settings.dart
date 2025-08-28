import 'package:flutter/material.dart';

import 'package:school_app/core/utils/color_const.dart';
import 'package:school_app/core/utils/string_const.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        backgroundColor: primaryColor,

        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: settingsItems
            .map(
              (item) => ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item['icon'], color: Colors.black87),
                ),
                title: Text(
                  item['title'],
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: item['trailing'] != null
                    ? Text(
                        item['trailing'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      )
                    : null,
                onTap: () {},
              ),
            )
            .toList(),
      ),
    );
  }
}
