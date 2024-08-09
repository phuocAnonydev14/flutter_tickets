import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';
import 'package:ticket_app/base/utils/all_json.dart';
import 'package:ticket_app/base/utils/app_routes.dart';
import 'package:ticket_app/base/widgets/app_double_text.dart';
import 'package:ticket_app/base/widgets/heading_text.dart';
import 'package:ticket_app/base/widgets/ticket_view.dart';
import 'package:ticket_app/provider/auth_provider.dart';
import 'package:ticket_app/screens/home/widgets/hotel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good morning", style: AppStyles.headLineStyle3),
                        const SizedBox(height: 5),
                        const HeadingText(text: "Book Tickets", isColor: false),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _showDropdownMenu(
                            context, ref, authState.isAuthenticated);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: authState.isAuthenticated
                            ? AssetImage(
                                "https://cdn.rochat.ai/cdn-cgi/image/fit=scale-down,height=480,format=jpeg/https://cdn-az.rochat.tech/avatar/325__8f053b2a-85df-11ee-8ddc-a62b2833b376.jpeg") // replace with user's avatar
                            : AssetImage(
                                "https://cdn.rochat.ai/cdn-cgi/image/fit=scale-down,height=480,format=jpeg/https://cdn-az.rochat.tech/avatar/325__8f053b2a-85df-11ee-8ddc-a62b2833b376.jpeg"), // replace with a default avatar
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF4F6FD),
                  ),
                  child: const Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_search_regular,
                          color: Color(0xFFBFC205)),
                      Text("Search")
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                AppDoubleText(
                  bigText: 'Upcoming Flights',
                  smallText: 'View all',
                  func: () =>
                      Navigator.pushNamed(context, AppRoutes.allTickets),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ticketList
                        .take(2)
                        .map((singleTicket) => GestureDetector(
                            onTap: () {
                              var index = ticketList.indexOf(singleTicket);
                              Navigator.pushNamed(
                                  context, AppRoutes.ticketScreen,
                                  arguments: {"index": index});
                            },
                            child: TicketView(ticket: singleTicket)))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 40),
                AppDoubleText(
                  bigText: 'Hotels',
                  smallText: 'View all',
                  func: () {
                    Navigator.pushNamed(context, AppRoutes.allHotels);
                  },
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: hotelList.take(2).expand((singleHotel) {
                      // Using a List to include gaps
                      return [
                        GestureDetector(
                          onTap: () {
                            var index = hotelList.indexOf(singleHotel);
                            Navigator.pushNamed(context, AppRoutes.hotelDetail,
                                arguments: {"index": index});
                          },
                          child: Hotel(hotel: singleHotel),
                        ),
                        SizedBox(width: 20), // Fixed gap between items
                      ];
                    }).toList()
                      ..removeLast(), // Remove the last SizedBox to avoid trailing space
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDropdownMenu(
      BuildContext context, WidgetRef ref, bool isAuthenticated) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(isAuthenticated ? Icons.logout : Icons.login),
              title: Text(isAuthenticated ? 'Logout' : 'Login'),
              onTap: () {
                Navigator.pop(context); // Close the dropdown menu
                if (isAuthenticated) {
                  // Perform logout action
                  ref.read(authProvider.notifier).logout();
                } else {
                  // Navigate to the login page
                  Navigator.pushNamed(context, AppRoutes.login);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
