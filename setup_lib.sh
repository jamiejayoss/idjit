#!/bin/bash


# Function to create folders and files in lib directory
setup_lib() {
    mkdir -p lib/apis lib/features lib/core lib/extensions lib/responsive lib/common lib/features/home/mobile lib/features/home/web
    cat <<EOT > lib/extensions/string_extension.dart
import 'dart:developer' as dev;

extension StringExtentension on String {
  String get removeAllWhiteSpace => splitMapJoin(' ');
  int get toInt => int.parse(this);
    log({String? name}) {
    dev.log(this, name: name ?? 'Log');
  }
}

EOT
cat <<EOT > lib/extensions/context_extension.dart
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  showSnackbar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}

EOT

cat <<EOT > lib/main.dart
import 'package:flutter/material.dart';

import 'responsive/responsive_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveView();
  }
}

EOT

cat <<EOT > lib/responsive/responsive_view.dart

import 'package:flutter/material.dart';

import '../features/home/mobile/mobile_home_view.dart';
import '../features/home/web/web_home_view.dart';

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.constrainWidth() < 450) {
          return const MobileHomeView();
        } else {
          return const WebHomeView();
        }
      },
    );
  }
}


EOT

cat <<EOT > lib/features/home/mobile/mobile_home_view.dart
import 'package:flutter/material.dart';

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


EOT

cat <<EOT > lib/features/home/web/web_home_view.dart
import 'package:flutter/material.dart';

class WebHomeView extends StatelessWidget {
  const WebHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


EOT

cat <<EOT > lib/common/common.dart
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(text: text),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loader(),
    );
  }
}

EOT
}