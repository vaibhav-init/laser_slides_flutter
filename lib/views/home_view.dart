import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamController<bool> wifiStreamController = StreamController<bool>();

void checkWifiStatus() async {
  ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());

  bool isConnectedToWifi = connectivityResult == ConnectivityResult.wifi;

  wifiStreamController.add(isConnectedToWifi);
}

void setupWifiStream() {
  checkWifiStatus(); // Check initially
  // Periodically check WiFi status, you can use a timer or any suitable approach
  Timer.periodic(const Duration(seconds: 2), (timer) {
    checkWifiStatus();
  });
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    setupWifiStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.jpg',
          height: 50,
          width: 100,
        ),
        actions: [
          StreamBuilder<bool>(
            stream: wifiStreamController.stream,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              bool isConnected = snapshot.data ?? false;
              return Stack(
                children: [
                  const Icon(
                    Icons.wifi,
                    size: 30,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: isConnected ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
