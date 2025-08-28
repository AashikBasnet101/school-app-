import 'package:flutter/material.dart';

String appName = "Test";
String passwordStr = "Password";
String confirmpasswordStr = "Confirm Password";
String emailStr = "Email";
String signupStr = "Sign Up";
String loginStr = "Login";
String emailValidationStr = "Email is required";
String firstnameStr = "First Name";
String lastnameStr = "Last Name";
String firstnameValidationStr = "First Name is required";
String lastnameValidationStr = "Last Name is required";
String passwordValidationStr = "Password is required";
String confirmpasswordValidationStr = "Password is required";
String genderValidatorStr = " choose a gender";
List<String> genderList = ["Male", "Female", "Others"];
String genderStr = "Gender";
Icon emailIcon = Icon(Icons.email);
Icon lockIcon = Icon(Icons.lock);

IconButton visibilityIconButton(bool isObscure, VoidCallback onTap) {
  return IconButton(
    icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
    onPressed: onTap,
  );
}

const List<Map<String, dynamic>> settingsItems = [
  {'icon': Icons.lock_outline, 'title': 'Change Password'},
  {'icon': Icons.notifications_none, 'title': 'Manage Notifications'},
  {'icon': Icons.light_mode_outlined, 'title': 'Theme', 'trailing': 'Light'},
  {'icon': Icons.language, 'title': 'Language', 'trailing': 'English'},
  {'icon': Icons.logout, 'title': 'Log Out'},
];

const List<Map<String, dynamic>> notificationItems = [
  {
    'icon': Icons.campaign_outlined,
    'title': 'School Assembly',
    'subtitle': 'New school-wide assembly scheduled for next Friday.',
  },
  {
    'icon': Icons.notifications_none,
    'title': 'Exam Alert',
    'subtitle': 'Final exams for the semester are approaching.',
  },
  {
    'icon': Icons.assignment_outlined,
    'title': 'Homework Reminder',
    'subtitle': 'Math assignment due by the end of the week.',
  },
  {
    'icon': Icons.calendar_today_outlined,
    'title': 'School Fair',
    'subtitle': 'Annual school fair on the 20th of next month.',
  },
  {
    'icon': Icons.task_outlined,
    'title': 'Project Deadline',
    'subtitle': 'Science project presentations are due next week.',
  },
  {
    'icon': Icons.event_available_outlined,
    'title': 'Parent-Teacher Meeting',
    'subtitle': 'Scheduled meeting on Wednesday at 4 PM.',
  },
  {
    'icon': Icons.announcement_outlined,
    'title': 'Holiday Notice',
    'subtitle': 'School will remain closed next Monday for a public holiday.',
  },
  {
    'icon': Icons.sports_esports_outlined,
    'title': 'Sports Day',
    'subtitle': 'Annual sports meet to be held next Friday.',
  },
  {
    'icon': Icons.menu_book_outlined,
    'title': 'Library Books Due',
    'subtitle': 'Return all borrowed books by this Friday.',
  },
  {
    'icon': Icons.star_border,
    'title': 'Student of the Month',
    'subtitle': 'Congratulations to Arya Sharma for outstanding performance!',
  },
];

const Map<String, String> profileDetails = {
  'name': 'Aashik Basnet',
  'rollNo': 'Roll No. 2',
  'classInfo': 'Class CSIT 4th sem',
  'editProfile': 'Edit Profile',
};

const List<Map<String, String>> contactInfo = [
  {'label': 'Email', 'value': 'ashik.csit.edu.com.np'},
  {'label': 'Phone', 'value': '+977 9807650978'},
];

const Map<String, dynamic> attendance = {
  'title': 'Attendance',
  'percentage': '92%',
  'progressValue': 0.92,
};

const List<Map<String, dynamic>> achievements = [
  {'icon': Icons.emoji_events_outlined, 'title': 'Academic Excellence Award'},
  {'icon': Icons.campaign_outlined, 'title': 'Debate Competition Winner'},
  {'icon': Icons.campaign_outlined, 'title': 'NIST Hackathon 2nd Runner up'},
  {
    'icon': Icons.sports_soccer_outlined,
    'title': 'Inter-school Football Champion',
  },
  {'icon': Icons.science_outlined, 'title': 'Science Fair - Best Innovation'},
  {
    'icon': Icons.music_note_outlined,
    'title': 'District Music Competition Winner',
  },
  {
    'icon': Icons.palette_outlined,
    'title': 'Art & Craft Exhibition Star Performer',
  },
  {'icon': Icons.computer_outlined, 'title': 'Coding Olympiad Finalist'},
  {
    'icon': Icons.volunteer_activism_outlined,
    'title': 'Community Service Recognition',
  },
  {
    'icon': Icons.leaderboard_outlined,
    'title': 'Top 1% in National Aptitude Test',
  },
];

const String upcomingClassesTitle = 'Upcoming Classes';
const String timetableTitle = 'Timetable';
const String announcementsTitle = 'Announcements';

const List<Map<String, String>> upcomingClasses = [
  {
    'image':
        'https://blog.educationnest.com/wp-content/uploads/2023/10/Untitled-design-2023-10-10T165957.095.jpg',
    'text': 'Math 101\nRoom 201, 9:00 AM',
  },
  {
    'image': 'https://cdn1.byjus.com/wp-content/uploads/2020/09/Science.png',
    'text': 'Science 201\nRoom 302, 10:30 AM',
  },
  {
    'image':
        'https://www.lifewire.com/thmb/TXVRTtkHvRpTjnRObQ3xm2VlsD0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/WirelessNetwork-5994852003f4020011db5333.jpg',
    'text': 'Computer Network\nRoom 305, 12:30 AM',
  },
];

const Map<String, String> timetable = {
  'image':
      'https://kanoriacollege.in/documents/Important%20Announcements/Time%20Table%20Session%202022-23%20for%20B.A.,%20B.A.%20Hons.,%20B.Com.,%20B.Sc.%20Part-I%20(Compulsory%20Subjects).jpg',
};

const List<Map<String, String>> announcements = [
  {
    'title': 'School Closure',
    'subtitle': 'Important updates from the school administration.',
  },
  {
    'title': 'School Event',
    'subtitle': 'Details about the upcoming school event.',
  },
  {
    'title': 'New Timetable',
    'subtitle': 'Revised class schedule will be effective from Monday.',
  },
  {
    'title': 'Uniform Policy',
    'subtitle': 'Students are reminded to follow the updated dress code.',
  },
  {
    'title': 'Library Hours',
    'subtitle': 'Library will remain open until 5 PM during exam week.',
  },
  {
    'title': 'Transportation Update',
    'subtitle': 'Bus routes have been adjusted for better coverage.',
  },
  {
    'title': 'Lost & Found',
    'subtitle': 'Please collect your belongings from the admin office.',
  },
  {
    'title': 'Exam Guidelines',
    'subtitle': 'Follow the instructions strictly during exam week.',
  },
  {
    'title': 'Digital Learning Access',
    'subtitle': 'All students now have access to online learning resources.',
  },
  {
    'title': 'Health & Safety',
    'subtitle': 'New hygiene measures have been implemented on campus.',
  },
];
const List<String> buttons = ['Attendance', 'Grades'];

String selectedGender = '';
String selectedRole = '';

final List<String> genderOptions = ['male', 'female', 'other'];
final List<String> roleOptions = ['student', 'teacher', 'admin'];
