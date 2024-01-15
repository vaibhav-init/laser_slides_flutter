import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laser_slides/common/theme.dart';
import 'package:laser_slides/models/button_model.dart';
import 'package:laser_slides/repository/local_storage_repository.dart';
import 'package:laser_slides/views/add_button_view.dart';
import 'package:laser_slides/views/settings_view.dart';
import 'package:osc/osc.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

StreamController<bool> wifiStreamController = StreamController<bool>();

void checkWifiStatus() async {
  ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());

  bool isConnectedToWifi = connectivityResult == ConnectivityResult.wifi;

  wifiStreamController.add(isConnectedToWifi);
}

void setupWifiStream() {
  checkWifiStatus();
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
  List<ButtonModel> buttons = [];
  final SqliteService sqliteService = SqliteService();
  void sendOSC(ButtonModel buttonModel) {
    final destination = InternetAddress(ref.watch(outgoingIpAddressProvider));

    final message =
        OSCMessage(buttonModel.buttonPressedEvent, arguments: [1, 1]);

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0).then((socket) {
      print('Sending from ${socket.address.address}:${socket.port}...');

      final bytes = message.toBytes();
      socket.send(bytes, destination, ref.watch(outgoingPortProvider));
      print('Sent OSC message: $bytes');

      socket.close();
    });
  }

  @override
  void initState() {
    super.initState();
    setupWifiStream();
    loadButtons();
  }

  Future<void> loadButtons() async {
    List<ButtonModel> loadedButtons = await sqliteService.getAllButtons();
    setState(() {
      buttons = loadedButtons;
    });
  }

  Future<void> addButton(
    String label,
    String buttonpressedEvent,
    String buttonReleasedEvent,
  ) async {}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var darkMode = ref.watch(darkModeProvider);
    Widget buildItem(ButtonModel buttonModel) {
      return Stack(
        key: Key(buttonModel.id),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTapDown: (value) => sendOSC(buttonModel),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: AnimatedContainer(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                margin: const EdgeInsets.all(15.0),
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: Center(
                  child: Text(buttonModel.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      )),
                ),
              ),
            ),
          ),
          Positioned(
            top: -18,
            right: -18,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                //remove this shitty push from here !!!
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditButtonView(
                      buttonModel: buttonModel,
                    ),
                  ),
                ).then(
                  (value) => loadButtons(),
                ),
                icon: const Icon(
                  size: 32,
                  Icons.settings,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.jpg',
          height: 50,
          width: 100,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Switch(
              value: darkMode,
              onChanged: (val) {
                ref.read(darkModeProvider.notifier).toggle();
              },
            ),
          ),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ReorderableGridView.count(
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            crossAxisCount: screenWidth > 600 ? 5 : 2,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                final element = buttons.removeAt(oldIndex);
                buttons.insert(newIndex, element);
              });
              sqliteService.updateButtonOrder(oldIndex, newIndex);
            },
            children: buttons.map((e) => buildItem(e)).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          // replace with named route

          Navigator.pushNamed(context, '/add-edit').then(
            (value) => loadButtons(),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
