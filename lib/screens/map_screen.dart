import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: 'Google Head Quarters',
    ),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 16,
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: (_pickedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                      markerId: const MarkerId(
                        'm1',
                      ),
                      position: _pickedLocation ??
                          LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          )),
                }),
      appBar: AppBar(
        title: const Text(
          'My Map',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedLocation),
            ),
        ],
      ),
    );
  }
}
