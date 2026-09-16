import 'package:flutter/material.dart';

void main() {
  runApp(const MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: const Color(0xFFF3F3F6)),
      home: const PlayerScreen(),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final double _progress = 0.4;
  bool _isPlaying = true;

  Widget _roundIconButton(IconData icon, {double size = 56, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(icon, size: size * 0.4, color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _roundIconButton(Icons.arrow_back, size: 44),
                  const Text('PLAYLIST', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.w600)),
                  _roundIconButton(Icons.menu, size: 44),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: const DecorationImage(
                          // Link ảnh album nhạc thực tế trên mạng
                          image: NetworkImage('https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=600'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                        child: const Text('EXPLICIT', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tên bài hát + tim yêu thích
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kota The Friend', style: TextStyle(color: Colors.grey)),
                      Text('Birdie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.favorite, color: Colors.red, size: 28),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('0:00', style: TextStyle(color: Colors.grey)),
                  Icon(Icons.shuffle, color: Colors.grey),
                  Icon(Icons.repeat, color: Colors.grey),
                  Text('4:22', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              // Thanh tiến trình
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const SizedBox(height: 24),
              // Nút điều khiển
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _roundIconButton(Icons.skip_previous, size: 60),
                  _roundIconButton(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 72,
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                  ),
                  _roundIconButton(Icons.skip_next, size: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}