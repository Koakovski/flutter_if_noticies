import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternetAccess() async {
  List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  }

  try {
    List<InternetAddress> result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}
