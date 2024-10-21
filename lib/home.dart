import 'package:flutter/material.dart';
import 'package:flutter_application_1/MyTripsPage.dart';
import 'package:flutter_application_1/Chat.dart';
import 'package:flutter_application_1/Profile.dart';
import 'package:flutter_application_1/notification.dart';

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
      reviews: 127,
    ),
    Guide(
      name: 'Emmy',
      location: 'Hanoi, Vietnam',
      imageUrl: 'assets/guide2.png',
      reviews: 89,
    ),
    Guide(
      name: 'Linh Hana',
      location: 'Danang, Vietnam',
      imageUrl: 'assets/guide3.png',
      reviews: 127,
    ),
    Guide(
      name: 'Khai Ho',
      location: 'Ho Chi Minh, Vietnam',
      imageUrl: 'assets/guide4.png',
      reviews: 127,
    ),
  ];

  final List<Trip> trips = [
    Trip(
      name: 'Trip to Halong Bay',
      location: 'Quang Ninh, Vietnam',
      imageUrl: 'assets/halong.png',
      date: '2024-11-01',
    ),
    Trip(
      name: 'Trip to Sapa',
      location: 'Lao Cai, Vietnam',
      imageUrl: 'assets/sapa.jpg',
      date: '2024-12-15',
    ),
    Trip(
      name: 'Trip to Hoi An',
      location: 'Quang Nam, Vietnam',
      imageUrl: 'assets/hoian.jpg',
      date: '2024-10-25',
    ),
    Trip(
      name: 'Trip to Paris',
      location: 'Paris, France',
      imageUrl: 'assets/paris.jpg',
      date: '2024-11-10',
    ),
  ];

  // Giả sử biến này chứa số lượng thông báo chưa đọc
  int _notificationCount = 2;

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
                    height: 200, // Chiều cao cho carousel
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
                  Container(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: TripCard(trip: trip),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
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
                          return Expanded(
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
                        MaterialPageRoute(builder: (context) => NotificationsPage()),
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

  Widget _buildFeaturedCard(String destination, String imageUrl) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            spreadRadius: 2.0,
            offset: Offset(2, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Text(
                destination,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GuideCard extends StatelessWidget {
  final Guide guide;

  GuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            guide.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guide.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      guide.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '${guide.reviews} reviews',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;

  TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            trip.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      trip.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      trip.date,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Guide {
  final String name;
  final String location;
  final String imageUrl;
  final int reviews;

  Guide({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.reviews,
  });
}

class Trip {
  final String name;
  final String location;
  final String imageUrl;
  final String date;

  Trip({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.date,
  });
}
