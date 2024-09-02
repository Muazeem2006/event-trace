// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:custom_input_text/custom_input_text.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/category_notifier.dart';
import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/controllers/venue_notifier.dart';
import 'package:event_trace/models/Category.dart';
import 'package:event_trace/models/Event.dart';
import 'package:event_trace/models/Venue.dart';
import 'package:event_trace/views/utils/custom_input.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  String? token;

  final LocalStorage tokenStorage = LocalStorage('token');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController guestCountController = TextEditingController();
  String? categoryValue;
  String? venueValue;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    guestCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<CategoryNotifier>(context).categoryList;
    List<String> categoryCollection =
        categoryList.map((e) => e.name).toList().reversed.toList();

    // venue collection
    List<Venue> venueList =
        Provider.of<VenueNotifier>(context).venueList.reversed.toList();

    List<String> venueCollection = venueList
        .where((venue) =>
            guestCountController.text.trim().isNotEmpty &&
            int.parse(venue.capacity) >=
                int.parse(guestCountController.text.trim()))
        .map((venue) => venue.name)
        .toList();
    List<Venue> matchedVenues = venueList
        .where((venue) =>
            guestCountController.text.trim().isNotEmpty &&
            int.parse(venue.capacity) >=
                int.parse(guestCountController.text.trim()))
        .toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: [
          // event name
          CustomInputText(
            textController: nameController,
            keyboardType: TextInputType.text,
            placeholder: 'Event name',
            onfocusColor: Theme.of(context).colorScheme.primary,
            icon: Icons.title,
          ),
          const SizedBox(
            height: 20.0,
          ),
          // event description
          CustomInput(
            controller: descriptionController,
            keyboardType: TextInputType.multiline,
            labelText: 'Event Description',
            hintText: 'Event description',
            prefixIcon: const Icon(Icons.description),
            maxLines: 10,
          ),
          const SizedBox(
            height: 20.0,
          ),
          // event category selection
          CustomDropdown(
            decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: Colors.black38),
              closedBorderRadius: BorderRadius.circular(30),
            ),
            hintText: 'Select event category',
            items: categoryCollection,
            onChanged: (value) {
              setState(() {
                categoryValue = value;
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          // guest count
          CustomInputText(
            textController: guestCountController,
            keyboardType: TextInputType.number,
            placeholder: 'Numbers of Expected guests',
            onfocusColor: Theme.of(context).colorScheme.primary,
            icon: Icons.group,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                setState(() {
                  venueCollection = venueList
                      .where((venue) =>
                          int.parse(venue.capacity) >= int.parse(value.trim()))
                      .map((venue) => venue.name)
                      .toList();
                });
              }
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          // venue selection
          CustomDropdown(
              decoration: CustomDropdownDecoration(
                closedBorder: Border.all(color: Colors.black38),
                closedBorderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Select event venue',
              items: venueCollection,
              onChanged: (value) {
                setState(() {
                  venueValue = value;
                });
              }),
          const SizedBox(
            height: 20.0,
          ),
          //  date & time
          CustomInput(
              controller: dateTimeController,
              keyboardType: TextInputType.text,
              labelText: 'Date & Time',
              hintText: 'Enter date & time',
              prefixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                String? selectedDateTime = await selectDateTime(context);
                setState(() {
                  dateTimeController.text = selectedDateTime;
                });
              }),
          const SizedBox(
            height: 20.0,
          ),
          // available venues display
          (matchedVenues.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Available Venues",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ...matchedVenues
                        .map((venue) => ListTile(
                              // leading: const Icon(Icons.location_on),
                              leading: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        'https://picsum.photos/seed/picsum/200'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(venue.name),
                              subtitle: Text(venue.address!),
                              trailing: Text('${venue.capacity} capacity'),
                              onTap: () {
                                setState(() {
                                  venueValue = venue.name;
                                });
                              },
                            ))
                        .toList(),
                  ],
                )
              : const Text("No venues available"),
          const SizedBox(
            height: 20.0,
          ),
          DynamicButton(
            onTap: () {
              // Ensure that the form fields are filled correctly
              if (nameController.text.trim().isEmpty ||
                  descriptionController.text.trim().isEmpty ||
                  categoryValue == null ||
                  guestCountController.text.trim().isEmpty ||
                  venueValue == null ||
                  dateTimeController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please fill in all required fields",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Process the form submission
              log("Event name: ${nameController.text.trim()}");
              log("Event description: ${descriptionController.text.trim()}");
              log("Event category: $categoryValue");
              log("Guest count: ${guestCountController.text.trim()}");
              log("Event venue: $venueValue");
              log("Date & Time: ${dateTimeController.text.trim()}");
              // Do something with the data...
              _createEvent();
            },
            buttonText: "Submit",
          ),
        ],
      ),
    );
  }

  void _createEvent() {
    String name = nameController.text.trim();
    String description = descriptionController.text.trim();
    DateTime dateTime = DateTime.parse(dateTimeController.text.trim());
    String guestCount = guestCountController.text.trim();
    String slug = generateSlug(name);
    var categoryCollection =
        Provider.of<CategoryNotifier>(context, listen: false)
            .categoryList
            .reversed
            .toList();
    Category category =
        categoryCollection.firstWhere((el) => el.name == categoryValue);
    int categoryId = category.id!;
    var venueCollection = Provider.of<VenueNotifier>(context, listen: false)
        .venueList
        .reversed
        .toList();
    Venue venue = venueCollection.firstWhere((el) => el.name == venueValue);
    int venueId = venue.id!;

    Event event = Event(
      name: name,
      slug: slug,
      description: description,
      guestCount: guestCount,
      venue: venue,
      venueId: venueId,
      category: category,
      categoryId: categoryId,
      dateTime: dateTime,
    );

    createEvent(event, context);
  }

  Future<void> createEvent(Event event, BuildContext context) async {
    try {
      final response = await sendFormData(
        context,
        'events',
        event.toMap(),
        {
          'Authorization': 'Bearer ${tokenStorage.getItem('token')}',
        },
      );

      if (response != null) {
        final event = Event.fromMap(response['event']);
        context.read<EventNotifier>().setSlug(event.slug);
        context.read<EventNotifier>().addEvent(event);
        Navigator.pushNamed(context, '/add_images');
      } else {
        // Handle the error response
        log('Failed to create event: ${response?.statusCode}');
        // Show error message to the user
        triggerToast(
            context, 'Failed to create event', Colors.red, Colors.white);
      }
    } catch (e) {
      // Handle exceptions
      log('Error during event creation: $e');
      triggerToast(context, 'An error occurred while creating event',
          Colors.red, Colors.white);
    }
  }
}
