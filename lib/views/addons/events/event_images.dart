// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:developer';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:event_trace/constants/app_colors.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/constants/file_upload.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:provider/provider.dart';

class EventImages extends StatefulWidget {
  const EventImages({Key? key}) : super(key: key);

  @override
  _EventImagesState createState() => _EventImagesState();
}

class _EventImagesState extends State<EventImages> {
  List<File>? images;

  String? token;

  final LocalStorage tokenStorage = LocalStorage('token');

  String get eventSlug =>
      Provider.of<EventNotifier>(context, listen: false).slug;

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
        'events/$eventSlug/photos',
        formData,
        {
          'Authorization': 'Bearer ${tokenStorage.getItem('token')}',
        },
      );

      // Check the response status
      if (response != null) {
        final event = Event.fromMap(response['event']);
        context.read<EventNotifier>().updateEvent(event);
        Navigator.pushNamed(context, '/add_ticket');
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
        title: const Text('Event Images'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 70.0,
                    color: Theme.of(context).colorScheme.inversePrimary,
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
