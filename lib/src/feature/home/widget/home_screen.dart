import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizzle_starter/src/core/common/app_navigator.dart';

/// {@template home_screen}
/// HomeScreen widget.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro home_screen}
  const HomeScreen({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Title')),
    body: SafeArea(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () => AppNavigator.push(context, Routes.rfw.page()),
            child: const Text('RFW'),
          ),
          ElevatedButton(
            onPressed: () => AppNavigator.push(context, Routes.rfw.page()),
            child: const Text('RFW'),
          ),
        ],
      ),
    ),
  );
}
