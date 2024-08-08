import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_app/base/widgets/ticket_view.dart';
import 'package:ticket_app/models/Ticket.dart';

class TicketResultsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tickets;

  const TicketResultsScreen({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket results"),
      ),
      body: tickets.isEmpty
          ? const Center(
              child: Text(
                "No items available",
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0), // Gap between items
              itemBuilder: (context, index) {
                return TicketView(
                  ticket: tickets[index],
                  wholeScreen: true,
                );
              }),
    );
  }
}
