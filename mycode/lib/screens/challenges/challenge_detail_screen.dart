import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'challenge_complete_screen.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> challenge;
  
  const ChallengeDetailScreen({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  @override
  _ChallengeDetailScreenState createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  List<int> _selectedAnswers = [];
  bool _showExplanation = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _selectedAnswers = List.filled((widget.challenge['questions'] as List).length, -1);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final questions = widget.challenge['questions'] as List;
    final currentQuestion = questions[_currentQuestionIndex] as Map<String, dynamic>;
    final options = currentQuestion['options'] as List;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        title: Text(
          widget.challenge['name'] as String,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Points badge
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF54408C).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: Color(0xFFFFD700),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.challenge['points']} pts',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentQuestionIndex + 1}/${questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          _getCategoryIcon(widget.challenge['category'] as String),
                          color: widget.challenge['color'] as Color,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.challenge['category'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: widget.challenge['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / questions.length,
                    backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(widget.challenge['color'] as Color),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
          ),
          
          // Question and options
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentQuestion['question'] as String,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            if (_showExplanation) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Colors.black26 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getAnswerColor(_selectedAnswers[_currentQuestionIndex], currentQuestion['answer'] as int),
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          _selectedAnswers[_currentQuestionIndex] == currentQuestion['answer']
                                              ? Icons.check_circle
                                              : Icons.info,
                                          color: _getAnswerColor(_selectedAnswers[_currentQuestionIndex], currentQuestion['answer'] as int),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _selectedAnswers[_currentQuestionIndex] == currentQuestion['answer']
                                              ? 'Correct!'
                                              : 'Explanation:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: _getAnswerColor(_selectedAnswers[_currentQuestionIndex], currentQuestion['answer'] as int),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      currentQuestion['explanation'] as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode ? Colors.white70 : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Options
                      ...List.generate(options.length, (index) {
                        final isSelected = _selectedAnswers[_currentQuestionIndex] == index;
                        final isCorrect = index == currentQuestion['answer'];
                        
                        Color getOptionColor() {
                          if (!_showExplanation) {
                            return isSelected
                                ? const Color(0xFF54408C)
                                : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200);
                          } else {
                            if (isCorrect) {
                              return const Color(0xFF4CAF50);
                            } else if (isSelected && !isCorrect) {
                              return const Color(0xFFE53935);
                            } else {
                              return isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;
                            }
                          }
                        }
                        
                        return GestureDetector(
                          onTap: _showExplanation ? null : () {
                            setState(() {
                              _selectedAnswers[_currentQuestionIndex] = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: getOptionColor(),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: getOptionColor().withOpacity(0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: getOptionColor(),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: _showExplanation && isCorrect
                                        ? const Icon(
                                            Icons.check,
                                            color: Color(0xFF4CAF50),
                                            size: 16,
                                          )
                                        : (_showExplanation && isSelected && !isCorrect
                                            ? const Icon(
                                                Icons.close,
                                                color: Color(0xFFE53935),
                                                size: 16,
                                              )
                                            : (isSelected
                                                ? const Icon(
                                                    Icons.circle,
                                                    color: Color(0xFF54408C),
                                                    size: 12,
                                                  )
                                                : null)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    options[index] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Bottom navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                if (_currentQuestionIndex > 0 || _showExplanation)
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_showExplanation) {
                        setState(() {
                          _showExplanation = false;
                        });
                      } else {
                        setState(() {
                          _currentQuestionIndex--;
                          _animationController.reset();
                          _animationController.forward();
                        });
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: Text(_showExplanation ? 'Try Again' : 'Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                      foregroundColor: isDarkMode ? Colors.white : Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                
                // Next/Check/Finish button
                ElevatedButton.icon(
                  onPressed: _selectedAnswers[_currentQuestionIndex] == -1
                      ? null
                      : () {
                          if (_showExplanation) {
                            if (_currentQuestionIndex < questions.length - 1) {
                              setState(() {
                                _currentQuestionIndex++;
                                _showExplanation = false;
                                _animationController.reset();
                                _animationController.forward();
                              });
                            } else {
                              // Challenge completed
                              int correctAnswers = 0;
                              for (int i = 0; i < questions.length; i++) {
                                if (_selectedAnswers[i] == (questions[i] as Map<String, dynamic>)['answer']) {
                                  correctAnswers++;
                                }
                              }
                              
                              final earnedPoints = (widget.challenge['points'] as int) * correctAnswers ~/ questions.length;
                              
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChallengeCompleteScreen(
                                    challenge: widget.challenge,
                                    correctAnswers: correctAnswers,
                                    totalQuestions: questions.length,
                                    earnedPoints: earnedPoints,
                                  ),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              _showExplanation = true;
                            });
                          }
                        },
                  icon: Icon(
                    _showExplanation
                        ? (_currentQuestionIndex < questions.length - 1 ? Icons.arrow_forward : Icons.check_circle)
                        : Icons.check,
                  ),
                  label: Text(
                    _showExplanation
                        ? (_currentQuestionIndex < questions.length - 1 ? 'Next' : 'Finish')
                        : 'Check Answer',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF54408C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getAnswerColor(int selected, int correct) {
    if (selected == correct) {
      return const Color(0xFF4CAF50); // Green for correct
    } else {
      return const Color(0xFFE53935); // Red for incorrect
    }
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'HTML':
        return Icons.html;
      case 'CSS':
        return Icons.css;
      case 'JavaScript':
        return Icons.javascript;
      case 'React':
        return Icons.code;
      case 'Flutter':
        return Icons.flutter_dash;
      default:
        return Icons.code;
    }
  }
}
