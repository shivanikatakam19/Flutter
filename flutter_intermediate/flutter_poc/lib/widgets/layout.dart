import 'package:flutter/material.dart';

class LAyout extends StatefulWidget {
  final Widget child;

  const LAyout({super.key, required this.child});

  @override
  State<LAyout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<LAyout>
    with SingleTickerProviderStateMixin {
  bool isSidebarVisible = true;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // sidebar starts off-screen (right)
      end: Offset.zero, // slides in
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void toggleSidebar() {
    setState(() {
      isSidebarVisible = !isSidebarVisible;
      if (isSidebarVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: toggleSidebar, // show/hide sidebar
        ),
      ),
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // Top AppBar
              Container(
                height: 60,
                color: Colors.blueGrey.shade800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "My App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: widget.child),
            ],
          ),

          // Sidebar overlay
          if (isSidebarVisible)
            GestureDetector(
              onTap: toggleSidebar,
              child: Container(color: Colors.black54),
            ),

          // Sidebar (slides from right)
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 250,
                height: double.infinity,
                color: Colors.blueGrey.shade900,
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Hello, Shivani 👋",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Divider(color: Colors.white54),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.white),
                      title: const Text(
                        "Home",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        toggleSidebar();
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.white),
                      title: const Text(
                        "Settings",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        toggleSidebar();
                        Navigator.pushReplacementNamed(context, '/settings');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        toggleSidebar();
                        // handle logout here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
