import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(232, 5, 122, 247),
              Color.fromARGB(255, 255, 255, 255)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Text('''
    About Us

Welcome to Rhythmix, your ultimate destination for a rich and immersive music experience!

Rhythmix is not just a music app; it's a gateway to a world where every beat tells a story and every note creates a memory. Here's a closer look at the features that make Rhythmix stand out:

1. **Fetch and Listen to Songs:**
   Rhythmix seamlessly fetches and plays your favorite songs. Access your device's storage to enjoy an extensive collection of music in one place.

2. **Play, Pause, and Control Playback:**
   Take command of your music with user-friendly playback controls. Play, pause, and resume your songs with a simple tap, putting you in control of your auditory journey.

3. **Next and Previous Track Seek:**
   Navigate through your playlist effortlessly by skipping to the next or previous track. Enjoy a smooth and uninterrupted music experience, ensuring you never miss a beat.

4. **Shuffle Songs:**
   Add an element of surprise to your music experience by shuffling your playlist. Discover hidden gems and rediscover your favorite tunes with every shuffle.

5. **Favorite Songs:**
   Mark your favorite songs with a tap, creating a personalized collection of your most-loved tracks for quick access and easy rediscovery.

6. **Create Playlists:**
   Rhythmix empowers you to curate your playlists. Organize your music based on mood, genre, or any theme you desire. Add and remove songs to customize your playlists and create the perfect soundtrack for every moment.

7. **Add Songs to Playlist:**
   Tailor your playlists by easily adding or removing songs. Manage your music collection with flexibility and ease, ensuring your playlists evolve with your ever-changing tastes.

8. **Lyrics Availability:**
   Immerse yourself in the full experience of your favorite songs with our lyrics feature. Access lyrics while listening to enhance your understanding and connection with the music, turning each listening session into a complete sensory experience.

9. **Discover More:**
   Explore new artists, genres, and hidden treasures within the vast Rhythmix music library. Our app is designed to keep your music journey exciting and diverse, allowing you to uncover new favorites and expand your musical horizons.

10. **User-Friendly Interface:**
    Rhythmix boasts an intuitive and user-friendly interface, ensuring a seamless and enjoyable experience for music enthusiasts of all levels. The app is designed with you in mind, providing easy navigation and quick access to all features.

Rhythmix is more than just a music app; it's your companion in exploring the world of melodies. Whether you are in the mood for nostalgia, upbeat tunes, or discovering new artists, Rhythmix has you covered.

Thank you for choosing Rhythmix. We hope you enjoy the rhythmic journey through your favorite tunes!

For any inquiries, feedback, or support, please feel free to contact us at [Your Contact Email].


    ''',style: TextStyle(),),
      ),
    ),
    ));
  }
}