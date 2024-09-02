// ignore_for_file: prefer_const_constructors

import 'package:event_trace/constants/app_colors.dart';
import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final String dateTime;
  final String title;
  final String location;
  final String image;
  final VoidCallback cardClick;
  final VoidCallback iconClick;

  const EventListItem({
    Key? key,
    required this.dateTime,
    required this.title,
    required this.location,
    required this.image,
    required this.cardClick,
    required this.iconClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cardClick,
      child: Card(
        
        margin: EdgeInsets.all(8.0),
        color: Theme.of(context).colorScheme.background,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.tertiaryContainer,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dateTime,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 14,
                          ),
                        ),
                        InkWell(
                          onTap: iconClick,
                          child: Icon(
                            Icons.bookmark,
                            color: appOrange,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        Flexible(
                          child: Text(
                            location,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
