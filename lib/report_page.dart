import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';

import 'constants.dart';

class ReportPage extends StatelessWidget {
  final String name;
  final String imagePath;
  final double confidence;
  final String result;

  ReportPage({
    required this.name,
    required this.imagePath,
    required this.confidence,
    required this.result,
  });

  final _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        backgroundColor: kScaffoldColor,
        appBar: AppBar(
          title: Text('Report'),
          backgroundColor: kScaffoldColor,
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: kOtherColor),
              onPressed: () async {
                await _captureAndShare(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildInfoTile(Icons.person, 'Patient Name', name),
              _buildInfoTile(Icons.assessment, 'Result', _formatResult(result)),
              _buildInfoTile(Icons.check_circle, 'Confidence', _formatConfidence(confidence)),
              SizedBox(height: 40),
              _buildInteractiveImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Knee Osteoarthritis Report',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: kOtherColor,
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(icon, color: kOtherColor),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: kOtherColor,
      height: 1,
      thickness: 1,
    );
  }

  Widget _buildInteractiveImage() {
    return Center(
      child: ImageWidgetWithToggle(imagePath: imagePath),
    );
  }

  String _formatResult(String result) {
    return result.toUpperCase();
  }

  String _formatConfidence(double confidence) {
    return '${(confidence * 100).toStringAsFixed(2)}%';
  }

  Future<void> _captureAndShare(BuildContext context) async {
    try {
      final imageFile = await _screenshotController.capture();
      if (imageFile != null) {
        await _shareImage(context, imageFile);
      } else {
        print('Error capturing screenshot: imageFile is null');
      }
    } catch (e) {
      print('Error capturing or sharing screenshot: $e');
    }
  }

  Future<void> _shareImage(BuildContext context, Uint8List imageBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/screenshot.png');
      await tempFile.writeAsBytes(imageBytes);
      Share.shareFiles([tempFile.path], text: 'Sharing report screenshot for $name');
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}

class ImageWidgetWithToggle extends StatefulWidget {
  final String imagePath;

  const ImageWidgetWithToggle({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ImageWidgetWithToggleState createState() => _ImageWidgetWithToggleState();
}

class _ImageWidgetWithToggleState extends State<ImageWidgetWithToggle> {
  bool _isMaximized = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMaximized = !_isMaximized;
        });
      },
      child: Container(
        width: _isMaximized ? double.infinity : 370,
        height: _isMaximized ? double.infinity : 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.file(
            File(widget.imagePath),
            fit: _isMaximized ? BoxFit.contain : BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return _buildErrorImage();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.error_outline,
          color: kOtherColor,
          size: 48,
        ),
      ),
    );
  }
}
