import 'package:flutter/material.dart';

class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  static const _purple = Color(0xFF5C35CC);
  static const _orange = Color(0xFFFFA726);

  int _selectedIndex = 2;

  final List<Map<String, dynamic>> _memories = [
    {
      'code': 'GR',
      'title': 'Santorini Getaway',
      'country': 'Greece',
      'price': '\$2,450',
      'dateRange': 'Feb 14 - Feb 21, 2026',
      'photos': [
        'https://picsum.photos/seed/santorini-cliff/300/200',
        'https://picsum.photos/seed/eiffel-night/300/200',
        'https://picsum.photos/seed/sunset-dusk/300/200',
      ],
      'notes':
          'An unforgettable week exploring the stunning white-washed buildings and breathtaking sunsets. The food was incredible!',
    },
    {
      'code': 'JP',
      'title': 'Tokyo Adventure',
      'country': 'Japan',
      'price': '\$3,200',
      'dateRange': 'Nov 10 - Nov 18, 2025',
      'photos': [
        'https://picsum.photos/seed/tokyo-street/300/200',
        'https://picsum.photos/seed/colosseum-rome/300/200',
        'https://picsum.photos/seed/nyc-skyline/300/200',
      ],
      'notes':
          'Tokyo was a perfect blend of traditional culture and modern technology. Loved every moment from temples to tech districts!',
    },
    {
      'code': 'FR',
      'title': 'Parisian Escape',
      'country': 'France',
      'price': '\$2,800',
      'dateRange': 'Dec 5 - Dec 12, 2025',
      'photos': [
        'https://picsum.photos/seed/paris-eiffel/300/200',
        'https://picsum.photos/seed/greece-blue/300/200',
        'https://picsum.photos/seed/dusk-silhouette/300/200',
      ],
      'notes':
          'Romance, art, and croissants! Paris exceeded all expectations. The Louvre and Eiffel Tower at night were magical.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _buildBody(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A28C4), Color(0xFF6B44E8)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip Memories',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your travel stories, beautifully saved.',
                          style: TextStyle(
                            color: Color(0xCCFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: _orange,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // Stats row
              Row(
                children: [
                  Expanded(
                    child: _buildStatChip(
                      icon: Icons.airplanemode_active_rounded,
                      label: 'Trips',
                      value: '${_memories.length}',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildStatChip(
                      icon: Icons.photo_library_outlined,
                      label: 'Photos',
                      value: '${_memories.length * 3}',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _orange, size: 17),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xCCFFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
      child: Column(
        children:
            _memories.map((memory) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _buildMemoryCard(memory),
            )).toList(),
      ),
    );
  }

  Widget _buildMemoryCard(Map<String, dynamic> memory) {
    final photos = memory['photos'] as List<String>;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: code box + title/location + price badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDF8),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  memory['code'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memory['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: _purple,
                          size: 14,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          memory['country'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Price badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '\$  ',
                      style: TextStyle(
                        fontSize: 11,
                        color: _orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      memory['price'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Date range
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF999999),
                size: 13,
              ),
              const SizedBox(width: 5),
              Text(
                memory['dateRange'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Photos row
          Row(
            children:
                photos.map((url) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          loadingBuilder: (ctx, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: const Color(0xFFEDE9F8),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: _purple,
                                ),
                              ),
                            );
                          },
                          errorBuilder:
                              (_, _, _) => Container(
                                color: const Color(0xFFEDE9F8),
                                child: const Center(
                                  child: Icon(
                                    Icons.image_rounded,
                                    color: _purple,
                                    size: 28,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                )).toList(),
          ),

          const SizedBox(height: 14),

          // Notes
          const Text(
            'Notes:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '"${memory['notes']}"',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (i == 1) {
            Navigator.pushReplacementNamed(context, '/partner');
          } else {
            setState(() => _selectedIndex = i);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _purple,
        unselectedItemColor: const Color(0xFFAAAAAA),
        showUnselectedLabels: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_rounded),
            label: 'Partner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Memories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
