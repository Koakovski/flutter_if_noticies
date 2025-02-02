import 'dart:async';
import 'package:flutter/material.dart';
import 'package:if_noticies/helpers.ts/has_internet_access.dart';

class ConnectivityIcon extends StatefulWidget {
  const ConnectivityIcon({super.key});

  @override
  State<ConnectivityIcon> createState() => _ConnectivityIconState();
}

class _ConnectivityIconState extends State<ConnectivityIcon> {
  late IconData _connectivityIcon;
  late Color _color;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateConnectionStatus();
    _startMonitoring();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _updateConnectionStatus();
    });
  }

  Future<void> _updateConnectionStatus() async {
    bool hasConnection = await hasInternetAccess();
    setState(() {
      if (hasConnection) {
        _connectivityIcon = Icons.wifi;
        _color = Colors.white;
      } else {
        _connectivityIcon = Icons.wifi_off;
        _color = Colors.red;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Icon(
        _connectivityIcon,
        color: _color,
      ),
    );
  }
}
