import 'package:flutter/material.dart';
import 'package:flutter_application_1/EditProfilePage.dart';
import 'package:flutter_application_1/Profile.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true; // Trạng thái của SwitchListTile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('z'), // Thay thế bằng ảnh của bạn
                ),
                SizedBox(width: 16), // Khoảng cách giữa avatar và văn bản
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tuan Tran',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Màu chữ
                      ),
                    ),
                    Text(
                      'Guide',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70, // Màu chữ phụ
                      ),
                    ),
                  ],
                ),
                Spacer(), // Đẩy nút "EDIT PROFILE" sang phải
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green, backgroundColor: Colors.white, // Màu chữ và icon trong nút
                  ),
                  child: Text('EDIT PROFILE'),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // List of Settings Options
          SwitchListTile(
            title: Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          Divider(), // Gạch chân sau mục "Notifications"

          ListTile(
            leading: Icon(Icons.language), // Icon bên trái (thế giới hoặc bất kỳ biểu tượng nào bạn muốn)
            title: Text('Languages'),
            trailing: Icon(Icons.arrow_forward_ios), // Mũi tên ở bên phải
            onTap: () {
              // Thêm logic chuyển trang Languages
            },
          ),
          Divider(), // Gạch chân sau mục "Languages"

          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Payment Info'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Payment Info Page
            },
          ),
          Divider(), // Gạch chân sau mục "Payment Info"

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Income Stats'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Income Stats Page
            },
          ),
          Divider(), // Gạch chân sau mục "Income Stats"

          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy & Policies'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Privacy & Policies Page
            },
          ),
          Divider(), // Gạch chân sau mục "Privacy & Policies"

          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Feedback Page
            },
          ),
          Divider(), // Gạch chân sau mục "Feedback"

          ListTile(
            leading: Icon(Icons.book),
            title: Text('Usage'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Usage Page
            },
          ),
          Divider(), // Gạch chân sau mục "Usage"
          SizedBox(height: 20),

          // Sign Out Button
          Center(
            child: TextButton(
              onPressed: () {
                // Sign out function
              },
              child: Text(
                'Sign out',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
