import 'dart:convert';
import 'package:flutter/material.dart';
import '../../database/database.dart';

class TripleComboPlot extends StatelessWidget {
  final AppDatabase database;
  final String wellName;
  final String? base64Image;

  const TripleComboPlot({
    Key? key,
    required this.database,
    required this.wellName,
    this.base64Image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (base64Image == null) {
      return const Center(child: Text("No plot generated yet."));
    }

    final decodedBytes = base64Decode(base64Image!);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.white, // Matplotlib output has white background
          width: double.infinity,
          height: double.infinity,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.1,
            maxScale: 10,
            child: Image.memory(
              decodedBytes,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        );
      }
    );
  }
}
