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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return Scaffold(
      body: isMobile ? mobileContent(screenWidth, screenHeight) : webContent(),
    );
  }

  Widget webContent() {
    return Row(
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
    );
  }

  Widget mobileContent(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Main content
        Positioned.fill(
          child: Column(
            children: [
              CustomNavbar(onMenuTap: _toggleSidebar),
              Expanded(
                child: Container(
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),

        // Opaque background
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: 0,
          bottom: 0,
          left: _isSidebarExpanded ? 0 : -screenWidth,
          width: screenWidth,
          curve: Curves.easeInOutExpo,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOutExpo,
            opacity: _isSidebarExpanded ? 0.5 : 0.0,
            child: GestureDetector(
              onTap: _toggleSidebar,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
        ),

        // Animated Sidebar
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: _isSidebarExpanded ? 0 : -screenWidth * 0.7,
          width: screenWidth * 0.7,
          child: CustomSidebar(
            isExpanded: true,
            onToggle: _toggleSidebar,
            contractWithTap: true,
          ),
        ),
      ],
    );
  }
}
