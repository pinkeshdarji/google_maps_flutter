import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Snapshot extends StatefulWidget {
  @override
  _SnapshotState createState() => _SnapshotState();
}

class _SnapshotState extends State<Snapshot> {
  static final LatLng _kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  GoogleMapController _controller;
  Uint8List _imageBytes;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: _kInitialPosition,
            zoomControlsEnabled: false,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey[50], border: Border.all(width: 3)),
            height: 150,
            width: 120,
            margin: EdgeInsets.all(8),
            child: _imageBytes != null ? Image.memory(_imageBytes) : null,
          ),
          Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    final imageBytes = await _controller.takeSnapshot();
                    setState(() {
                      _imageBytes = imageBytes;
                    });
                  },
                  child: Icon(Icons.fullscreen),
                ),
              ))
        ],
      ),
    );
  }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Google Maps Demo'),
  //       ),
  //       body: Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             SizedBox(
  //               height: 180,
  //               child: GoogleMap(
  //                 onMapCreated: onMapCreated,
  //                 initialCameraPosition: _kInitialPosition,
  //               ),
  //             ),
  //             TextButton(
  //               child: Text('Take a snapshot'),
  //               onPressed: () async {
  //                 final imageBytes = await _controller.takeSnapshot();
  //                 setState(() {
  //                   _imageBytes = imageBytes;
  //                 });
  //               },
  //             ),
  //             Container(
  //               decoration: BoxDecoration(color: Colors.blueGrey[50]),
  //               height: 180,
  //               child: _imageBytes != null ? Image.memory(_imageBytes) : null,
  //             ),
  //           ],
  //         ),
  //       ));
  // }
}
