import 'package:flutter/material.dart';

void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Booking Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFEFEFF4),
      ),
      home: const MedicalScreen(),
    );
  }
}

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final String imageUrl; // Dùng URL ảnh trên mạng
  Doctor(this.name, this.specialty, this.rating, this.imageUrl);
}

class MedicalScreen extends StatelessWidget {
  const MedicalScreen({super.key});

  Widget _categoryButton(IconData icon, String label) {
    return Container(
      width: 110,
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE2DCF7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.deepPurple),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _doctorCard(Doctor d) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE2DCF7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dùng NetworkImage để load trực tiếp ảnh từ URL trên mạng
          CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage(d.imageUrl),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text(' ${d.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            d.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            d.specialty,
            style: const TextStyle(color: Colors.black54, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctors = [
      Doctor(
        'Dr. Mitch Kuko',
        'Psychologist 7 y.e.',
        4.4,
        'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=300',
      ),
      Doctor(
        'Dr. Steve Jobs',
        'Surgeon 7 y.e.',
        5.0,
        'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=300',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello,', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text('Mitch Koko', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade100,
                  ),
                  child: const Icon(Icons.person, color: Colors.deepPurple),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Thẻ hồng "How do you feel?"
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9D4E5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC4B8E8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('How do you feel?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        const Text('Fill out your medical card right now', style: TextStyle(fontSize: 11, color: Colors.black54)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 34,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            ),
                            onPressed: () {},
                            child: const Text('Get Started', style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE2DCF7),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Text('How can we help you?', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Danh mục
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _categoryButton(Icons.medical_services_outlined, 'Dentist'),
                  const SizedBox(width: 12),
                  _categoryButton(Icons.person_search, 'Surgeon'),
                  const SizedBox(width: 12),
                  _categoryButton(Icons.local_hospital_outlined, 'Cardio'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Doctor list', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('See all', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: doctors.map(_doctorCard).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}