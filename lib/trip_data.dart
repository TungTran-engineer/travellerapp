// trips_data.dart
class Trip {
  final String image;
  final String location;
  final String name;
  final String date;
  final String time;

  Trip({
    required this.image,
    required this.location,
    required this.name,
    required this.date,
    required this.time,
  });
}

// Danh sách các chuyến đi (trips)
final List<Trip> trips = [
  Trip(
    image: 'assets/newyork.jpg',
    location: 'New York, USA',
    name: 'New York Trip',
    date: 'Oct 1, 2024',
    time: '12:00 - 18:00',
  ),
  Trip(
    image: 'assets/Sapa.jpg',
    location: 'SaPa, VIET NAM',
    name: 'SaPa Trip',
    date: 'Nov 5, 2024',
    time: '10:00 - 16:00',
  ),
  Trip(
    image: 'assets/paris.jpg',
    location: 'Paris, France',
    name: 'Paris Exploration',
    date: 'Dec 15, 2024',
    time: '09:00 - 17:00',
  ),
  Trip(
    image: 'assets/hoian.jpg',
    location: 'DaNang, Viet Nam',
    name: 'Hoi An',
    date: 'Dec 15, 2024',
    time: '09:00 - 17:00',
  ),
];
