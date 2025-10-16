import 'package:flutter/material.dart';
import 'package:flutter_poc/widgets/app_layout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationUI extends StatefulWidget {
  const LocationUI({super.key});

  @override
  State<LocationUI> createState() => _LocationState();
}

class _LocationState extends State<LocationUI> {
  Position? position;
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  Future<void> getLocation() async {
    late bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location Service is disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'You have denied the permission');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'You have denied the permission forever');
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              position == null
                  ? 'Location'
                  : 'Lat: ${position!.latitude}, Lng: ${position!.longitude}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: getLocation, child: Text('Get Location')),
          ],
        ),
      ),
    );
  }
}
