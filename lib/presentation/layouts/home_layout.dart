import 'package:flutter/material.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_navbar.dart';
import 'package:trauma_register_frontend/presentation/widgets/custom_sidebar.dart';

class HomeLayout extends StatefulWidget {
  final Widget child;
  const HomeLayout({
    super.key,
    required this.child,
  });

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  bool _isSidebarExpanded = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSidebar(
            isExpanded: _isSidebarExpanded,
            onToggle: _toggleSidebar,
          ),
          Expanded(
            child: Column(
              children: [
                const CustomNavbar(),
                Expanded(
                  child: Container(
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
