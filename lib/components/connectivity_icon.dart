import 'package:flutter/material.dart';

class ConnectivityIcon extends StatelessWidget {
  final bool hasConnection;

  const ConnectivityIcon({super.key, required this.hasConnection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Icon(
        hasConnection ? Icons.wifi : Icons.wifi_off,
        color: hasConnection ? Colors.white : const Color(0xFFFFA500),
      ),
    );
  }
}
