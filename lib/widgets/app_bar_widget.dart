import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        const Icon(
          Icons.notifications_none,
          color: Colors.white,
          size: 30,
        ),
      ],
    );
  }
}