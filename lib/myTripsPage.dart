import 'package:flutter/material.dart';
import 'package:flutter_application_1/Chat.dart';
import 'package:flutter_application_1/Profile.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/notification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Trip {
  final String id;
  final String image;
  final String location;
  final String tripName;
  final String date;
  final String time;
  final String guide;
  final String detail;
  final String chat;
  final String pay;
  final bool isWishList; // Add a field for Wish List categorization

  Trip({
    required this.id,
    required this.image,
    required this.location,
    required this.tripName,
    required this.date,
    required this.time,
    required this.guide,
    required this.detail,
    required this.chat,
    required this.pay,
    required this.isWishList,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    final tripData = json['trip'] ?? {};
    final actionsData = tripData['actions'] ?? {};

    return Trip(
      id: json['_id'] ?? 'Unknown ID',
      image: json['imageURL'] ?? 'assets/placeholder.png',
      location: json['name'] ?? 'Unknown location',
      tripName: tripData['tripName'] ?? 'Unnamed trip',
      date: tripData['date'] ?? 'No date',
      time: tripData['time'] ?? 'No time',
      guide: tripData['guide'] ?? 'No guide',
      detail: actionsData['Detail'] ?? 'No detail',
      chat: actionsData['Chat'] ?? 'No chat link',
      pay: actionsData['Pay'] ?? 'No payment info',
      isWishList: json['isWishList'] ?? false, // This field should be in the API
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
  List<Trip> allTrips = []; // List to hold all trips

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    fetchTrips(); // Fetch API data
  }

  Future<void> fetchTrips() async {
    try {
      final response = await http.get(Uri.parse('https://api-travell-app-1.onrender.com/trip/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          allTrips = jsonData.map((data) => Trip.fromJson(data)).toList();
        });
      } else {
        print('Failed to load trips, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List<Trip> get nowTrips => allTrips.where((trip) => /* add condition for now trips */ true).toList();
  List<Trip> get nextTrips => allTrips.where((trip) => /* add condition for next trips */ true).toList();
  List<Trip> get pastTrips => allTrips.where((trip) => /* add condition for past trips */ true).toList();
  List<Trip> get wishListTrips => allTrips.where((trip) => trip.isWishList).toList();

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
      body: Column(
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
                CurrentTrips(displayedTrips: nowTrips),
                NextTrip(displayedTrips: nextTrips),
                PastTrips(displayedTrips: pastTrips),
                WishList(displayedTrips: wishListTrips),
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

class CurrentTrips extends StatelessWidget {
  final List<Trip> displayedTrips;

  CurrentTrips({required this.displayedTrips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayedTrips.length,
      itemBuilder: (context, index) {
        final trip = displayedTrips[index];
        return TripCard(trip: trip);
      },
    );
  }
}

class NextTrip extends StatelessWidget {
  final List<Trip> displayedTrips;

  NextTrip({required this.displayedTrips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayedTrips.length,
      itemBuilder: (context, index) {
        final trip = displayedTrips[index];
        return TripCard(trip: trip);
      },
    );
  }
}

class PastTrips extends StatelessWidget {
  final List<Trip> displayedTrips;

  PastTrips({required this.displayedTrips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayedTrips.length,
      itemBuilder: (context, index) {
        final trip = displayedTrips[index];
        return TripCard(trip: trip);
      },
    );
  }
}

class WishList extends StatelessWidget {
  final List<Trip> displayedTrips;

  WishList({required this.displayedTrips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayedTrips.length,
      itemBuilder: (context, index) {
        final trip = displayedTrips[index];
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
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: Image.network(
              trip.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey,
                  child: Center(child: Text("Image not available")),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              trip.tripName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
