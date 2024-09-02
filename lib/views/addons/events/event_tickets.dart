// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/models/Event.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class EventTickets extends StatefulWidget {
  const EventTickets({
    Key? key,
  }) : super(key: key);

  @override
  _EventTicketsState createState() => _EventTicketsState();
}

class _EventTicketsState extends State<EventTickets> {
  final _formKey = GlobalKey<FormState>();
  final LocalStorage tokenStorage = LocalStorage('token');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _salesStartController = TextEditingController();
  final TextEditingController _salesEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final eventSlug = Provider.of<EventNotifier>(context).slug;
    log(eventSlug);
    List<Event> eventList = Provider.of<EventNotifier>(context, listen: false).eventList;
    log(eventList.first.name);
    Event event = eventList.firstWhere((el) => el.slug == eventSlug);
    // List<Ticket> ticketList = event.tickets!;
    // return Scaffold(
    //   appBar: AppBar(
    //       title: const Text('Event Tickets'),
    //       centerTitle: true,
    //       backgroundColor: Theme.of(context).colorScheme.inversePrimary),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.all(20),
    //     child: Column(
    //       children: [
    //         const Text('Event Tickets'),
    //         if (ticketList.isNotEmpty)
    //           ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: ticketList.length,
    //             itemBuilder: (context, index) {
    //               Ticket ticket = ticketList[index];
    //               return Card(
    //                 elevation: 5,
    //                 child: ListTile(
    //                   onTap: () {},
    //                   leading: Icon(Icons.local_activity,
    //                       size: 32,
    //                       color: Theme.of(context).colorScheme.primary),
    //                   title: Text(ticket.name),
    //                   subtitle: Text(ticket.description!),
    //                   trailing: Text('\$${ticket.price}'),
    //                 ),
    //               );
    //             },
    //           ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Theme.of(context).colorScheme.primary,
    //     foregroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     onPressed: () => triggerTicketDialog(context, event),
    //     child: const Icon(Icons.add),
    //   ),
    // );
    return Scaffold(
      body: Text(eventSlug),
    );
  }

  // void triggerTicketDialog(BuildContext context, Event event) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       content: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextFormField(
  //               controller: _nameController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Ticket name',
  //                 hintText: 'Enter ticket name',
  //               ),
  //               keyboardType: TextInputType.name,
  //             ),
  //             TextFormField(
  //               controller: _descriptionController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Ticket description',
  //                 hintText: 'Enter ticket description',
  //               ),
  //               keyboardType: TextInputType.name,
  //             ),
  //             TextFormField(
  //               controller: _priceController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Ticket price',
  //                 hintText: 'Enter ticket price',
  //               ),
  //               keyboardType: TextInputType.number,
  //             ),
  //             TextFormField(
  //               controller: _quantityController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Quantity',
  //                 hintText: 'Enter quantity',
  //               ),
  //               keyboardType: TextInputType.number,
  //             ),
  //             TextFormField(
  //                 controller: _salesStartController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Sales start',
  //                   hintText: 'Enter sales start date-time',
  //                 ),
  //                 keyboardType: TextInputType.none,
  //                 onTap: () async {
  //                   String? selectedDateTime = await selectDateTime(context);
  //                   setState(() {
  //                     _salesStartController.text = selectedDateTime;
  //                   });
  //                 }),
  //             TextFormField(
  //               controller: _salesEndController,
  //               decoration: const InputDecoration(
  //                 labelText: 'Sales end',
  //                 hintText: 'Enter sales end date-time',
  //               ),
  //               keyboardType: TextInputType.none,
  //               onTap: () async {
  //                 String? selectedDateTime = await selectDateTime(context);
  //                 setState(() {
  //                   _salesEndController.text = selectedDateTime;
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Theme.of(context).colorScheme.primary,
  //             foregroundColor: Theme.of(context).colorScheme.inversePrimary,
  //             shape: const StadiumBorder(),
  //           ),
  //           onPressed: () {
  //             _createTicket(event);
  //           },
  //           child: const Text('Submit'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _createTicket(Event event) {
  //   String name = _nameController.text.trim();
  //   String description = _descriptionController.text.trim();
  //   String price = _priceController.text.trim();
  //   String quantity = _quantityController.text.trim();
  //   String salesStart = _salesStartController.text.trim();
  //   String salesEnd = _salesEndController.text.trim();
  //   Ticket ticket = Ticket(
  //     name: name,
  //     description: description,
  //     quantity: int.parse(quantity),
  //     eventId: event.id!,
  //     price: price,
  //     salesStart: DateTime.parse(salesStart),
  //     salesEnd: DateTime.parse(salesEnd),
  //   );
  //   String slug = event.slug;
  //   _nameController.clear();
  //   _descriptionController.clear();
  //   _priceController.clear();
  //   _quantityController.clear();
  //   _salesStartController.clear();
  //   _salesEndController.clear();
  //   createTicket(ticket, context, slug);
  // }

  // Future<void> createTicket(
  //     Ticket ticket, BuildContext context, String slug) async {
  //   try {
  //     final response = await sendFormData(
  //       context,
  //       'events/$slug/tickets',
  //       ticket.toMap(),
  //       {
  //         'Authorization': 'Bearer ${tokenStorage.getItem('token')}',
  //       },
  //     );

  //     if (response != null) {
  //       final ticket = Ticket.fromMap(response['ticket']);
  //       context.read<TicketNotifier>().addTicket(ticket);
  //         Navigator.pushNamed(context, '/add_faq');
  //     } else {
  //       // Handle the error response
  //       log('Failed to create event: ${response?.statusCode}');
  //       // Show error message to the user
  //       triggerToast(
  //         context,
  //         'Failed to create event',
  //         Colors.red,
  //         Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     log('Error during event creation: $e');
  //     triggerToast(context, 'An error occurred while creating event',
  //         Colors.red, Colors.white);
  //   }
  // }


}
