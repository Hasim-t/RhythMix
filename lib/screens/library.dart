import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/database/function/db_playlist.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/screens/favorite_page.dart';
import 'package:rhythmix/screens/playlists/playlist.dart';
import 'package:rhythmix/screens/recetly_played.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  GlobalKey<_LibraryState> libraryKey = GlobalKey<_LibraryState>();
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
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(130, 53, 102, 186),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FavoritePage();
                      },
                    ));
                  },
                  title: Text(
                    'Favorite',
                    style:dancing()
                  ),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(130, 53, 102, 186),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return RecetlyPlayed();
                      },
                    ));
                  },
                  title: Text(
                    'Recently Played',
                    style:dancing()
                  ),
                  leading: Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<PlaylistModel>>(
                  future: getallplaylis(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> items =
                          snapshot.data?.map((playlist) {
                                return {
                                  'name': playlist.name,
                                  'image': 'asset/playlist.jpeg',
                                };
                              }).toList() ??
                              [];

                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          PlaylistModel item = snapshot.data![index];
                          if (item.name.isEmpty) {
                            const Center(
                              child: Text('Add Playlist'),
                            );
                            setState(() {});
                          }
                          return InkWell(
                            onTap: () {
                              navigateToPage(item);
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
                                        child: // Replace the IconButton with PopupMenuButton
                                            PopupMenuButton<int>(
                                          onSelected: (value) async {
                                            // Delay for a short duration to allow the menu to close
                                            await Future.delayed(
                                                Duration(milliseconds: 50));

                                            // Handle the selected option if needed
                                            if (value == 1) {
                                              showDeleteAlertDialog(
                                                  snapshot.data![index]);
                                            } else if (value == 2) {
                                              showEditItemDialog(
                                                  snapshot.data![index]);
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            PopupMenuItem<int>(
                                              value: 1,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete),
                                                  SizedBox(width: 10),
                                                  Text("Delete"),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 2,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit_note_rounded),
                                                  SizedBox(width: 10),
                                                  Text("Edit"),
                                                ],
                                              ),
                                            ),
                                          ],
                                          icon: Icon(Icons.more_vert_rounded,
                                              color: Colors.white),
                                        )),
                                    Positioned.fill(
                                      child: Center(
                                        child: Text(
                                          items[index]['name'],
                                          style: GoogleFonts.dancingScript(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAddItemDialog(
    BuildContext context,
  ) async {
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
                  await addPlaylistToHive(newItemName, []);
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

  void navigateToPage(PlaylistModel item) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return OtherPage(
          itemName: item.name,
          id: item.key,
        );
      },
    ));
  }

  void popup(BuildContext context) async {
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 10),
              Text("Get The App"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.chrome_reader_mode),
              SizedBox(width: 10),
              Text("About"),
            ],
          ),
        ),
      ],
    );

    // Handle the result if needed
    if (result == 1) {
    } else if (result == 2) {}
  }

  void showDeleteAlertDialog(PlaylistModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Playlist"),
          content: Text("Are you sure you want to delete this playlist?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                showDeleteSnackbar();
                await deleteplaylist(item.key);
                Navigator.pop(context);
                setState(() {});
                _updateGridView();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _updateGridView() {
    setState(() {});
  }

  Future<void> deleteplaylist(int key) async {
    final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
    playlistBox.delete(key);

    setState(() {});
  }

  Future<void> showEditItemDialog(PlaylistModel item) async {
    String editedItemName = item.name;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Playlist'),
          content: TextField(
            controller: TextEditingController(text: editedItemName),
            onChanged: (value) {
              editedItemName = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter edited playlist name',
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
                if (editedItemName.isNotEmpty) {
                  await editPlaylistInHive(item.key, editedItemName);
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(16),
        backgroundColor: Colors.blue[200],
        content: Text('Playlist deleted'),
      ),
    );
  }
}
