import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final bool? isSuccess;
  final String message;

  const CustomDialog({Key? key, this.isSuccess, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isSuccess != null)
              isSuccess!
                  ? const Icon(Icons.check_circle, color: Colors.green, size: 40.0)
                  : const Icon(Icons.cancel, color: Colors.red, size: 40.0)
            else
              const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Flexible( // Sử dụng Flexible để Text tự định dạng và xuống dòng khi cần thiết
              child: Text(
                message,
                softWrap: true, // Cho phép xuống dòng tự động
              ),
            ),
          ],
        ),
      ),
    );
  }
}