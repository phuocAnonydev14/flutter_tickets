import 'package:flutter/material.dart';
import 'package:ticket_app/base/utils/all_json.dart';
import 'package:ticket_app/base/utils/app_routes.dart';
import 'package:ticket_app/base/widgets/ticket_view.dart';
import 'package:ticket_app/screens/home/widgets/hotel.dart';

class HotelResultsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> hotels;

  const HotelResultsScreen({super.key, required this.hotels});

  @override
  State<HotelResultsScreen> createState() => _HotelResultsScreenState();
}

class _HotelResultsScreenState extends State<HotelResultsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a fake loading time of 3 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Results"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.hotels.isEmpty
              ? const Center(
                  child: Text(
                    "No items available",
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.hotels.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        var hotelIndex =
                            hotelList.indexOf(widget.hotels[index]);
                        Navigator.pushNamed(context, AppRoutes.hotelDetail,
                            arguments: {"index": hotelIndex});
                      },
                      child: Hotel(
                        hotel: widget.hotels[index],
                      ),
                    );
                  },
                ),
    );
  }
}
