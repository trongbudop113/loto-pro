import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loto/page/shopping/contact/model/contact_box/contact_box_model.dart';

class ContactBoxViewMobile extends StatelessWidget {
  final ContactBoxModel model;
  const ContactBoxViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildContact(),
            const SizedBox(height: 16),
            _buildMap(),
          ],
        ),
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thông tin liên hệ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF8E25),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.store, model.contactData.name),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.phone, model.contactData.phone),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.location_on, model.contactData.address),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Add navigation to map app
              },
              icon: const Icon(Icons.directions),
              label: const Text("Chỉ đường"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8E25),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFFF8E25),
          size: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(model.contactData.latitude, model.contactData.longitude),
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('store'),
              position: LatLng(model.contactData.latitude, model.contactData.longitude),
              infoWindow: InfoWindow(title: model.contactData.name),
            ),
          },
        ),
      ),
    );
  }
}
