import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingData> onboardingData = [
    OnboardingData(
      title: "AI-Powered Diagnosis",
      description: "Scan skin lesions using your smartphone camera for instant AI-powered analysis",
      icon: Icons.camera_alt,
      color: Color(0xFF2196F3),
    ),
    OnboardingData(
      title: "Offline Capability",
      description: "Works without internet connection, perfect for remote areas with limited connectivity",
      icon: Icons.offline_bolt,
      color: Color(0xFF4CAF50),
    ),
    OnboardingData(
      title: "Expert Guidance",
      description: "Get referral recommendations and treatment guidance based on diagnosis confidence",
      icon: Icons.medical_services,
      color: const Color(0xFFFF9800),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(data: onboardingData[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Color(0xFF2196F3)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        Navigator.pushReplacementNamed(context, '/login');
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(75),
            ),
            child: Icon(
              data.icon,
              size: 80,
              color: data.color,
            ),
          ),
          SizedBox(height: 50),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            data.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}