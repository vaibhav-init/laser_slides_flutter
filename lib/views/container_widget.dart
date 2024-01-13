import 'package:flutter/material.dart';
import 'package:laser_slides/models/container_model.dart';

class ContainerWidget extends StatelessWidget {
  final ContainerModel containerModel;

  const ContainerWidget({
    super.key,
    required this.containerModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: () {},
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
          height: 200.0,
          margin: const EdgeInsets.all(15.0),
          duration: const Duration(
            milliseconds: 500,
          ),
          child: const Column(),
        ),
      ),
    );
  }
}
