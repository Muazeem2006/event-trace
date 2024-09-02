// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/models/Event.dart';
import 'package:event_trace/views/components/book_ticket.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:event_trace/views/utils/organizer_column.dart';
import 'package:event_trace/views/utils/user_avatar.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    Key? key,
    required this.event,
  }) : super(key: key);
  final Event event;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Map<String, dynamic>> ticketData = [
    {
      "name": "Regular",
      "price": 100,
      "quantity": "1",
      "description": "This is a regular ticket",
    },
    {
      "name": "VIP",
      "price": 200,
      "quantity": "1",
      "description": "This is a VIP ticket",
    },
    {
      "name": "VVIP",
      "price": 300,
      "quantity": "1",
      "description": "This is a VVIP ticket",
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Event Details",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Column(
            children: [
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {
                    log("Bookmark Pressed");
                  },
                  icon: Icon(Icons.bookmark,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 230,
              ),
              Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  image: DecorationImage(
                    image: widget.event.photos!.isNotEmpty
                        ? NetworkImage(imageUrl(widget.event.photos!.last))
                        : NetworkImage("https://picsum.photos/seed/picsum/200"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 90),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.event,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dateFormatter(
                                      widget.event.dateTime, "d MMMM y"),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  dateFormatter(
                                      widget.event.dateTime, "EEEE, h:mm a"),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 170,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserAvatar(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "+20 Going",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        shape: StadiumBorder(),
                      ),
                      child: Text("Invite"),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      bottom: 50.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 250,
                        child: Text(
                          widget.event.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.location_pin,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.event.venue!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.7,
                            child: Text(
                              widget.event.venue!.address!,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  OrganizerColumn(
                    name: widget.event.organizer!.name!,
                    onTap: () {},
                    image: widget.event.organizer?.photo == null
                        ? 'https://picsum.photos/200'
                        : imageUrl(widget.event.organizer!.photo),
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Event",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: truncateSentence(
                                  widget.event.description!, 24),
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            TextSpan(
                              text: ' Read More',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.event.faqs!.isNotEmpty)
                    Column(
                      children: List.generate(
                        widget.event.faqs!.first.questions.length,
                        (index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                            child: ExpansionTile(
                              title: Text(
                                  widget.event.faqs!.first.questions[index]),
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                      widget.event.faqs!.first.answers[index]),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  else
                    (Text('No FAQs')),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 20.0,
          left: 40.0,
          right: 40.0,
        ),
        child: DynamicButton(
          buttonText: "Book Ticket",
          onTap: () {
            _showBookTicketDialog(context);
          },
        ),
      ),
    );
  }

  void _showBookTicketDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          content: BookTicket(
            widget: widget,
          ),
        );
      },
    );
  }
}
