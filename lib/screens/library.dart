import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Map<String, dynamic>> items = [
    {'name': 'Favorite', 'icon': Icons.favorite},
    {'name': 'Recent play', 'icon': Icons.access_time},
  ];

  GlobalKey<_LibraryState> libraryKey = GlobalKey<_LibraryState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(screenWidth*0.05),
          child: GridView.builder(
            key: libraryKey,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == items.length) {
                return InkWell(
                  onTap: () {
                    showAddItemDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(130, 53, 102, 186),
                      ),
                      child: Center(
                        child: Icon(Icons.add, size: 40),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(130, 53, 102, 186),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(items[index]['name'], style: TextStyle(fontSize: 20)),
        ),
        if (items[index]['icon'] != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(items[index]['icon'], size: 40),
          ),
      ],
    ),
  ),
);

              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> showAddItemDialog(BuildContext context) async {
    String newItemName = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Playlist'),
          content: TextField(
            onChanged: (value) {
              newItemName = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter playlist name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newItemName.isNotEmpty) {
                  setState(() {
                    items.add({'name': newItemName});
                  });
       
                  libraryKey.currentState?.setState(() {});
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
