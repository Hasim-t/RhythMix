import 'package:flutter/material.dart';
import 'package:rhythmix/screens/favorite_page.dart';
import 'package:rhythmix/screens/recetly_played.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Map<String, dynamic>> items = [
    {'name': 'Favorite', 'image': 'asset/favarite icon.png'},
    {'name': 'Recent play', 'image': 'asset/recently1.png'},
  ];

  GlobalKey<_LibraryState> libraryKey = GlobalKey<_LibraryState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
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
                return InkWell(
                  onTap: () {
                    if (items[index]['name'] == 'Favorite') {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return FavoritePage();
                      }));
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return RecetlyPlayed();
                      }));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(130, 53, 102, 186),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            items[index]['image'],
                            fit: BoxFit.fill,
                          )),
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
                    items.add({
                      'name': newItemName,
                      'image': 'asset/recorder.jpg',
                    });
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
