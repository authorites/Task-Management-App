import 'package:flutter/material.dart';
import 'package:task_manage_management/core/error/exceptions.dart';

class ErrorDialogWidget extends StatelessWidget {
  const ErrorDialogWidget({
    required this.error,
    super.key,
  });
  final Exception error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(
        switch (error.runtimeType) {
          ServerException => 'Please connect to the internet and try again',
          _ => 'Something went wrong'
        },
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
