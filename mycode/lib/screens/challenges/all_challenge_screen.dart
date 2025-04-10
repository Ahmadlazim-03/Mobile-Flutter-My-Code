import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'challenge_detail_screen.dart';

class AllChallengeScreen extends StatefulWidget {
  const AllChallengeScreen({Key? key}) : super(key: key);

  @override
  State<AllChallengeScreen> createState() => _AllChallengeScreenState();
}

class _AllChallengeScreenState extends State<AllChallengeScreen> with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'HTML', 'CSS', 'JavaScript', 'React', 'Flutter'];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  // New state variables for search, sort and view
  String _searchQuery = '';
  String _sortOption = 'Popular';
  bool _isGridView = true;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _sortOptions = ['Popular', 'Newest', 'Highest Points', 'Most Participants'];
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  // Method to show search dialog
  void _showSearchDialog(BuildContext context, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        title: Text(
          'Search Challenges',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter challenge name or keyword',
            hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onSubmitted: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchQuery = _searchController.text.trim();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF54408C),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
  
  // Method to show sort options
  void _showSortOptions(BuildContext context, bool isDarkMode) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 160, 
        160, 
        20, 
        0
      ),
      items: _sortOptions.map((option) {
        return PopupMenuItem<String>(
          value: option,
          child: Row(
            children: [
              Icon(
                _getSortIcon(option),
                size: 16,
                color: _sortOption == option 
                    ? const Color(0xFF54408C) 
                    : (isDarkMode ? Colors.white70 : Colors.black54),
              ),
              const SizedBox(width: 8),
              Text(
                option,
                style: TextStyle(
                  color: _sortOption == option 
                      ? const Color(0xFF54408C) 
                      : (isDarkMode ? Colors.white : Colors.black),
                  fontWeight: _sortOption == option ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (_sortOption == option)
                const Spacer()
              else
                const SizedBox.shrink(),
              if (_sortOption == option)
                const Icon(
                  Icons.check,
                  size: 16,
                  color: Color(0xFF54408C),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      }).toList(),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
    ).then((value) {
      if (value != null) {
        setState(() {
          _sortOption = value;
          _sortChallenges();
        });
      }
    });
  }
  
  // Method to sort challenges based on selected option
  void _sortChallenges() {
    // This will be implemented to sort the challenges based on _sortOption
    // For now, we'll just refresh the state
    setState(() {});
  }
  
  // Get icon for sort option
  IconData _getSortIcon(String option) {
    switch (option) {
      case 'Popular':
        return Icons.trending_up;
      case 'Newest':
        return Icons.access_time;
      case 'Highest Points':
        return Icons.emoji_events;
      case 'Most Participants':
        return Icons.people;
      default:
        return Icons.sort;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    // Get filtered and sorted challenges
    final challenges = _getFilteredChallenges();
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        title: Text(
          'Coding Challenges',
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
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Show search dialog
              _searchController.text = _searchQuery;
              _showSearchDialog(context, isDarkMode);
            },
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // User stats bar
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.emoji_events,
                  value: '1,250',
                  label: 'Points',
                  color: const Color(0xFFFFD700),
                  isDarkMode: isDarkMode,
                ),
                _buildStatItem(
                  icon: Icons.local_fire_department,
                  value: '7',
                  label: 'Day Streak',
                  color: const Color(0xFFFF5722),
                  isDarkMode: isDarkMode,
                ),
                _buildStatItem(
                  icon: Icons.check_circle,
                  value: '12',
                  label: 'Completed',
                  color: const Color(0xFF4CAF50),
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),
          
          // Filter chips
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
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
                  'Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter;
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(filter),
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                          selectedColor: const Color(0xFF54408C).withOpacity(0.2),
                          checkmarkColor: const Color(0xFF54408C),
                          labelStyle: TextStyle(
                            color: isSelected 
                                ? const Color(0xFF54408C) 
                                : (isDarkMode ? Colors.white : Colors.black),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected 
                                  ? const Color(0xFF54408C) 
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Search results indicator (if search is active)
          if (_searchQuery.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Search results for "$_searchQuery"',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                    iconSize: 18,
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          
          // Sort and view options
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Results count
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${challenges.length} Results',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                
                // Sort and view options
                Row(
                  children: [
                    // Sort dropdown
                    GestureDetector(
                      onTap: () {
                        _showSortOptions(context, isDarkMode);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getSortIcon(_sortOption),
                              size: 16,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _sortOption,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    // View toggle
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isGridView = !_isGridView;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _isGridView 
                                    ? (isDarkMode ? const Color(0xFF54408C).withOpacity(0.3) : const Color(0xFF54408C).withOpacity(0.1))
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.grid_view,
                                size: 16,
                                color: _isGridView 
                                    ? const Color(0xFF54408C)
                                    : (isDarkMode ? Colors.white70 : Colors.black54),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: !_isGridView 
                                    ? (isDarkMode ? const Color(0xFF54408C).withOpacity(0.3) : const Color(0xFF54408C).withOpacity(0.1))
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.view_list,
                                size: 16,
                                color: !_isGridView 
                                    ? const Color(0xFF54408C)
                                    : (isDarkMode ? Colors.white70 : Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Challenge grid/list
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ScaleTransition(
                  scale: _scaleAnimation,
                  child: _isGridView 
                      ? _buildGridView(challenges, isDarkMode)
                      : _buildListView(challenges, isDarkMode),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF54408C),
        icon: const Icon(Icons.filter_list),
        label: const Text('Filter'),
        onPressed: () {
          _showFilterDialog(context, isDarkMode);
        },
      ),
    );
  }
  
  // Grid view builder
  Widget _buildGridView(List<Map<String, dynamic>> challenges, bool isDarkMode) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return _buildChallengeCard(challenge, isDarkMode, context);
      },
    );
  }
  
  // List view builder
  Widget _buildListView(List<Map<String, dynamic>> challenges, bool isDarkMode) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return _buildChallengeListItem(challenge, isDarkMode, context);
      },
    );
  }
  
  // Challenge list item
  Widget _buildChallengeListItem(Map<String, dynamic> challenge, bool isDarkMode, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeDetailScreen(challenge: challenge),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isDarkMode
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Challenge image/icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (challenge['color'] as Color).withOpacity(0.8),
                    (challenge['color'] as Color),
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  _getCategoryIcon(challenge['category'] as String),
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            
            // Challenge details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Difficulty and points badges
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(challenge['difficulty'] as String).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getDifficultyIcon(challenge['difficulty'] as String),
                                color: _getDifficultyColor(challenge['difficulty'] as String),
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                challenge['difficulty'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getDifficultyColor(challenge['difficulty'] as String),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.emoji_events,
                                color: Color(0xFFFFD700),
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${challenge['points']} pts',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Challenge name
                    Text(
                      challenge['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Participants and duration
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 12,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${challenge['participants']} participants',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.timer,
                          size: 12,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          challenge['duration'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Start Challenge button
                    SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChallengeDetailScreen(challenge: challenge),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54408C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: const Text(
                          'Start Challenge',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required bool isDarkMode,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
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
  
  Widget _buildChallengeCard(Map<String, dynamic> challenge, bool isDarkMode, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to challenge detail screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeDetailScreen(challenge: challenge),
          ),
        );
      },
      child: Hero(
        tag: 'challenge-${challenge['name']}',
        child: Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDarkMode
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Challenge image
              Stack(
                children: [
                  Container(
                    height: 100, // Reduced height to prevent overflow
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          (challenge['color'] as Color).withOpacity(0.8),
                          (challenge['color'] as Color),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _getCategoryIcon(challenge['category'] as String),
                        color: Colors.white,
                        size: 40, // Reduced size
                      ),
                    ),
                  ),
                  
                  // Difficulty badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(challenge['difficulty'] as String).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getDifficultyIcon(challenge['difficulty'] as String),
                            color: Colors.white,
                            size: 8,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            challenge['difficulty'] as String,
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Points badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            color: Color(0xFFFFD700),
                            size: 8,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${challenge['points']} pts',
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              // Challenge details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Challenge name
                      Text(
                        challenge['name'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Participants
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 10,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              '${challenge['participants']} participants',
                              style: TextStyle(
                                fontSize: 10,
                                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 2),
                      
                      // Duration
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 10,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              challenge['duration'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Start Challenge button
                      SizedBox(
                        width: double.infinity,
                        height: 28, // Fixed height
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChallengeDetailScreen(challenge: challenge),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF54408C),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 0),
                          ),
                          child: const Text(
                            'Start Challenge',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showFilterDialog(BuildContext context, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Challenges',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Category filter
            Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return FilterChip(
                  selected: isSelected,
                  label: Text(filter),
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = filter;
                    });
                    Navigator.pop(context);
                  },
                  backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  selectedColor: const Color(0xFF54408C).withOpacity(0.2),
                  checkmarkColor: const Color(0xFF54408C),
                  labelStyle: TextStyle(
                    color: isSelected 
                        ? const Color(0xFF54408C) 
                        : (isDarkMode ? Colors.white : Colors.black),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected 
                          ? const Color(0xFF54408C) 
                          : Colors.transparent,
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 20),
            
            // Difficulty filter
            Text(
              'Difficulty',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['All', 'Beginner', 'Intermediate', 'Advanced'].map((difficulty) {
                return FilterChip(
                  selected: false,
                  label: Text(difficulty),
                  onSelected: (selected) {
                    // Apply difficulty filter
                    Navigator.pop(context);
                  },
                  backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  selectedColor: _getDifficultyColor(difficulty).withOpacity(0.2),
                  checkmarkColor: _getDifficultyColor(difficulty),
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 20),
            
            // Points filter
            Text(
              'Points',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['All', 'Under 50', '50-100', '100+'].map((points) {
                return FilterChip(
                  selected: false,
                  label: Text(points),
                  onSelected: (selected) {
                    // Apply points filter
                    Navigator.pop(context);
                  },
                  backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  selectedColor: const Color(0xFF54408C).withOpacity(0.2),
                  checkmarkColor: const Color(0xFF54408C),
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 20),
            
            // Apply and Reset buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Reset filters
                      setState(() {
                        _selectedFilter = 'All';
                      });
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDarkMode ? Colors.white : Colors.black,
                      side: BorderSide(
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply filters
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF54408C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
            
            // Add extra padding for bottom safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
  
  // Get filtered and sorted challenges
  List<Map<String, dynamic>> _getFilteredChallenges() {
    // Get all challenges
    final List<Map<String, dynamic>> allChallenges = _getChallenges();
    
    // Filter by category
    List<Map<String, dynamic>> filteredChallenges = _selectedFilter == 'All'
        ? allChallenges
        : allChallenges.where((challenge) => challenge['category'] == _selectedFilter).toList();
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredChallenges = filteredChallenges.where((challenge) {
        final name = (challenge['name'] as String).toLowerCase();
        final category = (challenge['category'] as String).toLowerCase();
        final difficulty = (challenge['difficulty'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();
        
        return name.contains(query) || category.contains(query) || difficulty.contains(query);
      }).toList();
    }
    
    // Sort challenges
    switch (_sortOption) {
      case 'Popular':
        filteredChallenges.sort((a, b) => (b['participants'] as int).compareTo(a['participants'] as int));
        break;
      case 'Newest':
        // For demo purposes, we'll just keep the current order
        break;
      case 'Highest Points':
        filteredChallenges.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
        break;
      case 'Most Participants':
        filteredChallenges.sort((a, b) => (b['participants'] as int).compareTo(a['participants'] as int));
        break;
    }
    
    return filteredChallenges;
  }
  
  List<Map<String, dynamic>> _getChallenges() {
    // Dummy data for challenges
    final List<Map<String, dynamic>> allChallenges = [
      {
        'name': 'Responsive Portfolio with HTML & CSS',
        'category': 'HTML',
        'difficulty': 'Beginner',
        'participants': 1245,
        'duration': '2-3 hours',
        'image': 'assets/images/home/challenge.png',
        'color': const Color(0xFFE44D26),
        'points': 50,
        'questions': [
          {
            'question': 'What HTML tag is used to define a responsive image?',
            'options': ['<img>', '<picture>', '<responsive-img>', '<flex-img>'],
            'answer': 0,
            'explanation': 'The <img> tag with proper attributes like max-width:100% in CSS makes images responsive.'
          },
          {
            'question': 'Which CSS property is used to make a layout responsive?',
            'options': ['responsive-design', 'flex-wrap', 'media-query', '@media'],
            'answer': 3,
            'explanation': '@media queries allow you to apply different styles for different devices/screen sizes.'
          },
          {
            'question': 'What is the viewport meta tag used for?',
            'options': [
              'To set the background color',
              'To control the page width and scaling on different devices',
              'To improve SEO',
              'To add animations'
            ],
            'answer': 1,
            'explanation': 'The viewport meta tag ensures proper scaling of the page on different devices.'
          }
        ]
      },
      {
        'name': '30-Minute CSS Art Challenge',
        'category': 'CSS',
        'difficulty': 'Intermediate',
        'participants': 876,
        'duration': '30 minutes',
        'image': 'assets/images/home/challenge.png',
        'color': const Color(0xFF264DE4),
        'points': 75,
        'questions': [
          {
            'question': 'Which CSS property is used to create rounded corners?',
            'options': ['border-round', 'corner-radius', 'border-radius', 'rounded-corners'],
            'answer': 2,
            'explanation': 'border-radius is used to create rounded corners on elements.'
          },
          {
            'question': 'What does CSS stand for?',
            'options': ['Creative Style Sheets', 'Computer Style Sheets', 'Cascading Style Sheets', 'Colorful Style Sheets'],
            'answer': 2,
            'explanation': 'CSS stands for Cascading Style Sheets.'
          },
          {
            'question': 'Which property is used to create shadow effects on text?',
            'options': ['text-shadow', 'font-shadow', 'text-effect', 'shadow-text'],
            'answer': 0,
            'explanation': 'text-shadow is used to add shadow effects to text.'
          }
        ]
      },
      {
        'name': 'Build a To-Do App in JavaScript',
        'category': 'JavaScript',
        'difficulty': 'Intermediate',
        'participants': 2134,
        'duration': '1-2 hours',
        'image': 'assets/images/home/challenge.png',
        'color': const Color(0xFFF7DF1E),
        'points': 100,
        'questions': [
          {
            'question': 'Which method is used to add an element at the end of an array?',
            'options': ['push()', 'append()', 'addToEnd()', 'insert()'],
            'answer': 0,
            'explanation': 'The push() method adds one or more elements to the end of an array.'
          },
          {
            'question': 'How do you store data in local storage using JavaScript?',
            'options': [
              'localStorage.setData(key, value)',
              'localStorage.setItem(key, value)',
              'localStorage.store(key, value)',
              'localStorage.save(key, value)'
            ],
            'answer': 1,
            'explanation': 'localStorage.setItem(key, value) is used to store data in local storage.'
          },
          {
            'question': 'Which event is triggered when a user clicks on an HTML element?',
            'options': ['onmouseover', 'onchange', 'onclick', 'onmouseclick'],
            'answer': 2,
            'explanation': 'The onclick event is triggered when a user clicks on an HTML element.'
          }
        ]
      },
      {
        'name': 'API Fetch & Display with React',
        'category': 'React',
        'difficulty': 'Advanced',
        'participants': 1567,
        'duration': '2-3 hours',
        'image': 'assets/images/home/challenge.png',
        'color': const Color(0xFF61DAFB),
        'points': 150,
        'questions': [
          {
            'question': 'Which hook is used to perform side effects in a React component?',
            'options': ['useState', 'useEffect', 'useContext', 'useReducer'],
            'answer': 1,
            'explanation': 'useEffect is used to perform side effects like data fetching in React components.'
          },
          {
            'question': 'What is the correct way to make an API call in React?',
            'options': [
              'Using the API component',
              'Using the fetch() function or axios library',
              'Using the React.api() method',
              'Using the connect() function'
            ],
            'answer': 1,
            'explanation': 'The fetch() function or libraries like axios are commonly used to make API calls in React.'
          },
          {
            'question': 'What does JSX stand for?',
            'options': ['JavaScript XML', 'JavaScript Extension', 'JavaScript Syntax', 'Java Syntax Extension'],
            'answer': 0,
            'explanation': 'JSX stands for JavaScript XML, which is a syntax extension for JavaScript recommended by React.'
          }
        ]
      },
      {
        'name': 'Create a Calculator in Flutter',
        'category': 'Flutter',
        'difficulty': 'Intermediate',
        'participants': 987,
        'duration': '3-4 hours',
        'image': 'assets/images/home/challenge.png',
        'color': const Color(0xFF54C5F8),
        'points': 125,
        'questions': [
          {
            'question': 'Which widget is used to create a button in Flutter?',
            'options': ['Button', 'FlatButton', 'ElevatedButton', 'PressButton'],
            'answer': 2,
            'explanation': 'ElevatedButton is a Material Design button that is raised and has a shadow.'
          },
          {
            'question': 'What is the main building block of Flutter UI?',
            'options': ['Components', 'Elements', 'Widgets', 'Blocks'],
            'answer': 2,
            'explanation': 'Widgets are the main building blocks of Flutter UI.'
          },
          {
            'question': 'Which Flutter widget is used to create a grid layout?',
            'options': ['GridView', 'TableView', 'ListView', 'ColumnView'],
            'answer': 0,
            'explanation': 'GridView is used to create a grid of widgets in Flutter.'
          }
        ]
      }
    ];
    
    return allChallenges;
  }
  
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return const Color(0xFF43A047);
      case 'Intermediate':
        return const Color(0xFFFFA000);
      case 'Advanced':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF54408C);
    }
  }
  
  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return Icons.star_border;
      case 'Intermediate':
        return Icons.star_half;
      case 'Advanced':
        return Icons.star;
      default:
        return Icons.star_border;
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
