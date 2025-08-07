import 'package:flutter/material.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isFlashOn = false;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Scan Skin Lesion',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isFlashOn = !_isFlashOn;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Preview Placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 100,
                    color: Colors.white54,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Camera Preview',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Position the lesion within the frame',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scanning Frame
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF2196F3),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Corner indicators
                  Positioned(
                    top: -1,
                    left: -1,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF2196F3), width: 6),
                          left: BorderSide(color: Color(0xFF2196F3), width: 6),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF2196F3), width: 6),
                          right: BorderSide(color: Color(0xFF2196F3), width: 6),
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    left: -1,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFF2196F3), width: 6),
                          left: BorderSide(color: Color(0xFF2196F3), width: 6),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    right: -1,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFF2196F3), width: 6),
                          right: BorderSide(color: Color(0xFF2196F3), width: 6),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Instructions
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'Scanning Instructions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Ensure good lighting\n• Keep camera steady\n• Position lesion in center\n• Maintain 10-15cm distance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (_isProcessing)
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF2196F3),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Processing image...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!_isProcessing)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Gallery Button
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.photo_library, color: Colors.white),
                          onPressed: _selectFromGallery,
                        ),
                      ),

                      // Capture Button
                      GestureDetector(
                        onTap: _captureImage,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFF2196F3),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),

                      // Settings Button
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.settings, color: Colors.white),
                          onPressed: _showSettings,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _captureImage() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate image capture and processing
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isProcessing = false;
    });

    // Navigate to results screen
    Navigator.pushNamed(
      context,
      '/result',
      arguments: {
        'confidence': 87.5,
        'diagnosis': 'Scabies',
        'recommendation': 'High Priority - Refer to specialist',
      },
    );
  }

  void _selectFromGallery() {
    // Implement gallery selection
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Select from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _captureImage(); // Simulate selection
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _captureImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Camera Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Auto Focus'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: Text('Grid Lines'),
              value: false,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: Text('Image Stabilization'),
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}