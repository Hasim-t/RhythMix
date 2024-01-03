import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:rhythmix/screens/Home.dart';
import 'package:rhythmix/screens/nowPlaying.dart';
import 'package:text_scroll/text_scroll.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<MusicModel>> searchsong = getAllSongs();

  Future<List<MusicModel>> foundsong = Future.value([]);

  @override
  void initState() {
    foundsong = searchsong;
    super.initState();
  }

  void runfilter(String enteredKeyword) async {
    List<MusicModel> result = [];

    if (enteredKeyword.isEmpty) {
      result = await searchsong;
    } else {
      result = (await searchsong)
          .where((user) => user.songname
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundsong = Future.value(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onChanged: (value) => runfilter(value),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<MusicModel>>(
                future: foundsong,
                builder: (context, item) {
                  if (item.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (item.data == null || item.data!.isEmpty) {
                    return Center(child: Text('No songs found'));
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: screenWidth * 0.04,
                          left: screenWidth * 0.04,
                          bottom: screenWidth * 0.02,
                        ),
                        child: Card(
                          key: ValueKey(item.data![index].songname),
                          color: Colors.transparent,
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(130, 53, 102, 186),
                            ),
                            child: ListTile(
                              onTap: () async {
                                context
                                    .read<songModelprovider>()
                                    .setId(item.data![index].songid);
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return NowPlaying(
                                      songModel: item.data![index],
                                      audioPlayer: audioplayer,
                                    );
                                  }),
                                );
                              },
                              title: TextScroll(item.data![index].songname),
                              subtitle:
                                  TextScroll('${item.data![index].artrist}'),
                              leading: QueryArtworkWidget(
                                id: item.data![index].songid,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  child:
                                      Image.asset('asset/the black boy.jpeg'),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  bottomsheet(context, item.data![index]);
                                },
                                child: Icon(
                                  Icons.more_vert,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: item.data!.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
