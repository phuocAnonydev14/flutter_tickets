import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';
import 'package:ticket_app/base/utils/app_routes.dart';
import 'package:ticket_app/base/widgets/app_double_text.dart';
import 'package:ticket_app/base/widgets/heading_text.dart';
import 'package:ticket_app/base/widgets/ticket_view.dart';
import 'package:ticket_app/provider/auth_provider.dart';
import 'package:ticket_app/provider/flight_provider.dart';
import 'package:ticket_app/provider/hotel_provider.dart';
import 'package:ticket_app/screens/home/widgets/hotel.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final ticketListAsyncValue = ref.watch(ticketListProvider);
    final hotelListAsyncValue = ref.watch(hotelListProvider);

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
                        _showDropdownMenu(context, ref, authState.isAuthenticated);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: authState.isAuthenticated
                            ? NetworkImage("data:image/png;base64,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")
                            : NetworkImage("https://cdn.rochat.ai/cdn-cgi/image/fit=scale-down,height=480,format=jpeg/https://cdn-az.rochat.tech/avatar/325__8f053b2a-85df-11ee-8ddc-a62b2833b376.jpeg"), // replace with a default avatar
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                ticketListAsyncValue.when(
                  data: (tickets) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tickets
                          .take(2)
                          .map((singleTicket) => GestureDetector(
                          onTap: () {
                            var index = tickets.indexOf(singleTicket);
                            Navigator.pushNamed(
                                context, AppRoutes.ticketScreen,
                                arguments: {"index": index});
                          },
                          child: TicketView(ticket: singleTicket)))
                          .toList(),
                    ),
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
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
                hotelListAsyncValue.when(data:
                (tickets) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: tickets
                        .take(2)
                        .map((singleHotel) => GestureDetector(
                        onTap: (){
                          var index = tickets.indexOf(singleHotel);
                          Navigator.pushNamed(context, AppRoutes.hotelDetail, arguments: {
                            "index":index
                          });
                        },
                        child: Hotel(hotel: singleHotel)))
                        .toList(),
                  ),
                ), error: (error, stack) => Center(child: Text('Error: $error')), loading: () => Center(child: CircularProgressIndicator()))
                ,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDropdownMenu(BuildContext context, WidgetRef ref, bool isAuthenticated) {
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
