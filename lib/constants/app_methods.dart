// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:developer';

import 'package:event_trace/services/request.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void triggerToast(
    BuildContext context, String msg, Color backgroundColor, Color textColor,
    [dynamic position]) {
  return FlutterToastr.show(
    msg,
    context,
    duration: FlutterToastr.lengthLong,
    position: position ?? FlutterToastr.bottom,
    backgroundColor: backgroundColor,
    textStyle: TextStyle(color: textColor, fontSize: 16),
  );
}

dateFormatter(DateTime dateTime, String format) {
  return DateFormat(format).format(dateTime);
}

imageUrl(dynamic image) {
  return ("$url/$image");
}

String truncateSentence(String input, int limit) {
  List<String> words = input.split(' ');
  String result = '';
  int count = 0;
  for (String word in words) {
    if (count < limit) {
      result += ' $word';
      count += 1;
    } else {
      break;
    }
  }
  return '${result.trim()}...';
}

String generateSlug(String title) {
  final slug = title
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'(^-|-$)'), '');
  return slug;
}
String roleSlug(String title) {
  final slug = title
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'(^-|-$)'), '');
  return slug;
}

Future<String> selectDateTime(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(picked),
    );
    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        picked.year,
        picked.month,
        picked.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      return selectedDateTime.toIso8601String();
    }
  }
  return '';
}

Future<dynamic> sendFormData(BuildContext context, String url,
    [dynamic data, Map<String, dynamic>? headers]) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  try {
    final response = await postRequest(
      url,
      data,
      headers,
    );
    log(url);
    Navigator.pop(context);
    return response.data;
  } catch (e) {
    // Handle network or server error
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Error'),
        content: Text(
            'An error occurred. Please check your internet connection and try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
    Navigator.pop(context);
    return null;
  }
}
