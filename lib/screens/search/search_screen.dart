import 'package:flutter/material.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';
import 'package:ticket_app/base/utils/all_json.dart';
import 'package:ticket_app/base/utils/app_routes.dart';
import 'package:ticket_app/base/widgets/app_double_text.dart';
import 'package:ticket_app/models/Ticket.dart';
import 'package:ticket_app/screens/search/ticket_results_screen.dart';
import 'package:ticket_app/screens/search/widgets/app_text_icon.dart';
import 'package:ticket_app/screens/search/widgets/app_ticket_tabs.dart';
import 'package:ticket_app/screens/search/widgets/find_tickets.dart';
import 'package:ticket_app/screens/search/widgets/ticket_promotion.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? departureTime;
  Place? arrival;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != departureTime) {
      setState(() {
        departureTime =
            "${picked.format(context)} ${picked.period.name.toUpperCase()}";
      });
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: placeList.map((item) {
            final place = Place.fromJson(item);
            return ListTile(
              title: Text("${place.name} (${place.code})"),
              onTap: () {
                setState(() {
                  arrival = place;
                });
                Navigator.pop(context); // Close the bottom sheet
              },
            );
          }).toList(),
        );
      },
    );
  }

  void handleSearch() {
    var filteredTickets = ticketList.where((ticket) {
      return ticket['departure_time'] == departureTime ||
          ticket['to']['code'] == arrival?.code;
    }).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TicketResultsScreen(
                tickets: filteredTickets,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            "What are\nyou looking for?",
            style: AppStyles.headLineStyle1.copyWith(fontSize: 35),
          ),
          const SizedBox(
            height: 20,
          ),
          const AppTicketTabs(
            firstTab: "All Tickets",
            secondTab: "Hotels",
          ),
          const SizedBox(
            height: 25,
          ),
          AppTextIcon(
              icon: Icons.flight_takeoff_rounded,
              text: departureTime != null ? departureTime! : "Departure",
              onTap: () {
                _selectTime(context);
              }),
          const SizedBox(
            height: 20,
          ),
          AppTextIcon(
            icon: Icons.flight_land_rounded,
            text: arrival != null
                ? "${arrival?.name} (${arrival?.code})"
                : "Arrival",
            onTap: () {
              _showPicker(context);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          FindTickets(
            onTap: () {
              handleSearch();
            },
          ),
          const SizedBox(
            height: 40,
          ),
          AppDoubleText(
            bigText: 'Upcoming Flights',
            smallText: 'View all',
            func: () => Navigator.pushNamed(context, AppRoutes.allTickets),
          ),
          const SizedBox(
            height: 15,
          ),
          const TicketPromotion(),
        ],
      ),
    );
  }
}
