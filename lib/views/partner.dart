import 'package:flutter/material.dart';

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});

  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  static const _purple = Color(0xFF5C35CC);
  static const _orange = Color(0xFFFFA726);

  int _mainTab = 0; // 0: Rides, 1: Partners
  int _subTab = 0; // 0: Find / 1: Post
  int _selectedIndex = 1;

  // Post Request form controllers
  final _fromCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  final _datesCtrl = TextEditingController();
  final _interestsCtrl = TextEditingController();

  @override
  void dispose() {
    _fromCtrl.dispose();
    _toCtrl.dispose();
    _datesCtrl.dispose();
    _interestsCtrl.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _rides = [
    {
      'name': 'Sophie M.',
      'initial': 'S',
      'price': '€25',
      'from': 'Paris',
      'to': 'Lyon',
      'date': 'Mar 22, 2026',
      'seats': 2,
    },
    {
      'name': 'Kenji T.',
      'initial': 'K',
      'price': '¥3,500',
      'from': 'Tokyo',
      'to': 'Kyoto',
      'date': 'Mar 25, 2026',
      'seats': 3,
    },
    {
      'name': 'Alex R.',
      'initial': 'A',
      'price': '\$40',
      'from': 'NYC',
      'to': 'Boston',
      'date': 'Mar 28, 2026',
      'seats': 1,
    },
  ];

  final List<Map<String, dynamic>> _partners = [
    {
      'name': 'Emma Wilson',
      'initial': 'E',
      'age': 28,
      'from': 'Paris',
      'to': 'Amsterdam',
      'dates': 'Apr 5-12, 2026',
      'interests': ['Photography', 'Museums', 'Local Cuisine'],
    },
    {
      'name': 'Marcus Lee',
      'initial': 'M',
      'age': 32,
      'from': 'Tokyo',
      'to': 'Osaka',
      'dates': 'Apr 15-20, 2026',
      'interests': ['Hiking', 'Street Food', 'Culture'],
    },
    {
      'name': 'Sofia Garcia',
      'initial': 'S',
      'age': 25,
      'from': 'Barcelona',
      'to': 'Valencia',
      'dates': 'May 1-7, 2026',
      'interests': ['Beach', 'Nightlife', 'Art'],
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

  // ── Purple gradient header ──────────────────────────────────────────────────
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
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Travel Connect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              // Rides / Partners toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    _buildHeaderTab('🚗  Rides', 0),
                    _buildHeaderTab('👥  Partners', 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTab(String label, int index) {
    final isSelected = index == _mainTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _mainTab = index;
          _subTab = 0; // reset sub-tab on main switch
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3D1FA8) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xCCFFFFFF),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // ── Scrollable body ─────────────────────────────────────────────────────────
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sub-tab toggle — labels differ per main tab
          _buildSubTabRow(),
          const SizedBox(height: 22),
          // Content switches on both tabs
          if (_mainTab == 0) ..._buildRidesContent(),
          if (_mainTab == 1) ..._buildPartnersContent(),
        ],
      ),
    );
  }

  Widget _buildSubTabRow() {
    final labels = _mainTab == 0
        ? ['Find a Ride', 'Post a Ride']
        : ['Find Partner', 'Post Request'];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          2,
          (i) => _buildSubTab(labels[i], i),
        ),
      ),
    );
  }

  Widget _buildSubTab(String label, int index) {
    final isSelected = index == _subTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _subTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? _orange : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF888888),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // ── Rides tab content ───────────────────────────────────────────────────────
  List<Widget> _buildRidesContent() {
    if (_subTab == 1) return [_buildPostRideForm()];
    return [
      const Text(
        'Available Rides',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A1A2E),
        ),
      ),
      const SizedBox(height: 14),
      ..._rides.map(
        (ride) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildRideCard(ride),
        ),
      ),
    ];
  }

  Widget _buildRideCard(Map<String, dynamic> ride) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _avatar(ride['initial'] as String, _orange),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ride['name'] as String,
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
                          Icons.directions_car_outlined,
                          color: _purple,
                          size: 15,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${ride['from']} → ${ride['to']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: _purple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                ride['price'] as String,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xFF999999),
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                ride['date'] as String,
                style: const TextStyle(fontSize: 13, color: Color(0xFF777777)),
              ),
              const SizedBox(width: 18),
              const Icon(
                Icons.people_outline_rounded,
                color: Color(0xFF999999),
                size: 14,
              ),
              const SizedBox(width: 5),
              Text(
                '${ride['seats']} seats',
                style: const TextStyle(fontSize: 13, color: Color(0xFF777777)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _actionButton(
            label: 'Request Ride',
            icon: Icons.directions_car_outlined,
            color: _purple,
          ),
        ],
      ),
    );
  }

  Widget _buildPostRideForm() {
    return _postFormCard(
      title: 'Post Ride Offer',
      fromHint: 'Starting city',
      toHint: 'Destination city',
      datesHint: 'e.g., Apr 5-12, 2026',
      extraLabel: 'Available Seats',
      extraHint: 'e.g., 3',
      extraIcon: Icons.people_outline_rounded,
      buttonLabel: 'Post Ride',
    );
  }

  // ── Partners tab content ────────────────────────────────────────────────────
  List<Widget> _buildPartnersContent() {
    if (_subTab == 1) return [_buildPostPartnerForm()];
    return [
      const Text(
        'Available Travel Partners',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A1A2E),
        ),
      ),
      const SizedBox(height: 14),
      ..._partners.map(
        (p) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildPartnerCard(p),
        ),
      ),
    ];
  }

  Widget _buildPartnerCard(Map<String, dynamic> p) {
    final interests = p['interests'] as List<String>;
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar + name/age/route/date
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _avatar(p['initial'] as String, _purple),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['name'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${p['age']} years old',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: _purple,
                          size: 15,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${p['from']} → ${p['to']}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w500,
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
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          p['dates'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Interests
          const Text(
            'Interests:',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF888888),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: interests.map((tag) => _interestChip(tag)).toList(),
          ),

          const SizedBox(height: 14),
          _actionButton(
            label: 'Connect',
            icon: Icons.person_add_alt_1_rounded,
            color: _purple,
          ),
        ],
      ),
    );
  }

  Widget _buildPostPartnerForm() {
    return _postFormCard(
      title: 'Post Partner Request',
      fromHint: 'Starting city',
      toHint: 'Destination city',
      datesHint: 'e.g., Apr 5-12, 2026',
      extraLabel: 'Interests (comma-separated)',
      extraHint: 'e.g., Photography, Museums, Food',
      extraIcon: Icons.favorite_border_rounded,
      buttonLabel: 'Post Request',
    );
  }

  // ── Shared helpers ──────────────────────────────────────────────────────────
  Widget _avatar(String initial, Color color) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _interestChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: _purple,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 18),
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  /// Shared form card used by both "Post a Ride" and "Post Partner Request"
  Widget _postFormCard({
    required String title,
    required String fromHint,
    required String toHint,
    required String datesHint,
    required String extraLabel,
    required String extraHint,
    required IconData extraIcon,
    required String buttonLabel,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 20),
          _formLabel('From'),
          const SizedBox(height: 8),
          _formField(
            controller: _fromCtrl,
            hint: fromHint,
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 16),
          _formLabel('To'),
          const SizedBox(height: 8),
          _formField(
            controller: _toCtrl,
            hint: toHint,
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 16),
          _formLabel('Travel Dates'),
          const SizedBox(height: 8),
          _formField(
            controller: _datesCtrl,
            hint: datesHint,
            icon: Icons.calendar_today_outlined,
          ),
          const SizedBox(height: 16),
          _formLabel(extraLabel),
          const SizedBox(height: 8),
          _formField(
            controller: _interestsCtrl,
            hint: extraHint,
            icon: extraIcon,
          ),
          const SizedBox(height: 24),
          _actionButton(
            label: buttonLabel,
            icon: Icons.person_add_alt_1_rounded,
            color: _orange,
          ),
        ],
      ),
    );
  }

  Widget _formLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF555555),
      ),
    );
  }

  Widget _formField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFFAAAAAA)),
        prefixIcon: Icon(icon, size: 18, color: const Color(0xFFAAAAAA)),
        filled: true,
        fillColor: const Color(0xFFF5F5F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    );
  }

  // ── Bottom navigation ───────────────────────────────────────────────────────
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
