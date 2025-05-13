import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/customer.dart';

class CustomerMapScreen extends StatelessWidget {
  final Customer? customer;

  const CustomerMapScreen({super.key, this.customer});

  @override
  Widget build(BuildContext context) {
    final LatLng customerLocation = LatLng(
      customer!.latitude,
      customer!.longitude,
    );

    return Scaffold(
      appBar: AppBar(title: Text('${customer!.name} Location')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: customerLocation,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId(customer!.id),
            position: customerLocation,
            infoWindow: InfoWindow(title: customer!.name),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
