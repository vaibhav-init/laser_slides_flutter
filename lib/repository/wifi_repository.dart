// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// StreamController<bool> wifiStreamController = StreamController<bool>();

// class WifiRepository {
//   void checkWifiStatus() async {
//     ConnectivityResult connectivityResult =
//         await (Connectivity().checkConnectivity());

//     bool isConnectedToWifi = connectivityResult == ConnectivityResult.wifi;

//     wifiStreamController.add(isConnectedToWifi);
//   }

//   void setupWifiStream() {
//     checkWifiStatus();
//     Timer.periodic(const Duration(seconds: 2), (timer) {
//       checkWifiStatus();
//     });
//   }
// }
