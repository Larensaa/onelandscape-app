import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/tematik_menu_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/onemap.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16), // Jarak setelah gambar

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      context,
                      title: 'Peta',
                      actionText: 'Tampilan Penuh',
                    ),
                    const SizedBox(height: 2),
                    _buildMapPreview(),
                    const SizedBox(height: 5),
                    _buildSectionHeader(
                      context,
                      title: 'Tematik',
                      actionText: 'Semua Menu',
                    ),
                    const SizedBox(height: 5),
                    const TematikMenuGrid(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String actionText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            if (title == 'Peta') {
              context.push('/map-full');
            } else if (title == 'Tematik') {
              context.push('/tematik-detail');
            }
          },
          child: Text(
            actionText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapPreview() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      elevation: 4,
      child: SizedBox(
        height: 180,
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(-3.317, 114.590),
            initialZoom: 9.0,
            interactionOptions: InteractionOptions(flags: InteractiveFlag.none),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}{r}.png?key={apiKey}',
              additionalOptions: const {
                'apiKey': 'TIHbKh1ipYKEv5heVCkc',
              },
            ),
          ],
        ),
      ),
    );
  }
}
