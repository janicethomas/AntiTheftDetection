import 'package:flutter/material.dart';

Future<void> emergencyCallDialog(
    BuildContext context,
    ) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Emergency number has been called'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK')),
        ],
      );
    },
  );
}
