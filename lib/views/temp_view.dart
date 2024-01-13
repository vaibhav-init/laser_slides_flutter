import 'package:flutter/material.dart';
import 'package:laser_slides/models/container_model.dart';
import 'package:laser_slides/views/container_widget.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  ContainerPageState createState() => ContainerPageState();
}

class ContainerPageState extends State<ContainerPage> {
  List<ContainerWidget> containers = [];

  List<ContainerWidget> buildContainers() {
    List<ContainerWidget> temp = [];

    for (int i = 0; i < 20; i++) {
      temp.add(
        ContainerWidget(
          containerModel: ContainerModel(
            label: 'temp',
            buttonpressedEvent: '/beyond/startcur/0.1',
            buttonReleasedEvent: '/beyond/reddit/com',
          ),
        ),
      );
    }

    return temp;
  }

  @override
  void initState() {
    super.initState();
    containers = buildContainers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 0.8,
          ),
          itemCount: containers.length,
          itemBuilder: (context, index) {
            return containers[index];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            containers.add(
              ContainerWidget(
                containerModel: ContainerModel(
                  label: 'temp',
                  buttonpressedEvent: '/beyond/startcur/0.1',
                  buttonReleasedEvent: '/beyond/reddit/com',
                ),
              ),
            );
          });
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
