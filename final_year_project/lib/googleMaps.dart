import 'dart:async';

import 'package:final_year_project/details.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class GoogleMapScreen extends StatefulWidget {
  final DetailsResult?
      endPosition; // The position details for the map, passed as a parameter

  const GoogleMapScreen({
    Key? key,
    this.endPosition, // Constructor accepts an optional DetailsResult object
  }) : super(key: key);

  @override
  State<GoogleMapScreen> createState() =>
      _GoogleMapScreenState(); // Creates the state for this widget
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController
      mapController; // Controller for managing the Google Map
  DateTime selectedDate = DateTime
      .now(); // Stores the selected date, initialized to the current date
  late CameraPosition
      _initialPosition; // Initial position of the camera on the map
  final Completer<GoogleMapController> _controller =
      Completer(); // Completer to manage the map controller

  // Function to show a date picker and update the selected date
  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(), // The earliest date selectable is today
      lastDate: DateTime(2025), // The latest date selectable is in 2025
    ).then((value) => setState(() {
          selectedDate = value!; // Updates selectedDate with the chosen date
        }));
  }

  @override
  void initState() {
    super.initState();
    // Sets the initial camera position based on the latitude and longitude from endPosition
    _initialPosition = CameraPosition(
      target: LatLng(widget.endPosition!.geometry!.location!.lat!,
          widget.endPosition!.geometry!.location!.lng!),
      zoom: 14.4746, // Sets the zoom level
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sets a marker on the map at the location provided in endPosition
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId('location'),
        position: LatLng(widget.endPosition!.geometry!.location!.lat!,
            widget.endPosition!.geometry!.location!.lng!),
      )
    };

    return Scaffold(
      body: Stack(
        children: [
          // Displays the Google Map with the initial camera position and markers
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: Set.from(_markers), // Adds the marker to the map
          ),
          // Draggable bottom sheet to display additional details and actions
          DraggableScrollableSheet(
            initialChildSize: 0.25, // Initial height of the sheet
            minChildSize: 0.25, // Minimum height of the sheet
            maxChildSize: 0.7, // Maximum height of the sheet
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Color.fromARGB(
                    255, 251, 251, 251), // Background color of the sheet
                child: SingleChildScrollView(
                  controller:
                      scrollController, // Enables scrolling within the sheet
                  child: Column(
                    children: [
                      // Title section for the address details
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Text(
                          'Address Details',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight
                                .w700, // Bold text style for the title
                          ),
                        ),
                      ),
                      // Divider line below the title
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      // Button to navigate to the DetailScreen
                      Container(
                        height: 50,
                        width: double
                            .infinity, // Button stretches across the entire width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen())); // Navigates to DetailScreen on press
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight
                                  .w600, // Slightly less bold text for the button label
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green, // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25), // Rounded corners for the button
                            ),
                          ),
                        ),
                      ),
                      // Row containing an image and a date picker button
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Aligns children to the start
                        children: [
                          // Image asset displayed within the row
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Image.asset(
                                'assets/truck.jpg',
                                fit: BoxFit.fill, // Image fills the container
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                15, // Space between the image and the date picker button
                          ),
                          // Date picker button
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width *
                                0.5, // Button width is half the screen width
                            child: ElevatedButton(
                              onPressed: () {
                                _showDatePicker(); // Opens the date picker on press
                              },
                              child: Text(
                                'Select Picking Date',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight
                                      .w400, // Normal weight text style for the button
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green, // Button background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners for the button
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Divider line below the row
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      // Row displaying the selected date
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .start, // Aligns children to the start
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 40, // Size of the calendar icon
                            color: Colors.green, // Icon color
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0), // Space between the icon and text
                            child: Text(
                              selectedDate
                                  .toString(), // Displays the selected date as a string
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight
                                    .w600, // Slightly bold text style for the date
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
