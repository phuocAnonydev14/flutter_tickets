import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_app/base/bottom_nav_bar.dart';
import 'package:ticket_app/base/utils/app_routes.dart';
import 'package:ticket_app/provider/auth_provider.dart';
import 'package:ticket_app/screens/home/all_hotels.dart';
import 'package:ticket_app/screens/home/all_tickets.dart';
import 'package:ticket_app/screens/hotel_detail.dart';
import 'package:ticket_app/screens/ticket/ticket_screen.dart';
import 'package:ticket_app/screens/auth/login.dart';
import 'package:ticket_app/screens/auth/register.dart';

import 'bloc/bottom_nav_bloc.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return BlocProvider(
      create: (_) => BottomNavBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.register: (context) => RegistrationPage(),
          AppRoutes.homePage: (context) => BottomNavBar(),
          AppRoutes.login: (context) => LoginPage(),
          AppRoutes.allTickets: (context) => const AllTickets(),
          AppRoutes.ticketScreen: (context) => const TicketScreen(),
          AppRoutes.allHotels: (context) => const AllHotels(),
          AppRoutes.hotelDetail: (context) => const HotelDetail(),
        },
      ),
    );
  }
}
