import 'package:flutter/material.dart';
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
            child: Container(
              color: Colors.white,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
