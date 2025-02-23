import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
        textTheme: GoogleFonts.poppinsTextTheme(), // applying google fonts
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
        elevation: 5,
        title: Text(
          'Personal Information',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Profile Picture
                Hero(
                  tag: "profile_picture",
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image.asset('assets/profile.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Justin Joseph E. Sanchez',
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Full Stack Developer',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 25),

                _buildCard(
                  title: 'About Me',
                  content:
                  'I am a passionate Full Stack Developer with experience in web and mobile applications. '
                      'I love solving complex problems and building efficient, scalable software solutions.',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),

                _buildCard(
                  title: 'Contact Information',
                  content:
                  '📧 Email: justinjoseph.sanchez@lorma.edu\n'
                      '📞 Phone: +63 961 952 3507\n'
                      '📍 Location: Balaoan, La Union, Philippines',
                  icon: Icons.contact_mail,
                ),
                const SizedBox(height: 25),

                Text(
                  'Gallery',
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),

                // image carousel
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.easeInOut,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 900),
                    viewportFraction: 0.85,
                  ),
                  items: List.generate(5, (index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/image${index + 1}.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'i love princess',
                              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // widget
  Widget _buildCard({required String title, required String content, required IconData icon}) {
    return GestureDetector(
      onTap: () {}, // Can be used for navigation or actions
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.blue.shade900),
              const SizedBox(height: 5),
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
