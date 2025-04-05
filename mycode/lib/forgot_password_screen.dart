// forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'reset_password_email_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _selectedOption = 'email'; // Default selected option
  
  @override
  Widget build(BuildContext context) {
    // Set status bar to dark icons on white background
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 28),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              
              const SizedBox(height: 32),
              
              // Forgot Password heading
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Subtitle
              const Text(
                'Select which contact details should we use to reset your password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Contact options
              Row(
                children: [
                  // Email option
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 'email';
                        });
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedOption == 'email' 
                                ? const Color(0xFF54408C) 
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFF54408C).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF54408C),
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Send to your email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Phone option
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 'phone';
                        });
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedOption == 'phone' 
                                ? const Color(0xFF54408C) 
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone_outlined,
                                color: Colors.grey.shade400,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Send to your phone',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedOption == 'email') {
                      // Navigate to reset password email screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ResetPasswordEmailScreen(),
                        ),
                      );
                    } else {
                      // Handle phone option (could navigate to a different screen)
                      // For now, just show a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Phone verification not implemented yet'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF54408C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}