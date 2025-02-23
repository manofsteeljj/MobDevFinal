import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const PersonalInfoScreen(),
    );
  }
}

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Personal Information',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 15),
              Text('Justin Joseph E. Sanchez',
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold)),
              Text('Full Stack Developer',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70)),
              const SizedBox(height: 25),
              _buildCard(title: 'About Me', content: 'I love coding!', icon: Icons.person),
              const SizedBox(height: 15),
              _buildCard(title: 'Contact', content: 'Email: justin@example.com', icon: Icons.email),
              const SizedBox(height: 25),
              _buildSectionTitle('Gallery'),
              _buildImageCarousel(),
              _buildSectionTitle('My Top 5 Videos on YouTube'),
              _buildYouTubeCarousel(),
              _buildSectionTitle('My Top 5 Songs on Spotify'),
              _buildSpotifyCarousel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String content, required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.blue.shade900),
            const SizedBox(height: 5),
            Text(title, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildImageCarousel() {
    return CarouselSlider(
      options: CarouselOptions(height: 250, autoPlay: true),
      items: List.generate(5, (index) => Image.asset('assets/image${index + 1}.jpg')),
    );
  }

  Widget _buildYouTubeCarousel() {
    List<String> videoIds = [
      'wtBiv8hJpE',
      'sN9dDG4TIsc',
      's1IjAODUuPE',
      'i4e-NHdft4E',
      'g2FGPPfAFBQ',
    ];

    return CarouselSlider(
      options: CarouselOptions(height: 250, autoPlay: false),
      items: videoIds.map((id) {
        return YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: id,
            flags: YoutubePlayerFlags(autoPlay: false),
          ),
          showVideoProgressIndicator: true,
        );
      }).toList(),
    );
  }

  Widget _buildSpotifyCarousel() {
    List<String> trackUrls = [
      'https://open.spotify.com/embed/track/45J4avUb9Ni0bnETYaYFVJ',
      'https://open.spotify.com/embed/track/3aSWXU6owkZeVhh94XxEWO',
      'https://open.spotify.com/embed/track/2fXwCWkh6YG5zU1IyvQrbs',
      'https://open.spotify.com/embed/track/5wttBUDyaHAR5q9fYnN3YF',
      'https://open.spotify.com/embed/track/5Y35SjAfXjjG0sFQ3KOxmm',
    ];

    return CarouselSlider(
      options: CarouselOptions(height: 100, autoPlay: false),
      items: trackUrls.map((url) {
        if (Platform.isAndroid || Platform.isIOS) {
          WebViewController controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(url));

          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: WebViewWidget(controller: controller),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text('WebView not supported on this platform'),
          );
        }
      }).toList(),
    );
  }
}
