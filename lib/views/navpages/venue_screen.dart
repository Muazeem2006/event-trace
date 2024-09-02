// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_trace/constants/app_methods.dart';
import 'package:event_trace/controllers/venue_notifier.dart';
import 'package:event_trace/models/User.dart';
import 'package:event_trace/models/Venue.dart';
import 'package:event_trace/services/request.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({Key? key}) : super(key: key);

  @override
  _VenueScreenState createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  String? token;
  User? user;
  bool loading = true;

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  Future<void> fetchVenues(BuildContext context) async {
    final response = await getRequest('venues', null);
    try {
      response.data['venues']
          .map<Venue>((venueJson) => Venue.fromMap(venueJson))
          .where((venue) => !context
              .read<VenueNotifier>()
              .venueList
              .any((c) => c.id == venue.id))
          .forEach((venue) => context.read<VenueNotifier>().addVenue(venue));
    } catch (e) {
      triggerToast(
        context,
        'Failed to fetch venues',
        Colors.red,
        Colors.white,
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final LocalStorage tokenStorage = LocalStorage('token');
    final LocalStorage userStorage = LocalStorage('user');

    var tokenData = tokenStorage.getItem('token');
    if (tokenData != null) {
      token = tokenData.toString();
    }
    var userData = userStorage.getItem('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }

    fetchVenues(context);
  }

  @override
  Widget build(BuildContext context) {
    final VenueNotifier venueNotifier = context.read<VenueNotifier>();
    final List<Venue> venueList = venueNotifier.venueList
        .where((venue) => venue.ownerId == user!.id)
        .toList();
    final venue = venueList.first;
    List<String> venuePhotos = List<String>.from(jsonDecode(venue.photos!));
    List<Widget> carouselItems = venuePhotos.map((url) {
      return Image.network(
        imageUrl(url),
        fit: BoxFit.cover,
        width: double.maxFinite,
      );
    }).toList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : venueList.isEmpty
              ? const Center(child: Text('No Venues Found'))
              : ListView(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: carouselItems,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            venue.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              venue.description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontStyle: FontStyle.italic),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.location_on),
                            title: Text(venue.address!),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.phone),
                            title: Text(venue.phone),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.email),
                            title: Text(venue.email!),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.public),
                            title: Text(venue.website!),
                          ),
                          Text(
                            'Past Events:',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: venue.events!.length,
                            itemBuilder: (context, i) => ListTile(
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(venue.events![i].name, style: Theme.of(context).textTheme.headline6),
                                        const SizedBox(height: 10),
                                        Text(venue.events![i].description!),
                                        const SizedBox(height: 15),
                                        ElevatedButton(
                                          child: const Text('OK'),
                                          onPressed: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl(
                                        venue.events![i].photos!.first!)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(venue.events![i].name),
                              subtitle: Text(dateFormatter(
                                      venue.events![i].dateTime, "d MMMM y") +
                                  '\n' +
                                  dateFormatter(venue.events![i].dateTime,
                                      "EEEE, h:mm a")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
