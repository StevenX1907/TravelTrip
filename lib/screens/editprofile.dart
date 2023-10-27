import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Function(String, String, String) onProfileUpdated;

  EditProfilePage({required this.onProfileUpdated});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: nationalityController,
              decoration: InputDecoration(labelText: 'nationality'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 获取用户输入的姓名和性别
                String newName = nameController.text;
                String newGender = genderController.text;
                String newNationality = nationalityController.text;

                // 调用回调函数，将新的姓名和性别传递回ProfilePage
                widget.onProfileUpdated(newName, newGender, newNationality);

                // 返回上一页
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
