import 'package:flutter/material.dart';
import 'package:ticket_app/base/res/styles/app_styles.dart';

class AppTicketTabs extends StatefulWidget {
  final Function(int)? onChange;
  final String firstTab;
  final String secondTab;
  const AppTicketTabs(
      {super.key,
      required this.firstTab,
      required this.secondTab,
      this.onChange});

  @override
  State<AppTicketTabs> createState() => _AppTicketTabsState();
}

class _AppTicketTabsState extends State<AppTicketTabs> {
  int index = 0;

  void onTap(int tab) {
    setState(() {
      index = tab;
    });
    if (widget.onChange != null) {
      widget.onChange!(tab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppStyles.ticketTabColor),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: AppTabs(
            tabText: widget.firstTab,
            tabBorder: index == 0,
            tabColor: index == 0,
            onTap: () => onTap(0),
          ),
        ),
        Expanded(
          flex: 1,
          child: AppTabs(
            tabText: widget.secondTab,
            tabBorder: index == 1,
            tabColor: index == 1,
            onTap: () => onTap(1),
          ),
        )
      ]),
    );
  }
}

class AppTabs extends StatelessWidget {
  const AppTabs(
      {super.key,
      this.tabText = "",
      this.tabBorder = false,
      this.tabColor = false,
      this.onTap});

  final String tabText;
  final bool tabBorder;
  final bool tabColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: tabColor == false ? Colors.transparent : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Center(child: Text(tabText)),
      ),
    );
  }
}
