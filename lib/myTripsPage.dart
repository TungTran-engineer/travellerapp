import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chat.dart';
import 'package:flutter_application_1/Profile.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Trip {
  final String name;
  final String id;
  final String imageUrl;
  final String location;
  final String date;
  final String guide;

  Trip({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.location,
    required this.date,
    required this.guide,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      name: json['title'] ?? 'No title',
      id: json['_id'] ?? 'Unknown ID',
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'] ?? 'Unknown location',
      date: json['date'] ?? 'Unknown date',
      guide: json['guide'] ?? 'No guide information',
    );
  }
}

class MyTripsPage extends StatefulWidget {
  @override
  _MyTripsPageState createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _notificationCount = 2;
  List<Trip> allTrips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    try {
      final response = await http.get(Uri.parse('https://api-travell-app-1.onrender.com/trip/'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          allTrips = jsonData.map((data) => Trip.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        print('Failed to load trips: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trips: $e');
    }
  }

// Chuyến đi trong quá khứ
List<Trip> get pastTrips => allTrips.where((trip) {
  final tripDate = DateTime.parse(trip.date); // Ngày từ API
  return tripDate.isBefore(DateTime.now()); // Trước thời gian hiện tại
}).toList();

// Chuyến đi đang diễn ra
List<Trip> get nowTrips => allTrips.where((trip) {
  final tripDate = DateTime.parse(trip.date);
  final currentDate = DateTime.now();
  
  // So sánh ngày hiện tại (cùng ngày hoặc cách nhau vài giờ)
  return tripDate.year == currentDate.year &&
         tripDate.month == currentDate.month &&
         tripDate.day == currentDate.day; // Cùng ngày
}).toList();

// Chuyến đi trong tương lai
List<Trip> get nextTrips => allTrips.where((trip) {
  final tripDate = DateTime.parse(trip.date);
  return tripDate.isAfter(DateTime.now()); // Sau thời gian hiện tại
}).toList();


List<Trip> get wishListTrips => allTrips;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Image.asset(
            'assets/sydney.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: Color(0xFF00C39A),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Now Trips'),
                      Tab(text: 'Next Trips'),
                      Tab(text: 'Past Trips'),
                      Tab(text: 'Wish List'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      TripList(trips: nowTrips),
                      TripList(trips: nextTrips),
                      TripList(trips: pastTrips),
                      TripList(trips: wishListTrips),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {},
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
              icon: Icon(Icons.chat),
              onPressed: () {
                Navigator.of(context).pushReplacement(
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
      ),
    );
  }
}

class TripList extends StatelessWidget {
  final List<Trip> trips;

  TripList({required this.trips});

  @override
  Widget build(BuildContext context) {
    return trips.isEmpty
        ? Center(child: Text('No trips available'))
        : ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return TripCard(trip: trip);
            },
          );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;

  TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: trip.imageUrl.isNotEmpty
                ? Image.network(
                    trip.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey,
                    child: Center(child: Text('No Image')),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              trip.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Location: ${trip.location}', style: TextStyle(fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text('Date: ${trip.date}', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
