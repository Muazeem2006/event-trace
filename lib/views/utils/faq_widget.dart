import 'package:flutter/material.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> faqs = [
      {
        "question": "What time does the concert start?",
        "answer": "The concert starts at 7:00 PM. Doors open at 6:30 PM."
      },
      {
        "question": "Is there parking available at the concert venue?",
        "answer":
            "Yes, there is ample parking available at the venue. Attendees can park in the designated parking lots."
      },
      {
        "question": "Are food and drinks allowed inside the concert hall?",
        "answer":
            "Outside food and drinks are not allowed inside the concert hall. However, there will be food and beverage vendors available at the venue."
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        faqs.length,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(30),
          ),
          child: ExpansionTile(
            title: Text(faqs[index]['question']!),
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(faqs[index]['answer']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
