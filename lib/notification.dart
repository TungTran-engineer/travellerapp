import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chat.dart';
import 'package:flutter_application_1/Profile.dart';
import 'package:flutter_application_1/MyTripsPage.dart';
import 'package:flutter_application_1/home.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _notificationCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Image.asset(
          'assets/dragon-bridge.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildNotificationItem(
            context,
            avatarUrl: 'assets/guide1.png',
            name: 'Yoo Jin chose you for the trip in Danang, Vietnam on Jan 20, 2020',
            date: 'Jan 16',
            icon: Icons.check_circle_outline,
            iconColor: Colors.orange,
          ),
          Divider(),  // Thêm đường gạch chân giữa các thông báo
          _buildNotificationItem(
            context,
            avatarUrl: 'assets/guide1.png',
            name: 'Yoo Jin paid upfront 50% for the trip in Danang, Vietnam on Jan 20, 2020. You can start the trip as scheduled.',
            date: 'Jan 16',
            icon: Icons.attach_money,
            iconColor: Colors.green,
          ),
          Divider(),  // Thêm đường gạch chân giữa các thông báo
          _buildNotificationItem(
            context,
            avatarUrl: 'assets/guide1.png',
            name: 'Yoo Jin left a review for you',
            date: 'Jan 24',
            icon: Icons.rate_review,
            iconColor: Colors.blue,
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildNotificationItem(BuildContext context, {
    required String avatarUrl,
    required String name,
    required String date,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatarUrl),
            radius: 25,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: iconColor, size: 16),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  );
              },
            ),
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyTripsPage()),
                );
              },
            ),
            Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
                  },
                ),
                if (_notificationCount > 0)
                  Positioned(
                    right: 0,  // Canh phải
                    top: 0,    // Canh trên
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$_notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
        ),
    );
  }
}
