// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:developer';

import 'package:event_trace/models/Ticket.dart';
import 'package:event_trace/views/addons/payment_screen.dart';
import 'package:event_trace/views/components/detail_screen.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:flutter/material.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({
    super.key,
    required this.widget,
  });

  final DetailScreen widget;

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  int? selectedTicketIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.widget.event.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.widget.event.venue!.name),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Available Tickets - Choose One",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.widget.event.tickets!.length,
            itemBuilder: (context, index) {
              Ticket ticket = widget.widget.event.tickets![index];
              return Card(
                child: RadioListTile(
                  title: Text(ticket.name),
                  subtitle: Text("\$${ticket.price!}"),
                  value: index,
                  groupValue: selectedTicketIndex,
                  onChanged: (int? value) {
                    setState(() {
                      selectedTicketIndex = value;
                      log(widget.widget.event.tickets![value!].price!);
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: DynamicButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PaymentScreen(
                          selectedTicket: widget.widget.event.tickets![selectedTicketIndex!],
                          );
                    },
                  ),
                );
              },
              buttonText: 'Proceed to payment',
            ),
          ),
        ],
      ),
    );
  }
}
