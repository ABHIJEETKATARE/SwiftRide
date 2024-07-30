import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internshala_assignment/features/Bookings/services/ride_booking.dart';
import 'package:internshala_assignment/features/SearchDestination/search_screen.dart';
import 'package:internshala_assignment/features/home/services/home_service.dart';
import 'package:internshala_assignment/global_data/customization_data/customizing_data.dart';
import 'package:internshala_assignment/models/driver.dart';
import 'package:internshala_assignment/models/user.dart';
import 'package:internshala_assignment/providers/user_provider.dart';
import 'package:internshala_assignment/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:internshala_assignment/models/location.dart' as LOCATION;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeService homeService = HomeService();
  final Completer<GoogleMapController> _controller = Completer();
  Position? currentLocation;
  List<Marker>? _markers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCurrentPosition();
    fetchAllDrivers();
  }

  void fetchAllDrivers() async {
    List<Driver> drivers = await homeService.fetchAllDrivers(context);
    for (var i = 0; i < drivers.length; i++) {
      Marker mark = Marker(
          position: LatLng(
              drivers[i].location!.latitude, drivers[i].location!.longitude),
          markerId: MarkerId(i.toString()),
          infoWindow: InfoWindow(title: "Driver : ${drivers[i].name}"));
      if (_markers == null)
        _markers = [mark];
      else
        _markers!.add(mark);
    }
  }

  void loadCurrentPosition() {
    getUserCurrentLocation().then((value) async {
      print(value.latitude.toString());
      print(value.longitude);
      setState(() {
        currentLocation = value;
      });

      Marker mark = Marker(
          markerId: MarkerId('your current location'),
          position: LatLng(
            value.latitude,
            value.longitude,
          ),
          infoWindow: InfoWindow(title: "Your Location"));
      if (_markers == null)
        _markers = [mark];
      else
        _markers!.add(mark);
      CameraPosition cameraPosition =
          CameraPosition(target: LatLng(value.latitude, value.longitude));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      showSnackBar(context: context, message: error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  void navigateToSearchScreen() {
    Navigator.pushNamed(context, SearchScreen.routeName).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Text('BOOK'),
          splashColor: const Color.fromARGB(255, 54, 219, 59),
          tooltip: "Book your ride",
          hoverElevation: 50,
          backgroundColor: Colors.amber,
          onPressed: () {
            navigateToSearchScreen();
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration:
                      const BoxDecoration(gradient: Customize.appBarGradient),
                ),
                title: const Text(
                  "Reach your destination with comfort",
                  style: TextStyle(color: Colors.black),
                ),
              )),
        ),
        body: currentLocation == null
            ? const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (controller) => _controller.complete(controller),
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation!.latitude, currentLocation!.longitude),
                    zoom: 13.5),
                markers: Set<Marker>.of(_markers!),
              ),
      ),
    );
  }
}
