import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:rhythmix/database/function/db_playlist.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/screens/favorite_page.dart';
import 'package:rhythmix/screens/recetly_played.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Map<String, dynamic>> items = [
    {'name': 'Favorite', 'image': 'asset/favariteicon.png'},
    {'name': 'Recently Played', 'image': 'asset/recently1.png'},
  ];

  GlobalKey<_LibraryState> libraryKey = GlobalKey<_LibraryState>();

  @override
  void initState() {
    super.initState();
    loadItemsFromHive();
  }

  Future<void> loadItemsFromHive() async {
    final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
    setState(() {
      // Remove the first two items if already present
      if (items.length >= 2) {
        items.removeRange(2, items.length);
      }

      // Add items from Hive
      items.addAll(playlistBox.values.map((playlist) {
        return {'name': playlist.name, 'image': 'asset/playlist.jpeg'};
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Library",
                    style: GoogleFonts.grapeNuts(
                      textStyle: TextStyle(fontSize: 34),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, size: 40),
                    onPressed: () {
                      showAddItemDialog(context);
                    },
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  key: libraryKey,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigateToPage(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(130, 53, 102, 186),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  items[index]['image'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: (index >= 2)
                                    ? IconButton(
                                        onPressed: () {
                                          // Handle icon button tap as needed
                                        },
                                        icon: Icon(
                                          Icons.more_vert_rounded,
                                          color: Colors.white,
                                        ),
                                      )
                                    : SizedBox(),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: (index >= 2)
                                      ? Text(
                                          items[index]['name'],
                                          style: GoogleFonts.dancingScript(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
              onPressed: () async {
                if (newItemName.isNotEmpty) {
                  await addPlaylistToHive(newItemName);
                  loadItemsFromHive(); // Reload items from Hive
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

  void navigateToPage(int index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return FavoritePage();
        },
      ));
    } else if (index == 1) {
        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return RecetlyPlayed();
        },
      ));
    } else {
      // Handle navigation for other items from Hive
      String itemName = items[index - 2]['name'];
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return OtherPage(itemName: itemName);
        },
      ));
    }
  }
}

class OtherPage extends StatelessWidget {
  final String itemName;

  const OtherPage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Center(
        child: Text(
          'This is the $itemName page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
