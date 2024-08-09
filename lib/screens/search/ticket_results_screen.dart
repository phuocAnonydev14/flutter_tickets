import 'package:flutter/material.dart';
import 'package:ticket_app/base/widgets/ticket_view.dart';

class TicketResultsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> tickets;

  const TicketResultsScreen({super.key, required this.tickets});

  @override
  State<TicketResultsScreen> createState() => _TicketResultsScreenState();
}

class _TicketResultsScreenState extends State<TicketResultsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a fake loading time of 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket results"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.tickets.isEmpty
              ? const Center(
                  child: Text(
                    "No items available",
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.tickets.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12.0),
                  itemBuilder: (context, index) {
                    return TicketView(
                      ticket: widget.tickets[index],
                      wholeScreen: true,
                    );
                  },
                ),
    );
  }
}
