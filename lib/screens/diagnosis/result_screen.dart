import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {
              'confidence': 87.5,
              'diagnosis': 'Scabies',
              'recommendation': 'High Priority - Refer to specialist',
            };

    final double confidence = args['confidence'];
    final String diagnosis = args['diagnosis'];
    final String recommendation = args['recommendation'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosis Result'),
        backgroundColor: Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Result Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: confidence > 80
                      ? [Colors.red[400]!, Colors.red[600]!]
                      : confidence > 60
                      ? [Colors.orange[400]!, Colors.orange[600]!]
                      : [Colors.green[400]!, Colors.green[600]!],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    confidence > 80
                        ? Icons.warning
                        : confidence > 60
                        ? Icons.info
                        : Icons.check_circle,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    diagnosis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${confidence.toStringAsFixed(1)}% Confidence',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Confidence Meter
            Text(
              'Confidence Level',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Low'),
                      Text('Medium'),
                      Text('High'),
                    ],
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: confidence / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      confidence > 80
                          ? Colors.red
                          : confidence > 60
                          ? Colors.orange
                          : Colors.green,
                    ),
                    minHeight: 8,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${confidence.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Recommendation
            Text(
              'Recommendation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Color(0xFF2196F3),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  if (confidence > 80) ...[
                    Text(
                      'Immediate Actions:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '• Isolate patient to prevent spread\n• Contact dermatologist immediately\n• Document case for tracking\n• Provide patient education',
                      style: TextStyle(fontSize: 14),
                    ),
                  ] else if (confidence > 60) ...[
                    Text(
                      'Suggested Actions:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '• Schedule follow-up examination\n• Monitor symptoms\n• Consider specialist referral\n• Provide basic care instructions',
                      style: TextStyle(fontSize: 14),
                    ),
                  ] else ...[
                    Text(
                      'Routine Care:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '• Continue regular monitoring\n• Maintain good hygiene\n• Schedule routine check-up\n• No immediate action required',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showSaveDialog(context);
                    },
                    icon: Icon(Icons.save),
                    label: Text('Save Result'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: Color(0xFF2196F3)),
                      foregroundColor: Color(0xFF2196F3),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showReferralDialog(context);
                    },
                    icon: Icon(Icons.send),
                    label: Text('Send Referral'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/dashboard',
                        (route) => false,
                  );
                },
                icon: Icon(Icons.home),
                label: Text('Back to Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Save Result'),
        content: Text('Do you want to save this diagnosis result to patient records?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Result saved successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showReferralDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Send Referral'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Send this case to a specialist for further evaluation?'),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: 'Additional Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Referral sent successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}