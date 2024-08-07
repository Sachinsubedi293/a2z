import 'package:flutter/material.dart';

const baseUrl = "http://10.0.2.2:8000";

class EnvComponents {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static Future<void> showErrorDialog(BuildContext context, dynamic error) async {
  if (!context.mounted) return;

  String errorMessage = 'An error occurred.';
  if (error is Map<String, dynamic>) {
    if (error.containsKey('message') && error.containsKey('errors')) {
      errorMessage = error['message'];
      List<dynamic> errors = error['errors'];
      for (var errorDetail in errors) {
        errorDetail.forEach((key, value) {
          errorMessage += '\n${key.toString()}: ${value.join(', ')}';
        });
      }
    } else {
      errorMessage = error.toString();
    }
  } else if (error is String) {
    errorMessage = error;
  }

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

static Future<bool> showSuccessDialog(BuildContext context, dynamic message) async {
  if (!context.mounted) return false;

  String successMessage = 'Operation successful.';
  String description = '';

  if (message is Map<String, dynamic>) {
    if (message.containsKey('message')) {
      successMessage = message['message'];
    }
    if (message.containsKey('description')) {
      description = message['description'];
    }
  } else if (message is String) {
    successMessage = message;
  }

  return await showDialog<bool>(
        barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Success"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(successMessage),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(description),
            ],
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  ).then((result) => result ?? false);
}
}
