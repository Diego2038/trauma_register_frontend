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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _determineIsSidebarExpandValue();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800;

    return Scaffold(
      key: _scaffoldKey,
      body: isMobile ? mobileContent(screenWidth, screenHeight) : webContent(),
      drawer: isMobile
          ? CustomSidebar(
              isExpanded: true,
              onToggle: () => _scaffoldKey.currentState?.closeDrawer(),
              contractWithTap: true,
            )
          : null,
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
    return Column(
      children: [
        CustomNavbar(
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer()),
        Expanded(
          child: Container(
            child: widget.child,
          ),
        ),
      ],
    );
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  void _determineIsSidebarExpandValue() {
    final size = MediaQuery.of(context).size;
    final bool isMobileView = size.width < 800;
    _isSidebarExpanded = !isMobileView;
  }
}
