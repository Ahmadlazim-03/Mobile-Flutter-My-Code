import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'package:confetti/confetti.dart';

class ChallengeCompleteScreen extends StatefulWidget {
  final Map<String, dynamic> challenge;
  final int correctAnswers;
  final int totalQuestions;
  final int earnedPoints;
  
  const ChallengeCompleteScreen({
    Key? key,
    required this.challenge,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.earnedPoints,
  }) : super(key: key);

  @override
  State<ChallengeCompleteScreen> createState() => _ChallengeCompleteScreenState();
}

class _ChallengeCompleteScreenState extends State<ChallengeCompleteScreen> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    // Start animations after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
      _animationController.forward();
    });
  }
  
  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final double score = widget.correctAnswers / widget.totalQuestions;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // Confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.purple,
                Colors.orange,
              ],
            ),
          ),
          
          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Challenge completed text
                      Text(
                        'Challenge Completed!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.challenge['name'] as String,
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      
                      // Points earned
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF54408C).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                                border: Border.all(
                                  color: const Color(0xFF54408C),
                                  width: 4,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.emoji_events,
                                    color: Color(0xFFFFD700),
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${widget.earnedPoints}',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF54408C),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'POINTS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      
                      // Score details
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Your Score',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildScoreItem(
                                  icon: Icons.check_circle,
                                  value: '${widget.correctAnswers}/${widget.totalQuestions}',
                                  label: 'Correct',
                                  color: const Color(0xFF4CAF50),
                                  isDarkMode: isDarkMode,
                                ),
                                _buildScoreItem(
                                  icon: Icons.percent,
                                  value: '${(score * 100).toInt()}%',
                                  label: 'Accuracy',
                                  color: const Color(0xFF2196F3),
                                  isDarkMode: isDarkMode,
                                ),
                                _buildScoreItem(
                                  icon: Icons.emoji_events,
                                  value: '${widget.earnedPoints}/${widget.challenge['points']}',
                                  label: 'Points',
                                  color: const Color(0xFFFFD700),
                                  isDarkMode: isDarkMode,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _getFeedbackMessage(score),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _getFeedbackColor(score),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Navigate back to home (pop twice)
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                              icon: const Icon(Icons.home),
                              label: const Text('Home'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDarkMode ? Colors.white : Colors.black,
                                side: BorderSide(
                                  color: isDarkMode ? Colors.white54 : Colors.black54,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Share results functionality
                                _shareResults();
                              },
                              icon: const Icon(Icons.share),
                              label: const Text('Share'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF54408C),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Return to challenges screen
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.explore),
                        label: const Text('More Challenges'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54408C).withOpacity(0.2),
                          foregroundColor: const Color(0xFF54408C),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildScoreItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required bool isDarkMode,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
  
  String _getFeedbackMessage(double score) {
    if (score >= 0.9) {
      return 'Excellent! You\'re a coding master!';
    } else if (score >= 0.7) {
      return 'Great job! Keep up the good work!';
    } else if (score >= 0.5) {
      return 'Good effort! Practice makes perfect!';
    } else {
      return 'Keep learning! You\'ll get better with practice!';
    }
  }
  
  Color _getFeedbackColor(double score) {
    if (score >= 0.9) {
      return const Color(0xFF4CAF50);
    } else if (score >= 0.7) {
      return const Color(0xFF2196F3);
    } else if (score >= 0.5) {
      return const Color(0xFFFFA000);
    } else {
      return const Color(0xFFE53935);
    }
  }
  
  void _shareResults() {
    // This would typically use a share plugin
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Shared: I scored ${widget.correctAnswers}/${widget.totalQuestions} on ${widget.challenge['name']} challenge and earned ${widget.earnedPoints} points!',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
