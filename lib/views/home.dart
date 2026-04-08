import 'package:flutter/material.dart';
import 'package:tripsnap_project/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ApiService _apiService = ApiService();
  final Map<String, String> _countryImageUrls = {};

  static const _purple = Color(0xFF5C35CC);
  static const _orange = Color(0xFFFFA726);

  @override
  void initState() {
    super.initState();
    _loadCountryImages();
  }

  Future<void> _loadCountryImages() async {
    try {
      final countries = await _apiService.fetchCountryImagesByCodes(
        const ['FR', 'JP', 'GR'],
      );

      if (!mounted) return;

      setState(() {
        for (final country in countries) {
          _countryImageUrls[country.code] = country.imageUrl;
        }
      });
    } catch (_) {}
  }

  String _flagImageFor(String code) {
    return _countryImageUrls[code] ??
        'https://flagcdn.com/w640/${code.toLowerCase()}.png';
  }

  //Scaffold
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

  // Purple Header
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
              // Welcome row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ready for your next adventure?',
                          style: TextStyle(
                            color: Color(0xCCFFFFFF),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Avatar
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: _orange,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'V',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Stat cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.airplanemode_active_rounded,
                      label: 'Trips',
                      value: '8',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.location_on_outlined,
                      label: 'Memories',
                      value: '35',
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

  Widget _buildStatCard({
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

  // ── Scrollable body 
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Memory Highlights header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Memory Highlights',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: _purple,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Memory cards row
          Row(
            children: [
              Expanded(
                child: _buildMemoryCard(
                  imageUrl: _flagImageFor('FR'),
                  location: 'Paris, France',
                  date: 'Dec 2025',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildMemoryCard(
                  imageUrl: _flagImageFor('JP'),
                  location: 'Tokyo, Japan',
                  date: 'Nov 2025',
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Last Month Overview header
          const Text(
            'Last Month Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),

          const SizedBox(height: 14),

          // Overview card
          _buildOverviewCard(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMemoryCard({
    required String imageUrl,
    required String location,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 1.05,
              child: Image.network(
                imageUrl,
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
                errorBuilder: (_, _, _) => Container(
                  color: const Color(0xFFEDE9F8),
                  child: const Center(
                    child: Icon(Icons.image_rounded, color: _purple, size: 40),
                  ),
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: _purple,
                        size: 13,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF999999),
                        size: 11,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badge overlay
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    _flagImageFor('GR'),
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
                    errorBuilder: (_, _, _) => Container(
                      color: const Color(0xFFEDE9F8),
                      child: const Center(
                        child: Icon(Icons.image_rounded, color: _purple, size: 60),
                      ),
                    ),
                  ),
                ),
                // GR Greece badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'GR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Greece',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Trip title
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Text(
                'Santorini Getaway',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Navigation
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
          if (i == 1) {
            Navigator.pushReplacementNamed(context, '/partner');
          } else if (i == 2) {
            Navigator.pushReplacementNamed(context, '/memories');
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
