import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/MyTripsPage.dart';
import 'package:flutter_application_1/Chat.dart';
import 'package:flutter_application_1/Profile.dart';
import 'package:flutter_application_1/notification.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(), // Hiển thị khi đang tải
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(Icons.error, color: Colors.red), // Hiển thị khi link lỗi
      ),
      fit: BoxFit.cover,
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Guide> guides = [
    Guide(
      name: 'Tuan Tran',
      location: 'Danang, Vietnam',
      imageUrl: 'assets/guide1.png',
    ),
    Guide(
      name: 'Emmy',
      location: 'Hanoi, Vietnam',
      imageUrl: 'assets/guide2.png',
    ),
    Guide(
      name: 'Linh Hana',
      location: 'Danang, Vietnam',
      imageUrl: 'assets/guide3.png',
    ),
    Guide(
      name: 'Khai Ho',
      location: 'Ho Chi Minh, Vietnam',
      imageUrl: 'assets/guide4.png',
    ),
  ];

  // API URL
  final String apiUrl = 'https://api-travell-app-1.onrender.com/trip/';
  List<dynamic> trips = [];
  bool isLoading = true;

  // Giả sử biến này chứa số lượng thông báo chưa đọc
  int _notificationCount = 2;

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  Future<void> fetchTrips() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        trips = json.decode(response.body);
        print(trips);  // In ra kết quả JSON
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load trips');
    }
  } catch (e) {
    print(e);
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/halong.png',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ],
        ),
        centerTitle: true,
        title: Text(
          'Explore Vietnam',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Hi, where do you want to explore?',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            // Featured Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Destinations',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        List<Map<String, String>> featuredDestinations = [
                          {'name': 'Halong Bay', 'imageUrl': 'assets/halong.png'},
                          {'name': 'Sapa', 'imageUrl': 'assets/Sapa.jpg'},
                          {'name': 'Hoi An', 'imageUrl': 'assets/hoian.jpg'},
                          {'name': 'Sydney', 'imageUrl': 'assets/sydney.png'},
                          {'name': 'New York', 'imageUrl': 'assets/newyork.jpg'},
                          {'name': 'Paris', 'imageUrl': 'assets/paris.jpg'},
                        ];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildFeaturedCard(
                            featuredDestinations[index]['name']!,
                            featuredDestinations[index]['imageUrl']!,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Upcoming Trips Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Trips',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : trips.isEmpty
                          ? Center(
                              child: Text(
                                'No trips available!',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: trips.length,
                              itemBuilder: (context, index) {
                                final trip = trips[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: TripCard(
                                    trip: Trip(
                                      name: trip['title'],
                                      location: trip['location'],
                                      imageUrl: trip['imageUrl'],
                                      date: trip['date'],
                                      title: trip['title'],
                                      description: trip['description'],
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
              ),
            ),
            // Popular Guides Section
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Guides',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (guides.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final startIndex = index * 2;
                    final endIndex = (startIndex + 2).clamp(0, guides.length);
                    final guidesOnPage = guides.sublist(startIndex, endIndex);

                    return Row(
                      children: guidesOnPage.map((guide) {
                        return Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GuideCard(guide: guide),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Theme.of(context).primaryColor),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.map, color: Colors.grey[600]),
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
                    icon: Icon(Icons.notifications, color: Colors.grey[600]),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => NotificationsPage()),
                      );
                    },
                  ),
                  if (_notificationCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
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
                icon: Icon(Icons.chat, color: Colors.grey[600]),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.grey[600]),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(String name, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Classes for Guide and Trip
class Guide {
  final String name;
  final String location;
  final String imageUrl;


  Guide({
    required this.name,
    required this.location,
    required this.imageUrl,

  });
}

class Trip {
  final String name;
  final String title;
  final String location;
  final String imageUrl;
  final String description;
  final String date;

  Trip({
    required this.name,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.date,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      name: json['name'],
      title: json['title'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      date: json['date'],
    );
  }
}



class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  trip.imageUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
                headers: {"User-Agent": "Mozilla/5.0"}, // Thêm header để giả lập trình duyệt
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  trip.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  trip.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  trip.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// GuideCard widget
class GuideCard extends StatelessWidget {
  final Guide guide;

  const GuideCard({Key? key, required this.guide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            guide.imageUrl,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              guide.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              guide.location,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
