import 'package:flutter/material.dart';
import 'package:siyar_flex/screens/movies/movies.dart';
import 'package:siyar_flex/screens/movies/movies_popular.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Home')),
    MoviePopular(),
    Center(child: Text('Series')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Close the drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SiyarFlix'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: const Text('Series'),
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
