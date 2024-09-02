import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventFaqs extends StatefulWidget {
  const EventFaqs({
    Key? key,
  }) : super(key: key);

  @override
  _EventFaqsState createState() => _EventFaqsState();
}

class _EventFaqsState extends State<EventFaqs> {
  @override
  Widget build(BuildContext context) {
    final eventSlug = Provider.of<EventNotifier>(context, listen: false).slug;
    return Column(
      children: [
        Text(eventSlug),
        DynamicButton(
          buttonText: 'Attach FAQs',
          onTap: () {},
        )
      ],
    );
  }
}
