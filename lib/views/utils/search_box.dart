// ignore_for_file: prefer__ructors, avoid_print, prefer_const_constructors

import 'dart:developer';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
   const SearchBox({
    super.key,
    required this.controller,
    required this.onTap,
  });

  final TextEditingController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            style:  TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
              fontSize: 20,
            ),
            onEditingComplete: () {
              log(controller.text);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              hintText: 'Search...',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                fontSize: 20,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 28,
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              prefixIconColor: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
         SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: onTap,
          child: Chip(
            backgroundColor: Colors.blue,
            avatar: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.filter_list_sharp,
                  color: Theme.of(context).colorScheme.primary,
                )),
            label:  Text(
              "Filter",
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
          ),
        )
      ],
    );
  }
}
