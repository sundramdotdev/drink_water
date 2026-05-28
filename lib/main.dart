import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DrinkWaterApp());
}

class DrinkWaterApp extends StatelessWidget {
  const DrinkWaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Water',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0ea5e9),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DrinkWaterDashboard(),
    );
  }
}

class DrinkWaterDashboard extends StatefulWidget {
  const DrinkWaterDashboard({super.key});

  @override
  State<DrinkWaterDashboard> createState() => _DrinkWaterDashboardState();
}

class _DrinkWaterDashboardState extends State<DrinkWaterDashboard> {
  int _currentIntake = 0;
  final int _dailyGoal = 2500;

  static const String _intakeKey = 'daily_water_intake';

  @override
  void initState() {
    super.initState();
    _loadIntake();
  }

  // Load saved intake from shared preferences
  Future<void> _loadIntake() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentIntake = prefs.getInt(_intakeKey) ?? 0;
    });
  }

  // Save intake to shared preferences
  Future<void> _saveIntake(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_intakeKey, value);
  }

  // Add water helper
  void _addWater(int amount) {
    setState(() {
      _currentIntake = (_currentIntake + amount).clamp(0, 9999);
    });
    _saveIntake(_currentIntake);
    
    // Trigger a light haptic-like visual feedback or a nice toast
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.water_drop, color: Color(0xFF38bdf8)),
            const SizedBox(width: 8),
            Text(
              'Logged +${amount}ml of hydration!',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1e293b),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Reset helper
  void _resetIntake() {
    setState(() {
      _currentIntake = 0;
    });
    _saveIntake(0);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.refresh, color: Colors.amber),
            SizedBox(width: 8),
            Text('Hydration tracker reset for the day!'),
          ],
        ),
        backgroundColor: const Color(0xFF1e293b),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Get dynamic encouragement phrase
  String _getEncouragementText(double percentage) {
    if (percentage == 0) return 'Start hydrating to fuel your day! ☀️';
    if (percentage < 0.3) return 'Great start! Keep sipping! 💧';
    if (percentage < 0.6) return 'Almost halfway to your goal! 🚀';
    if (percentage < 0.9) return 'You are doing amazing! Feel the energy! ⚡';
    if (percentage < 1.0) return 'Just a little more to hit the goal! 🎯';
    return 'Daily Goal Achieved! Phenomenal job! 🎉';
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = (_currentIntake / _dailyGoal).clamp(0.0, 1.0);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // 1. The Shell - Custom transparent AppBar
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop_outlined, color: Color(0xFF38bdf8), size: 28),
            SizedBox(width: 8),
            Text(
              'DRINK WATER',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white60),
            tooltip: 'Reset Progress',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF0f172a),
                  title: const Text('Reset Tracker?'),
                  content: const Text(
                    'Do you want to reset today\'s water log to 0 ml?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _resetIntake();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // Sleek background gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0b132b), // Very deep navy
              Color(0xFF1c2541), // Deep navy
              Color(0xFF3a506b), // Cool steel navy
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // 2. Goal Tracking - Custom Typography Card
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'HYDRATION PROGRESS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Color(0xFF38bdf8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$_currentIntake',
                            style: const TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '/ 2500 ml',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Animated encouragement text
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _getEncouragementText(percentage),
                          key: ValueKey<String>(
                            _getEncouragementText(percentage),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: percentage >= 1.0
                                ? Colors.greenAccent
                                : Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 4. Responsiveness - Dynamic Liquid Cylinder Container using Expanded
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double tankHeight = constraints.maxHeight;
                      final double tankWidth = (tankHeight * 0.55).clamp(
                        160.0,
                        220.0,
                      );

                      return Center(
                        child: Container(
                          width: tankWidth,
                          height: tankHeight,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                              width: 6,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF00b4d8,
                                ).withOpacity(0.06),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            children: [
                              // Glass-morphic background depth
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(44),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.05),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),
                              ),

                              // Dynamic Liquid Container
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.easeOutCubic,
                                  width: double.infinity,
                                  height: tankHeight * percentage,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: const Radius.circular(44),
                                      bottomRight: const Radius.circular(44),
                                      topLeft: Radius.circular(
                                        percentage >= 0.95 ? 44 : 20,
                                      ),
                                      topRight: Radius.circular(
                                        percentage >= 0.95 ? 44 : 20,
                                      ),
                                    ),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF00b4d8), // Sparkling cyan
                                        Color(0xFF0077b6), // Ocean blue
                                        Color(0xFF03045e), // Deep water blue
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF48cae4,
                                        ).withOpacity(0.4),
                                        blurRadius: 15,
                                        offset: const Offset(0, -4),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Bubbles effect floating inside (subtle UI polish)
                              ...List.generate(6, (index) {
                                final List<double> bottomOffsets = [
                                  40,
                                  80,
                                  120,
                                  160,
                                  200,
                                  240,
                                ];
                                final List<double> leftOffsets = [
                                  30,
                                  70,
                                  110,
                                  45,
                                  85,
                                  125,
                                ];
                                final List<double> sizes = [
                                  8,
                                  12,
                                  6,
                                  14,
                                  10,
                                  7,
                                ];

                                return Positioned(
                                  bottom:
                                      bottomOffsets[index %
                                          bottomOffsets.length] *
                                      (percentage + 0.1),
                                  left: leftOffsets[index % leftOffsets.length],
                                  child: AnimatedOpacity(
                                    opacity:
                                        percentage >
                                            (bottomOffsets[index] / tankHeight)
                                        ? 0.35
                                        : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: sizes[index],
                                      height: sizes[index],
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white24,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),

                              // Floating Percentage Label inside container
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${(percentage * 100).toInt()}%',
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10,
                                          color: Colors.black45,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'QUICK ADD WATER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Builder(
                      builder: (context) {
                        final double availableWidth = MediaQuery.of(context).size.width - 48.0; // Subtract horizontal padding (24 * 2)
                        const double minButtonWidth = 95.0;
                        const double spacing = 12.0;
                        
                        final bool fitThree = (minButtonWidth * 3 + spacing * 2) <= availableWidth;
                        final double buttonWidth = fitThree 
                            ? (availableWidth - spacing * 2) / 3 
                            : (availableWidth - spacing) / 2;

                        return Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildLogButton(
                              label: '+250 ml',
                              icon: Icons.local_cafe_rounded,
                              amount: 250,
                              width: buttonWidth,
                            ),
                            _buildLogButton(
                              label: '+500 ml',
                              icon: Icons.local_drink_rounded,
                              amount: 500,
                              width: buttonWidth,
                            ),
                            _buildLogButton(
                              label: '+750 ml',
                              icon: Icons.wine_bar_rounded,
                              amount: 750,
                              width: buttonWidth,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      // 1. The Shell - Floating Action Button for Quick-Add or resetting
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => _addWater(250),
        tooltip: 'Quick Sip (250 ml)',
        backgroundColor: const Color(0xFF00b4d8),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.water_drop, size: 40),
            Positioned(
              bottom: 4,
              child: Text(
                '+250',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable styling for our quick-add ElevatedButtons
  Widget _buildLogButton({
    required String label,
    required IconData icon,
    required int amount,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () => _addWater(amount),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.06),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.08), width: 1.5),
        ),
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF00b4d8), size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
