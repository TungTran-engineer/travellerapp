import 'package:flutter/material.dart';
import 'package:flutter_application_1/SettingPage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
        title: Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // Thêm logic lưu thông tin khi nhấn "SAVE"
            },
            child: Text(
              'SAVE',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/profile_image.png'), // Thay thế bằng ảnh đại diện
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.green),
                      onPressed: () {
                        // Thêm logic để thay đổi ảnh đại diện
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('Password', '********', isPassword: true),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Thêm logic thay đổi mật khẩu
              },
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            _buildTextField('Address', '123 Xo Viet Nghe Tinh'),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('City', 'Danang'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildTextField('Country', 'Vietnam'),
                ),
              ],
            ),
            SizedBox(height: 10),
            _buildTextField('Phone number', '(+84) 912 345 678'),
            TextButton(
              onPressed: () {
                // Thêm logic thay đổi thời gian khả dụng
              },
              child: Text(
                'Change Available time',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: placeholder,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), // Đường kẻ dưới mặc định
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green), // Đường kẻ dưới khi focus
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
          ),
        ),
      ],
    );
  }
}
