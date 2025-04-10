// lib/screens/home/training_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class TrainingScreen extends StatefulWidget {
  final String language;
  final Color languageColor;
  final Color languageBgColor;

  const TrainingScreen({
    Key? key, 
    required this.language, 
    required this.languageColor,
    required this.languageBgColor,
  }) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Learn', 'Examples', 'References', 'Exercises'];
  
  // Track expanded sections
  final Map<String, bool> _expandedSections = {
    'HTML Basics': true,
    'HTML Forms & Input': false,
    'HTML5 Features': false,
  };
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFEBEE),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black26 : Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "HTML",
                style: TextStyle(
                  color: const Color(0xFFE44D26),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Tutorial',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              // Show search dialog
            },
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Custom tab bar
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFFFEBEE),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _tabs.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedTabIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected 
                              ? const Color(0xFFE44D26)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: isSelected 
                              ? const Color(0xFFE44D26)
                              : (isDarkMode ? Colors.white70 : Colors.black54),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Main content
          Expanded(
            child: _buildTabContent(isDarkMode),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE44D26),
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          // Show a dialog to run code
          _showRunCodeDialog(context, isDarkMode);
        },
      ),
    );
  }
  
  Widget _buildTabContent(bool isDarkMode) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildLearnTab(isDarkMode);
      case 1:
        return _buildExamplesTab(isDarkMode);
      case 2:
        return _buildReferencesTab(isDarkMode);
      case 3:
        return _buildExercisesTab(isDarkMode);
      default:
        return _buildLearnTab(isDarkMode);
    }
  }
  
  Widget _buildLearnTab(bool isDarkMode) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // HTML Basics Section
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: Column(
            children: [
              // Section header
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedSections['HTML Basics'] = !(_expandedSections['HTML Basics'] ?? false);
                  });
                },
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Section icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE44D26).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.school,
                          color: Color(0xFFE44D26),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Section title and level
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HTML Basics',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF43A047).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Beginner',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF43A047),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Expand/collapse icon
                      Icon(
                        _expandedSections['HTML Basics'] ?? false ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Section content (lessons)
              if (_expandedSections['HTML Basics'] ?? false)
                Column(
                  children: [
                    _buildLessonItem(isDarkMode, 'Introduction to HTML', 1),
                    _buildLessonItem(isDarkMode, 'HTML Elements', 2),
                    _buildLessonItem(isDarkMode, 'HTML Attributes', 3),
                    _buildLessonItem(isDarkMode, 'HTML Headings', 4),
                    _buildLessonItem(isDarkMode, 'HTML Paragraphs', 5),
                    _buildLessonItem(isDarkMode, 'HTML Links', 6),
                  ],
                ),
            ],
          ),
        ),
        
        // HTML Forms & Input Section
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: Column(
            children: [
              // Section header
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedSections['HTML Forms & Input'] = !(_expandedSections['HTML Forms & Input'] ?? false);
                  });
                },
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Section icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE44D26).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.input,
                          color: Color(0xFFE44D26),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Section title and level
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HTML Forms & Input',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFA000).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Intermediate',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFA000),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Expand/collapse icon
                      Icon(
                        _expandedSections['HTML Forms & Input'] ?? false ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Section content (lessons)
              if (_expandedSections['HTML Forms & Input'] ?? false)
                Column(
                  children: [
                    _buildLessonItem(isDarkMode, 'HTML Forms', 1),
                    _buildLessonItem(isDarkMode, 'HTML Form Elements', 2),
                    _buildLessonItem(isDarkMode, 'HTML Input Types', 3),
                    _buildLessonItem(isDarkMode, 'HTML Input Attributes', 4),
                    _buildLessonItem(isDarkMode, 'HTML Form Examples', 5),
                  ],
                ),
            ],
          ),
        ),
        
        // HTML5 Features Section
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: Column(
            children: [
              // Section header
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedSections['HTML5 Features'] = !(_expandedSections['HTML5 Features'] ?? false);
                  });
                },
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Section icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE44D26).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.psychology,
                          color: Color(0xFFE44D26),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Section title and level
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HTML5 Features',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE53935).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Advanced',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE53935),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Expand/collapse icon
                      Icon(
                        _expandedSections['HTML5 Features'] ?? false ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Section content (lessons)
              if (_expandedSections['HTML5 Features'] ?? false)
                Column(
                  children: [
                    _buildLessonItem(isDarkMode, 'HTML5 Semantic Elements', 1),
                    _buildLessonItem(isDarkMode, 'HTML5 Audio & Video', 2),
                    _buildLessonItem(isDarkMode, 'HTML5 Canvas', 3),
                    _buildLessonItem(isDarkMode, 'HTML5 SVG', 4),
                    _buildLessonItem(isDarkMode, 'HTML5 Geolocation', 5),
                    _buildLessonItem(isDarkMode, 'HTML5 Drag and Drop', 6),
                    _buildLessonItem(isDarkMode, 'HTML5 Web Storage', 7),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildLessonItem(bool isDarkMode, String lessonTitle, int index) {
    return InkWell(
      onTap: () {
        _showLessonContent(context, isDarkMode, 'HTML Basics', lessonTitle);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFFE44D26).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE44D26),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                lessonTitle,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isDarkMode ? Colors.white54 : Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildExamplesTab(bool isDarkMode) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildExampleCard(
          isDarkMode,
          title: 'Hello World Example',
          description: 'A simple HTML example to get started',
          codeSnippet: '''<!DOCTYPE html>
<html>
<head>
  <title>Hello World</title>
</head>
<body>
  <h1>Hello, World!</h1>
  <p>This is my first HTML page.</p>
</body>
</html>''',
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          isDarkMode,
          title: 'Form Example',
          description: 'How to create a form in HTML',
          codeSnippet: '''<!DOCTYPE html>
<html>
<head>
  <title>Form Example</title>
</head>
<body>
  <h2>Contact Form</h2>
  <form action="/submit-form" method="post">
    <div>
      <label for="name">Name:</label>
      <input type="text" id="name" name="name" required>
    </div>
    <div>
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>
    </div>
    <div>
      <label for="message">Message:</label>
      <textarea id="message" name="message" rows="4" required></textarea>
    </div>
    <button type="submit">Submit</button>
  </form>
</body>
</html>''',
        ),
        const SizedBox(height: 16),
        _buildExampleCard(
          isDarkMode,
          title: 'Responsive Layout Example',
          description: 'Create responsive layouts with HTML',
          codeSnippet: '''<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Responsive Layout</title>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
    }
    
    header {
      background-color: #333;
      color: white;
      padding: 1rem;
    }
    
    nav ul {
      display: flex;
      list-style: none;
    }
    
    nav ul li {
      margin-right: 1rem;
    }
    
    nav ul li a {
      color: white;
      text-decoration: none;
    }
    
    .container {
      display: flex;
      flex-wrap: wrap;
      padding: 1rem;
    }
    
    .content {
      flex: 2;
      padding: 1rem;
    }
    
    .sidebar {
      flex: 1;
      background-color: #f4f4f4;
      padding: 1rem;
    }
    
    @media (max-width: 768px) {
      nav ul {
        flex-direction: column;
      }
      
      .container {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
  <header>
    <h1>My Responsive Website</h1>
    <nav>
      <ul>
        <li><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Services</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
    </nav>
  </header>
  
  <div class="container">
    <section class="content">
      <h2>Main Content</h2>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </section>
    
    <aside class="sidebar">
      <h3>Sidebar</h3>
      <p>Additional information here.</p>
    </aside>
  </div>
</body>
</html>''',
        ),
      ],
    );
  }
  
  Widget _buildExampleCard(
    bool isDarkMode, {
    required String title,
    required String description,
    required String codeSnippet,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF0D1117) : const Color(0xFFF6F8FA),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Code Example',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            size: 18,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                          onPressed: () {
                            // Copy code to clipboard
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Code copied to clipboard'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            size: 18,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                          onPressed: () {
                            _showRunCodeDialog(context, isDarkMode);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  codeSnippet,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReferencesTab(bool isDarkMode) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildReferenceSection(
          isDarkMode,
          title: 'HTML Tags',
          items: [
            {'name': '<html>', 'description': 'Defines an HTML document'},
            {'name': '<head>', 'description': 'Contains metadata about the document'},
            {'name': '<body>', 'description': 'Contains the visible page content'},
            {'name': '<h1> to <h6>', 'description': 'Defines HTML headings'},
            {'name': '<p>', 'description': 'Defines a paragraph'},
          ],
        ),
        const SizedBox(height: 24),
        _buildReferenceSection(
          isDarkMode,
          title: 'HTML Attributes',
          items: [
            {'name': 'id', 'description': 'Specifies a unique id for an element'},
            {'name': 'class', 'description': 'Specifies one or more class names for an element'},
            {'name': 'style', 'description': 'Specifies an inline CSS style for an element'},
            {'name': 'src', 'description': 'Specifies the URL of the media file'},
            {'name': 'href', 'description': 'Specifies the URL of the link'},
          ],
        ),
        const SizedBox(height: 24),
        _buildReferenceSection(
          isDarkMode,
          title: 'HTML Events',
          items: [
            {'name': 'onclick', 'description': 'Occurs when the user clicks on an element'},
            {'name': 'onload', 'description': 'Occurs when a document has been loaded'},
            {'name': 'onchange', 'description': 'Occurs when the value of an element has been changed'},
            {'name': 'onmouseover', 'description': 'Occurs when the mouse pointer is moved onto an element'},
            {'name': 'onsubmit', 'description': 'Occurs when a form is submitted'},
          ],
        ),
      ],
    );
  }
  
  Widget _buildReferenceSection(
    bool isDarkMode, {
    required String title,
    required List<Map<String, String>> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(
              color: isDarkMode ? Colors.white12 : Colors.black12,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(
                  item['name']!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE44D26),
                  ),
                ),
                subtitle: Text(
                  item['description']!,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Color(0xFFE44D26),
                ),
                onTap: () {
                  // Show reference details
                },
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildExercisesTab(bool isDarkMode) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildExerciseCard(
          isDarkMode,
          title: 'Exercise 1: Hello World',
          description: 'Create a simple HTML program that displays "Hello, World!"',
          difficulty: 'Beginner',
        ),
        const SizedBox(height: 16),
        _buildExerciseCard(
          isDarkMode,
          title: 'Exercise 2: Form Validation',
          description: 'Create a form with validation using HTML and JavaScript',
          difficulty: 'Intermediate',
        ),
        const SizedBox(height: 16),
        _buildExerciseCard(
          isDarkMode,
          title: 'Exercise 3: Interactive App',
          description: 'Build a complete interactive application with HTML, CSS, and JavaScript',
          difficulty: 'Advanced',
        ),
      ],
    );
  }
  
  Widget _buildExerciseCard(
    bool isDarkMode, {
    required String title,
    required String description,
    required String difficulty,
  }) {
    final Color difficultyColor;
    switch (difficulty) {
      case 'Beginner':
        difficultyColor = const Color(0xFF43A047);
        break;
      case 'Intermediate':
        difficultyColor = const Color(0xFFFFA000);
        break;
      case 'Advanced':
        difficultyColor = const Color(0xFFE53935);
        break;
      default:
        difficultyColor = const Color(0xFF54408C);
    }
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: difficultyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: difficultyColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Show exercise details
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE44D26),
                      side: const BorderSide(color: Color(0xFFE44D26)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View Exercise'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Start exercise
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE44D26),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Start Exercise'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showLessonContent(BuildContext context, bool isDarkMode, String sectionTitle, String lessonTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF121212) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sectionTitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lessonTitle,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
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
              ),
              
              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Introduction
                    Text(
                      'Introduction',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This lesson covers the basics of $lessonTitle in HTML. You\'ll learn how to use it effectively in your projects.',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    
                    // Example code
                    const SizedBox(height: 24),
                    Text(
                      'Example',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xFF0D1117) : const Color(0xFFF6F8FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '''<!DOCTYPE html>
<html>
<head>
  <title>$lessonTitle Example</title>
</head>
<body>
  <h1>$lessonTitle Example</h1>
  <p>This is an example of $lessonTitle in HTML.</p>
  <!-- More specific code would go here based on the lesson -->
</body>
</html>''',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    
                    // Explanation
                    const SizedBox(height: 24),
                    Text(
                      'Explanation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This example demonstrates how to use $lessonTitle in HTML. The code shows the basic syntax and common patterns you\'ll use in real-world applications. Pay attention to the structure and formatting, as these are important for writing clean, maintainable code.',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    
                    // Tips and tricks
                    const SizedBox(height: 24),
                    Text(
                      'Tips and Best Practices',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFFE44D26),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Always use proper indentation and formatting for readability.',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFFE44D26),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Comment your code to explain complex logic or important decisions.',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFFE44D26),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Test your code thoroughly to ensure it works as expected in different scenarios.',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Next steps
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE44D26).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE44D26).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ready to Practice?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try the exercises below to test your understanding of $lessonTitle.',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to exercises
                              setState(() {
                                _selectedTabIndex = 3; // Switch to exercises tab
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE44D26),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              'Go to Exercises',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Extra padding at the bottom
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showRunCodeDialog(BuildContext context, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        title: Text(
          'Run HTML Code',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxHeight: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your code below:',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF0D1117) : const Color(0xFFF6F8FA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDarkMode ? Colors.white24 : Colors.black12,
                    ),
                  ),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write your code here...',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Output:',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '// Output will appear here',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: isDarkMode ? Colors.white54 : Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Run code logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Code executed successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE44D26),
              foregroundColor: Colors.white,
            ),
            child: const Text('Run Code'),
          ),
        ],
      ),
    );
  }
}
