import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internshala_assignment/features/Bookings/services/ride_booking.dart';
import 'package:internshala_assignment/global_data/customization_data/customizing_data.dart';
import 'package:internshala_assignment/http_error_handling/error_handling.dart';
import 'package:internshala_assignment/models/user.dart';
import 'package:internshala_assignment/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _suggestionList = [
    'Munekolala, Bengaluru,Vagdevi Vilas School, 77/2, Vagdevi School drive way,',
    'Sector 33, Gurugram',
    'Ward 95 Jubilee Hills, Hyderabad The Pavilion Drive-In, 1014/C, Rd No. 51, The Pavilion Drive-In',
    ' Delhi Technological University, Shahbad Daulatpur Village, Main Bawana Delhi Road',
    'Marredpally, Secunderabad,THE SECUNDERABAD PUBLIC SCHOOL, D.No. 2-12-70, bulton rd',
    'Pattanagere, Bengaluru,Global Academy for Learning, 40, Pattanagere Main Road'
  ];

  TextEditingController _controller = TextEditingController();
  String _sessionToken = "";
  var uuid = Uuid();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestions(_controller.text);
  }

  void getSuggestions(String input) async {
    String googleMapsService_api_key =
        '<YOUR_GOOGLE_API>';
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$url?input=$input&key=$googleMapsService_api_key&sessiontoken=$_sessionToken';
    http.Response response = await http.get(Uri.parse(request));
    print(response.body.toString());
    httpErrorHandle(
        response: response,
        onSuccess: () {
          setState(() {
            _suggestionList =
                jsonDecode(response.body.toString())['predictions'];
          });
        },
        context: context);
  }

  RideBookingService rideBookingService = RideBookingService();
  void rideBooking(context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    rideBookingService.bookRide(
      context: context,
      user: userProvider.user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: Customize.appBarGradient),
            ),
            title: Text(
              "Search Your Destination",
              style: const TextStyle(color: Colors.black),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _controller,
                decoration:
                    InputDecoration(hintText: 'Search your destination'),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _suggestionList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    rideBooking(context);
                  },
                  child: ListTile(
                    title: Text(_suggestionList[index]),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
