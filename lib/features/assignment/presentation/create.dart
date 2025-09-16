import 'package:flutter/material.dart';
import 'package:school_app/core/utils/color_const.dart';
import 'package:school_app/widgets/custom_dropdown.dart';
import 'package:school_app/widgets/custom_textformfield.dart';
import 'package:school_app/widgets/custom_elevatedbutton.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAssignment extends StatefulWidget {
  final String token;
  const CreateAssignment({super.key, required this.token});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedSemester;
  String? selectedFaculty;
  String? selectedSubjectId;

  final List<String> semesters = [
    "First Semester",
    "Second Semester",
    "Third Semester",
    "Fourth Semester",
  ];

  final List<String> faculties = ["BCA", "CSIT", "BBA", "BBS"];

  List<Map<String, String>> subjects = [];
  bool isLoadingSubjects = true;

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  /// Fetch subjects with robust error handling
  Future<void> fetchSubjects() async {
    const url = "https://7efdb0a73258.ngrok-free.app/subjects/list";

    setState(() => isLoadingSubjects = true);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer ${widget.token}"},
      );

      print("Fetch Subjects Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Use safe parsing
        final List<dynamic> data = jsonResponse["data"] ?? [];

        if (data.isEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("No subjects found.")));
        }

        final List<Map<String, String>> loadedSubjects = data
            .map<Map<String, String>>((subject) {
              return {
                "id": subject["subject_id"]?.toString() ?? "",
                "name": subject["name"]?.toString() ?? "",
              };
            })
            .toList();

        setState(() {
          subjects = loadedSubjects;
          isLoadingSubjects = false;
        });
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid token");
      } else {
        throw Exception(
          "Failed to load subjects (Status: ${response.statusCode})",
        );
      }
    } catch (e) {
      print("Error fetching subjects: $e");
      setState(() => isLoadingSubjects = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load subjects: $e")));
    }
  }

  Future<void> createAssignment(Map<String, dynamic> assignmentData) async {
    const String apiUrl =
        "https://7efdb0a73258.ngrok-free.app/assignments/create";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
        body: json.encode(assignmentData),
      );

      print("Create Assignment Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignment created successfully!')),
        );

        // Optionally, reset form
        _formKey.currentState?.reset();
        setState(() {
          selectedSemester = null;
          selectedFaculty = null;
          selectedSubjectId = null;
        });
      } else {
        final errorData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed: ${errorData['message'] ?? 'Unknown error'}"),
          ),
        );
      }
    } catch (e) {
      print("Error creating assignment: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 Top header
          Container(
            width: double.infinity,
            height: double.infinity,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 60),
                Icon(Icons.assignment, color: Colors.white, size: 50),
                SizedBox(height: 10),
                Text(
                  'Create Assignment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Fill in details to add a new assignment',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // 🧾 White form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextform(
                        controller: titleController,
                        labelText: 'Title',
                        prefixIcon: const Icon(Icons.title),
                        validator: (value) =>
                            value!.isEmpty ? 'Title is required' : null,
                        onChanged: (val) => titleController.text = val,
                      ),
                      CustomTextform(
                        controller: descriptionController,
                        labelText: 'Description',
                        prefixIcon: const Icon(Icons.description),
                        validator: (value) =>
                            value!.isEmpty ? 'Description is required' : null,
                        onChanged: (val) => descriptionController.text = val,
                      ),
                      DropDown(
                        labelText: 'Semester',
                        items: semesters,
                        value: selectedSemester,
                        onChanged: (val) =>
                            setState(() => selectedSemester = val!),
                        validator: (value) =>
                            value == null ? 'Please select semester' : null,
                      ),
                      DropDown(
                        labelText: 'Faculty',
                        items: faculties,
                        value: selectedFaculty,
                        onChanged: (val) =>
                            setState(() => selectedFaculty = val!),
                        validator: (value) =>
                            value == null ? 'Please select faculty' : null,
                      ),

                      /// Subject Dropdown
                      isLoadingSubjects
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircularProgressIndicator(),
                            )
                          : DropDown(
                              labelText: 'Subject',
                              items: subjects.map((s) => s["name"]!).toList(),
                              value: selectedSubjectId != null
                                  ? subjects.firstWhere(
                                      (s) => s["id"] == selectedSubjectId,
                                    )["name"]
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  selectedSubjectId = subjects.firstWhere(
                                    (s) => s["name"] == val,
                                  )["id"];
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Please select subject'
                                  : null,
                            ),

                      const SizedBox(height: 20),

                      CustomElevatedButton(
                        backgroundColor: secondaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final assignmentData = {
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "subject_id": selectedSubjectId,
                              "semester": selectedSemester,
                              "faculty": selectedFaculty,
                            };
                            createAssignment(assignmentData);
                          }
                        },
                        child: const Text("Create Assignment"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
