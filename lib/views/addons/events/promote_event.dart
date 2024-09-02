import 'package:event_trace/controllers/event_notifier.dart';
import 'package:event_trace/views/utils/dynamic_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoteEvent extends StatelessWidget {
  const PromoteEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventSlug = Provider.of<EventNotifier>(context, listen: false).slug;
    return Column(
      children: [
        Text(eventSlug),
        DynamicButton(
          buttonText: 'Promote Event',
          onTap: () {},
        )
      ],
    );
  }
}
