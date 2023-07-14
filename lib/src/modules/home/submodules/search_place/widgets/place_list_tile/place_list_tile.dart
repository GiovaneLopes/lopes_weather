import 'package:flutter/material.dart';

class PlaceListTile extends StatelessWidget {
  final String name;
  const PlaceListTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
