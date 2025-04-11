import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../providers/theme_provider.dart';
import '../../widgets/custom_buttom_nav_bar.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _sortOption = 'Latest';
  final List<String> _categories = ['All', 'HTML', 'CSS', 'JavaScript', 'React', 'Flutter', 'Python', 'Java'];
  final List<String> _sortOptions = ['Latest', 'Most Liked', 'Most Discussed', 'Trending'];
  
  // State for expanded replies
  final Map<int, bool> _expandedReplies = {};
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  void _toggleLike(int postId) {
    setState(() {
      final posts = _getMockPosts();
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      
      if (postIndex != -1) {
        final post = posts[postIndex];
        if (post['userLiked'] == true) {
          post['likes'] = (post['likes'] as int) - 1;
          post['userLiked'] = false;
        } else {
          // If disliked, remove the dislike first
          if (post['userDisliked'] == true) {
            post['dislikes'] = (post['dislikes'] as int) - 1;
            post['userDisliked'] = false;
          }
          post['likes'] = (post['likes'] as int) + 1;
          post['userLiked'] = true;
        }
      }
    });
  }
  
  void _toggleDislike(int postId) {
    setState(() {
      final posts = _getMockPosts();
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      
      if (postIndex != -1) {
        final post = posts[postIndex];
        if (post['userDisliked'] == true) {
          post['dislikes'] = (post['dislikes'] as int) - 1;
          post['userDisliked'] = false;
        } else {
          // If liked, remove the like first
          if (post['userLiked'] == true) {
            post['likes'] = (post['likes'] as int) - 1;
            post['userLiked'] = false;
          }
          post['dislikes'] = (post['dislikes'] as int) + 1;
          post['userDisliked'] = true;
        }
      }
    });
  }
  
  void _toggleReplyLike(int postId, int replyId) {
    setState(() {
      final posts = _getMockPosts();
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      
      if (postIndex != -1) {
        final post = posts[postIndex];
        final replies = post['replies'] as List<Map<String, dynamic>>;
        final replyIndex = replies.indexWhere((reply) => reply['id'] == replyId);
        
        if (replyIndex != -1) {
          final reply = replies[replyIndex];
          if (reply['userLiked'] == true) {
            reply['likes'] = (reply['likes'] as int) - 1;
            reply['userLiked'] = false;
          } else {
            // If disliked, remove the dislike first
            if (reply['userDisliked'] == true) {
              reply['dislikes'] = (reply['dislikes'] as int) - 1;
              reply['userDisliked'] = false;
            }
            reply['likes'] = (reply['likes'] as int) + 1;
            reply['userLiked'] = true;
          }
        }
      }
    });
  }
  
  void _toggleReplyDislike(int postId, int replyId) {
    setState(() {
      final posts = _getMockPosts();
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      
      if (postIndex != -1) {
        final post = posts[postIndex];
        final replies = post['replies'] as List<Map<String, dynamic>>;
        final replyIndex = replies.indexWhere((reply) => reply['id'] == replyId);
        
        if (replyIndex != -1) {
          final reply = replies[replyIndex];
          if (reply['userDisliked'] == true) {
            reply['dislikes'] = (reply['dislikes'] as int) - 1;
            reply['userDisliked'] = false;
          } else {
            // If liked, remove the like first
            if (reply['userLiked'] == true) {
              reply['likes'] = (reply['likes'] as int) - 1;
              reply['userLiked'] = false;
            }
            reply['dislikes'] = (reply['dislikes'] as int) + 1;
            reply['userDisliked'] = true;
          }
        }
      }
    });
  }
  
  void _toggleReplies(int postId) {
    setState(() {
      _expandedReplies[postId] = !(_expandedReplies[postId] ?? false);
    });
  }
  
  void _showReplyDialog(BuildContext context, int postId, bool isDarkMode) {
    final TextEditingController replyController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
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
            Text(
              'Add Reply',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: replyController,
              maxLines: 5,
              minLines: 3,
              decoration: InputDecoration(
                hintText: 'Write your reply...',
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
                filled: true,
                fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (replyController.text.trim().isNotEmpty) {
                      // Add reply logic here
                      setState(() {
                        final posts = _getMockPosts();
                        final postIndex = posts.indexWhere((post) => post['id'] == postId);
                        
                        if (postIndex != -1) {
                          final post = posts[postIndex];
                          final replies = post['replies'] as List<Map<String, dynamic>>;
                          
                          // Create a new reply
                          final newReply = {
                            'id': DateTime.now().millisecondsSinceEpoch,
                            'username': 'You',
                            'avatar': 'assets/images/profile/avatar.png',
                            'content': replyController.text.trim(),
                            'timestamp': DateTime.now(),
                            'likes': 0,
                            'dislikes': 0,
                            'userLiked': false,
                            'userDisliked': false,
                          };
                          
                          replies.add(newReply as Map<String, dynamic>);
                          
                          // Ensure replies are expanded
                          _expandedReplies[postId] = true;
                        }
                      });
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF54408C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Post Reply'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ).then((_) {
      replyController.dispose();
    });
  }
  
  void _showNewPostDialog(BuildContext context, bool isDarkMode) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    String selectedCategory = 'Flutter';
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
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
              Text(
                'Create New Post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              
              // Title field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Post Title',
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              
              // Category dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    dropdownColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    hint: Text(
                      'Select Category',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    items: _categories.where((c) => c != 'All').map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Content field
              TextField(
                controller: contentController,
                maxLines: 8,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your post...',
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  filled: true,
                  fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              
              // Add code snippet option
              GestureDetector(
                onTap: () {
                  // Add code snippet functionality
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF54408C).withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.code,
                        size: 16,
                        color: const Color(0xFF54408C),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Add Code Snippet',
                        style: TextStyle(
                          color: const Color(0xFF54408C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty && 
                          contentController.text.trim().isNotEmpty) {
                        // Add post logic here
                        setState(() {
                          // In a real app, you would add this to your database
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Post created successfully!'),
                              backgroundColor: Color(0xFF54408C),
                            ),
                          );
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF54408C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: const Text('Post'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ).then((_) {
      titleController.dispose();
      contentController.dispose();
    });
  }
  
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
        });
      }
    });
  }
  
  IconData _getSortIcon(String option) {
    switch (option) {
      case 'Latest':
        return Icons.access_time;
      case 'Most Liked':
        return Icons.thumb_up;
      case 'Most Discussed':
        return Icons.forum;
      case 'Trending':
        return Icons.trending_up;
      default:
        return Icons.sort;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        title: Text(
          'Coding Forum',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {
              // Show search dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                  title: Text(
                    'Search Forum',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter keywords to search',
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF54408C),
          labelColor: const Color(0xFF54408C),
          unselectedLabelColor: isDarkMode ? Colors.white70 : Colors.black54,
          tabs: const [
            Tab(text: 'All Posts'),
            Tab(text: 'My Posts'),
            Tab(text: 'Bookmarked'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Category filter
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    // Sort button
                    GestureDetector(
                      onTap: () {
                        _showSortOptions(context, isDarkMode);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
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
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(category),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
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
          
          // Forum posts
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All Posts Tab
                _buildPostsList(isDarkMode),
                
                // My Posts Tab
                _buildMyPostsList(isDarkMode),
                
                // Bookmarked Tab
                _buildBookmarkedList(isDarkMode),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2, // Set to 2 for Forum tab
        context: context,
        isDarkMode: isDarkMode,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF54408C),
        child: const Icon(Icons.add),
        onPressed: () {
          _showNewPostDialog(context, isDarkMode);
        },
      ),
    );
  
  }
  
  Widget _buildPostsList(bool isDarkMode) {
    final posts = _getFilteredPosts();
    
    if (posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.forum,
              size: 64,
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'No posts found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first to start a discussion!',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white54 : Colors.black38,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPostCard(post, isDarkMode);
      },
    );
  }
  
  Widget _buildMyPostsList(bool isDarkMode) {
    // In a real app, you would filter posts by the current user
    final myPosts = _getMockPosts().where((post) => post['username'] == 'You').toList();
    
    if (myPosts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 64,
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'You haven\'t posted yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your posts will appear here',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white54 : Colors.black38,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showNewPostDialog(context, isDarkMode);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF54408C),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text('Create a Post'),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: myPosts.length,
      itemBuilder: (context, index) {
        final post = myPosts[index];
        return _buildPostCard(post, isDarkMode);
      },
    );
  }
  
  Widget _buildBookmarkedList(bool isDarkMode) {
    // In a real app, you would filter posts that are bookmarked by the user
    final bookmarkedPosts = _getMockPosts().where((post) => post['bookmarked'] == true).toList();
    
    if (bookmarkedPosts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark,
              size: 64,
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'No bookmarked posts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bookmark posts to find them easily later',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white54 : Colors.black38,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(),
      itemCount: bookmarkedPosts.length,
      itemBuilder: (context, index) {
        final post = bookmarkedPosts[index];
        return _buildPostCard(post, isDarkMode);
      },
    );
  }
  
  Widget _buildPostCard(Map<String, dynamic> post, bool isDarkMode) {
    final isExpanded = _expandedReplies[post['id']] ?? false;
    final replies = post['replies'] as List<Map<String, dynamic>>;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info and timestamp
                Row(
                  children: [
                    // User avatar
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(post['avatar'] as String),
                    ),
                    const SizedBox(width: 12),
                    // Username and timestamp
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['username'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            timeago.format(post['timestamp'] as DateTime),
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode ? Colors.white54 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(post['category'] as String).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        post['category'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getCategoryColor(post['category'] as String),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Post title
                Text(
                  post['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Post content
                Text(
                  post['content'] as String,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                
                // Code snippet if exists
                if (post['codeSnippet'] != null)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              post['codeLanguage'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.copy, size: 16),
                                  color: isDarkMode ? Colors.white70 : Colors.black54,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    // Copy code to clipboard
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Code copied to clipboard'),
                                        backgroundColor: Color(0xFF54408C),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post['codeSnippet'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // Post actions
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                // Like button
                GestureDetector(
                  onTap: () => _toggleLike(post['id'] as int),
                  child: Row(
                    children: [
                      Icon(
                        post['userLiked'] == true ? Icons.thumb_up : Icons.thumb_up_outlined,
                        size: 16,
                        color: post['userLiked'] == true 
                            ? const Color(0xFF54408C) 
                            : (isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post['likes']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: post['userLiked'] == true 
                              ? const Color(0xFF54408C) 
                              : (isDarkMode ? Colors.white70 : Colors.black54),
                          fontWeight: post['userLiked'] == true ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Dislike button
                GestureDetector(
                  onTap: () => _toggleDislike(post['id'] as int),
                  child: Row(
                    children: [
                      Icon(
                        post['userDisliked'] == true ? Icons.thumb_down : Icons.thumb_down_outlined,
                        size: 16,
                        color: post['userDisliked'] == true 
                            ? Colors.red.shade700 
                            : (isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post['dislikes']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: post['userDisliked'] == true 
                              ? Colors.red.shade700 
                              : (isDarkMode ? Colors.white70 : Colors.black54),
                          fontWeight: post['userDisliked'] == true ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Reply button
                GestureDetector(
                  onTap: () => _showReplyDialog(context, post['id'] as int, isDarkMode),
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply,
                        size: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Bookmark button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      post['bookmarked'] = !(post['bookmarked'] as bool);
                    });
                  },
                  child: Icon(
                    post['bookmarked'] == true ? Icons.bookmark : Icons.bookmark_border,
                    size: 16,
                    color: post['bookmarked'] == true 
                        ? const Color(0xFF54408C) 
                        : (isDarkMode ? Colors.white70 : Colors.black54),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Share button
                GestureDetector(
                  onTap: () {
                    // Share functionality
                  },
                  child: Icon(
                    Icons.share,
                    size: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          
          // Replies section
          if (replies.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Replies header
                  GestureDetector(
                    onTap: () => _toggleReplies(post['id'] as int),
                    child: Row(
                      children: [
                        Text(
                          '${replies.length} ${replies.length == 1 ? 'Reply' : 'Replies'}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 16,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ],
                    ),
                  ),
                  
                  // Replies list
                  if (isExpanded)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: replies.length,
                      itemBuilder: (context, index) {
                        final reply = replies[index];
                        return _buildReplyItem(reply, post['id'] as int, isDarkMode, replies);
                      },
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildReplyItem(Map<String, dynamic> reply, int postId, bool isDarkMode, List<Map<String, dynamic>> replies) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reply header
          Row(
            children: [
              // User avatar
              CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(reply['avatar'] as String),
              ),
              const SizedBox(width: 8),
              // Username and timestamp
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reply['username'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      timeago.format(reply['timestamp'] as DateTime),
                      style: TextStyle(
                        fontSize: 10,
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Reply content
          Padding(
            padding: const EdgeInsets.only(left: 36, top: 4),
            child: Text(
              reply['content'] as String,
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          
          // Reply actions
          Padding(
            padding: const EdgeInsets.only(left: 36, top: 8),
            child: Row(
              children: [
                // Like button
                GestureDetector(
                  onTap: () => _toggleReplyLike(postId, reply['id'] as int),
                  child: Row(
                    children: [
                      Icon(
                        reply['userLiked'] == true ? Icons.thumb_up : Icons.thumb_up_outlined,
                        size: 12,
                        color: reply['userLiked'] == true 
                            ? const Color(0xFF54408C) 
                            : (isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reply['likes']}',
                        style: TextStyle(
                          fontSize: 10,
                          color: reply['userLiked'] == true 
                              ? const Color(0xFF54408C) 
                              : (isDarkMode ? Colors.white70 : Colors.black54),
                          fontWeight: reply['userLiked'] == true ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Dislike button
                GestureDetector(
                  onTap: () => _toggleReplyDislike(postId, reply['id'] as int),
                  child: Row(
                    children: [
                      Icon(
                        reply['userDisliked'] == true ? Icons.thumb_down : Icons.thumb_down_outlined,
                        size: 12,
                        color: reply['userDisliked'] == true 
                            ? Colors.red.shade700 
                            : (isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reply['dislikes']}',
                        style: TextStyle(
                          fontSize: 10,
                          color: reply['userDisliked'] == true 
                              ? Colors.red.shade700 
                              : (isDarkMode ? Colors.white70 : Colors.black54),
                          fontWeight: reply['userDisliked'] == true ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Reply button
                GestureDetector(
                  onTap: () => _showReplyDialog(context, postId, isDarkMode),
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply,
                        size: 12,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Reply',
                        style: TextStyle(
                          fontSize: 10,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          if (reply != replies.last)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Divider(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                height: 1,
              ),
            ),
        ],
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredPosts() {
    final allPosts = _getMockPosts();
    
    // Filter by category
    List<Map<String, dynamic>> filteredPosts = _selectedCategory == 'All'
        ? allPosts
        : allPosts.where((post) => post['category'] == _selectedCategory).toList();
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredPosts = filteredPosts.where((post) {
        final title = (post['title'] as String).toLowerCase();
        final content = (post['content'] as String).toLowerCase();
        final username = (post['username'] as String).toLowerCase();
        final category = (post['category'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();
        
        return title.contains(query) || 
               content.contains(query) || 
               username.contains(query) || 
               category.contains(query);
      }).toList();
    }
    
    // Sort posts
    switch (_sortOption) {
      case 'Latest':
        filteredPosts.sort((a, b) => (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime));
        break;
      case 'Most Liked':
        filteredPosts.sort((a, b) => (b['likes'] as int).compareTo(a['likes'] as int));
        break;
      case 'Most Discussed':
        filteredPosts.sort((a, b) => (b['replies'] as List).length.compareTo((a['replies'] as List).length));
        break;
      case 'Trending':
        // For demo purposes, we'll sort by a combination of likes and replies
        filteredPosts.sort((a, b) {
          final aScore = (a['likes'] as int) + ((a['replies'] as List).length * 2);
          final bScore = (b['likes'] as int) + ((b['replies'] as List).length * 2);
          return bScore.compareTo(aScore);
        });
        break;
    }
    
    return filteredPosts;
  }
  
  List<Map<String, dynamic>> _getMockPosts() {
    // This would normally come from a database
    return [
      {
        'id': 1,
        'username': 'CodeMaster',
        'avatar': 'assets/images/profile/avatar.png',
        'title': 'How to implement a responsive layout in Flutter?',
        'content': 'I\'m trying to create a responsive layout that works well on both mobile and tablet. What\'s the best approach to handle different screen sizes in Flutter?',
        'category': 'Flutter',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'likes': 24,
        'dislikes': 2,
        'userLiked': false,
        'userDisliked': false,
        'bookmarked': true,
        'replies': [
          {
            'id': 101,
            'username': 'FlutterDev',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'I recommend using LayoutBuilder and MediaQuery to check the screen size and adjust your UI accordingly. For more complex layouts, you can use packages like flutter_responsive_framework.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
            'likes': 12,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 102,
            'username': 'DartEnthusiast',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Another approach is to use the Expanded and Flexible widgets to create layouts that adapt to different screen sizes. This works well for simpler UIs.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
            'likes': 8,
            'dislikes': 1,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 103,
            'username': 'You',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Thanks for the suggestions! I\'ll try using LayoutBuilder and see how it works for my app.',
            'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
            'likes': 3,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
        ],
      },
      {
        'id': 2,
        'username': 'WebWizard',
        'avatar': 'assets/images/profile/avatar.png',
        'title': 'Best practices for CSS Grid vs Flexbox',
        'content': 'When should I use CSS Grid and when should I use Flexbox? I\'m working on a complex layout and I\'m not sure which one would be more appropriate.',
        'category': 'CSS',
        'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
        'likes': 42,
        'dislikes': 3,
        'userLiked': false,
        'userDisliked': false,
        'bookmarked': false,
        'codeSnippet': '.container {\n  display: grid;\n  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));\n  gap: 20px;\n}',
        'codeLanguage': 'CSS',
        'replies': [
          {
            'id': 201,
            'username': 'CSSGuru',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Use Flexbox for one-dimensional layouts (either rows OR columns) and Grid for two-dimensional layouts (rows AND columns). Grid is great for overall page layout, while Flexbox is perfect for components.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
            'likes': 18,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 202,
            'username': 'FrontEndDev',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'I often use both in the same project. Grid for the main layout structure and Flexbox for aligning items within those grid areas.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
            'likes': 15,
            'dislikes': 1,
            'userLiked': false,
            'userDisliked': false,
          },
        ],
      },
      {
        'id': 3,
        'username': 'JSNinja',
        'avatar': 'assets/images/profile/avatar.png',
        'title': 'Understanding async/await in JavaScript',
        'content': 'I\'m having trouble understanding how async/await works in JavaScript. Can someone explain it in simple terms with examples?',
        'category': 'JavaScript',
        'timestamp': DateTime.now().subtract(const Duration(hours: 8)),
        'likes': 56,
        'dislikes': 1,
        'userLiked': false,
        'userDisliked': false,
        'bookmarked': false,
        'codeSnippet': 'async function fetchData() {\n  try {\n    const response = await fetch(\'https://api.example.com/data\');\n    const data = await response.json();\n    return data;\n  } catch (error) {\n    console.error(\'Error:\', error);\n  }\n}',
        'codeLanguage': 'JavaScript',
        'replies': [
          {
            'id': 301,
            'username': 'AsyncMaster',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Think of async/await as a way to write asynchronous code that looks synchronous. The async keyword tells JavaScript that a function returns a promise, and await pauses the execution until that promise is resolved.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 7)),
            'likes': 32,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 302,
            'username': 'PromiseExpert',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'It\'s like telling JavaScript: "Wait for this operation to complete before moving on to the next line." This makes your code easier to read and debug compared to chaining .then() calls.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 6)),
            'likes': 28,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
        ],
      },
      {
        'id': 4,
        'username': 'ReactRookie',
        'avatar': 'assets/images/profile/avatar.png',
        'title': 'State management in React: Context API vs Redux',
        'content': 'I\'m building a medium-sized React application and I\'m trying to decide between using Context API or Redux for state management. What are the pros and cons of each approach?',
        'category': 'React',
        'timestamp': DateTime.now().subtract(const Duration(hours: 12)),
        'likes': 38,
        'dislikes': 4,
        'userLiked': false,
        'userDisliked': false,
        'bookmarked': true,
        'replies': [
          {
            'id': 401,
            'username': 'ReduxFan',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Redux is great for complex applications with lots of state changes. It provides a predictable state container, middleware support, and great dev tools. However, it adds boilerplate code and complexity.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 11)),
            'likes': 15,
            'disl ikes': 2,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 402,
            'username': 'ContextLover',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Context API is built into React and is simpler to set up. It\'s perfect for smaller apps or when you just need to avoid prop drilling. For medium-sized apps, you might want to combine it with useReducer for more Redux-like state management.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 10)),
            'likes': 20,
            'dislikes': 1,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 403,
            'username': 'ModernReact',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Consider using Zustand or Jotai as alternatives. They provide Redux-like state management with less boilerplate and better TypeScript support.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 9)),
            'likes': 25,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
        ],
      },
      {
        'id': 5,
        'username': 'You',
        'avatar': 'assets/images/profile/avatar.png',
        'title': 'How to implement authentication in Flutter?',
        'content': 'I\'m working on a Flutter app and need to implement user authentication. What are the best practices and packages for handling login, registration, and session management?',
        'category': 'Flutter',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'likes': 15,
        'dislikes': 0,
        'userLiked': true,
        'userDisliked': false,
        'bookmarked': false,
        'replies': [
          {
            'id': 501,
            'username': 'FlutterAuth',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'Firebase Authentication is a popular choice for Flutter apps. It\'s easy to set up and provides many authentication methods out of the box (email/password, Google, Facebook, etc.).',
            'timestamp': DateTime.now().subtract(const Duration(hours: 22)),
            'likes': 8,
            'dislikes': 0,
            'userLiked': false,
            'userDisliked': false,
          },
          {
            'id': 502,
            'username': 'SecureApp',
            'avatar': 'assets/images/profile/avatar.png',
            'content': 'If you need more control, you can implement JWT authentication with a custom backend. Use the http package for API calls and flutter_secure_storage to store tokens securely.',
            'timestamp': DateTime.now().subtract(const Duration(hours: 20)),
            'likes': 6,
            'dislikes': 1,
            'userLiked': false,
            'userDisliked': false,
          },
        ],
      },
    ];
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'HTML':
        return const Color(0xFFE44D26);
      case 'CSS':
        return const Color(0xFF264DE4);
      case 'JavaScript':
        return const Color(0xFFF7DF1E);
      case 'React':
        return const Color(0xFF61DAFB);
      case 'Flutter':
        return const Color(0xFF54C5F8);
      case 'Python':
        return const Color(0xFF3776AB);
      case 'Java':
        return const Color(0xFFf89820);
      default:
        return const Color(0xFF54408C);
    }
  }
}