// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_poc/widgets/app_layout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapUi extends StatefulWidget {
  const MapUi({super.key});

  @override
  State<MapUi> createState() => _MapUiState();
}

class _MapUiState extends State<MapUi> {
  PolylinePoints polylinePoints = PolylinePoints(
    apiKey: "AIzaSyBqNV2kFh3jB6U6sxInD0H4mdnPEsGMUbs",
  );
  LatLng? currentLocation;
  LatLng destinationLocation = LatLng(37.4243, -122.0848);
  final Geolocator locationController = Geolocator();
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocation().then(
      (_) => {
        getPolylinePoints().then(
          (coordinates) => {generatePolylineFromPoints(coordinates)},
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  mapController.complete(controller)),

              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 13,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: currentLocation!,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permissionGranted;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) return;
    }

    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted != LocationPermission.always) return;
    }

    final locData = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(locData.latitude, locData.longitude);
    });

    Geolocator.getPositionStream().listen((loc) {
      setState(() {
        currentLocation = LatLng(loc.latitude, loc.longitude);
        cameraPosition(currentLocation!);
      });
    });
  }

  Future<void> cameraPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition cameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints(
      apiKey: 'AIzaSyBqNV2kFh3jB6U6sxInD0H4mdnPEsGMUbs',
    );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ),
        destination: PointLatLng(
          destinationLocation.latitude,
          destinationLocation.longitude,
        ),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {}
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }
}
