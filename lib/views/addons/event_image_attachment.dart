// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:developer'; 

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_trace/models/Event.dart';
import 'package:event_trace/views/navpages/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/constants/file_upload.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';

class EventImageAttachment extends StatefulWidget {
  const EventImageAttachment({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  _EventImageAttachmentState createState() => _EventImageAttachmentState();
}

class _EventImageAttachmentState extends State<EventImageAttachment> {
  List<File>? images;

  String? token;

  final LocalStorage tokenStorage = LocalStorage('token');

  Future<void> attachPhotos(List<File>? images, BuildContext context) async {
    try {
      // Create a FormData object and add the image files to it

      if (images!.isEmpty) return;
      FormData formData = FormData.fromMap({
        "app": "event_trace",
        'date': DateTime.now().toIso8601String(),
      });

      for (File image in images) {
        formData.files.addAll(
            [MapEntry('photos[]', await MultipartFile.fromFile(image.path))]);
      }

      final response = await sendFormData(
        context,
        'events/${widget.event.slug}/photos',
        formData,
        {
          'Authorization': 'Bearer ${tokenStorage.getItem('token')}',
        },
      );

      // Check the response status
      if (response != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const EventsScreen();
          }),
        );
      } else {
        // Handle the error response
        log('Failed to upload images: ${response?.statusCode}');
        // Show error message to the user
        triggerToast(
          context,
          'Failed to upload images',
          Colors.red,
          Colors.white,
        );
      }
    } catch (e) {
      // Handle exceptions
      log('Error during image upload: $e');
      triggerToast(
        context,
        'An error occurred while uploading images',
        Colors.red,
        Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'Attach Image to Event',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    selectImages((p0) {
                      setState(() {
                        images = p0;
                      });
                    });
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('From Gallery'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: appBlue,
                    foregroundColor: Colors.white,
                    shadowColor: appBlue,
                  ),
                ),
                const SizedBox(width: 30.0),
                ElevatedButton.icon(
                  onPressed: () {
                    takeImages((p0) {
                      setState(() {
                        images = p0;
                      });
                    });
                  },
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Take Picture'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: appBlue,
                    foregroundColor: Colors.white,
                    shadowColor: appBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            if (images == null || images!.isEmpty)
              Container(
                height: 150.0,
                width: 200.0,
                color: Colors.orange[300],
                child: const Center(
                  child: Text(
                    'Image Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            else
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: const EdgeInsets.all(8),
                children: List.generate(
                  images!.length,
                  (index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(images![index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 30.0),
            DynamicButton(
              buttonText: 'Attach Images',
              onTap: () {
                if (images == null || images!.isEmpty) {
                  triggerToast(
                    context,
                    'Please select an image',
                    Colors.red,
                    Colors.white,
                  );
                  return;
                }
                attachPhotos(images, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
