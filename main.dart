import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage1()),
                );
              },
              child: const Text('Page 1'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage2()),
                );
              },
              child: const Text('Page 2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage3()),
                );
              },
              child: const Text('Page 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage4()),
                );
              },
              child: const Text('Page 4'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage5()),
                );
              },
              child: const Text('Page 5'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPage1 extends StatelessWidget {
  const MapPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page 1'),
      ),
      body: const GoogleMapCirclesWidget(),
    );
  }
}

// User's location
const LatLng userLocation = LatLng(24.506519, 39.619056);

class GoogleMapCirclesWidget extends StatelessWidget {
  const GoogleMapCirclesWidget({super.key});

  static const LatLng kaaba = LatLng(21.422487, 39.826206);
  static const List<LatLng> miqatPoints = [
    LatLng(22.71515249938801, 39.14514729649877),
    LatLng(21.930072877611384, 40.42552892351149),
    LatLng(20.518564356141052, 39.870803989418974),
    LatLng(21.63320606975049, 40.42677866397942),
    LatLng(24.413942807343183, 39.54297293708976)
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate distances for each Miqat point from Kaaba
    List<double> radii = miqatPoints.map((point) => _calculateDistance(kaaba, point)).toList();

    // Determine which circle to show based on user location
    int showCircleIndex = radii.indexWhere((radius) => _calculateDistance(kaaba, userLocation) < radius);
    if (showCircleIndex == -1) {
      showCircleIndex = 0; // Show the first circle if user is outside all circles
    }

    Set<Circle> circles = {
      Circle(
        circleId: CircleId('userLocation'),
        center: userLocation,
        radius: 500, // radius in meters
        fillColor: Colors.blue.withOpacity(0.5),
        strokeColor: Colors.blue,
        strokeWidth: 1,
      ),
      Circle(
        circleId: CircleId('circle${showCircleIndex + 1}'),
        center: kaaba,
        radius: radii[showCircleIndex],
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.2),
      )
    };

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: userLocation,
        zoom: 7.0,
      ),
      circles: circles,
    );
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const earthRadius = 6371000.0; // meters
    final dLat = _degreesToRadians(end.latitude - start.latitude);
    final dLng = _degreesToRadians(end.longitude - start.longitude);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(start.latitude)) * math.cos(_degreesToRadians(end.latitude)) *
            math.sin(dLng / 2) * math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}

class MapPage2 extends StatelessWidget {
  const MapPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page 2'),
      ),
      body: const Center(
        child: Text(
          'Map Page 2 content goes here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MapPage3 extends StatelessWidget {
  const MapPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page 3'),
      ),
      body: const Center(
        child: Text(
          'Map Page 3 content goes here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MapPage4 extends StatelessWidget {
  const MapPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page 4'),
      ),
      body: const Center(
        child: Text(
          'Map Page 4 content goes here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MapPage5 extends StatelessWidget {
  const MapPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page 5'),
      ),
      body: const Center(
        child: Text(
          'Map Page 5 content goes here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
