import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'LeafspotDetectionScreen.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/container/container.dart';

class AIHomeScreen extends StatefulWidget {
  @override
  State<AIHomeScreen> createState() => _AIHomeScreenState();
}

class _AIHomeScreenState extends State<AIHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FxText.titleLarge(
          'AGRI-PREDICT',
          color: Colors.white,
          fontWeight: 900,
        ),
        // backgroundColor: CustomTheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: FxText.titleLarge(
                'AGRI-PREDICT',
                fontWeight: 900,
                fontSize: 35.0,
                textAlign: TextAlign.center,
                color: Colors.red.shade700,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'The Agri-Predict app brings AI to the Ugandan groundnut farming! Accurately identify groundnut varieties in just a few clicks, make Informed decisions with confidence, All in one app for efficient identification',
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 15.0),
            FxContainer(
              child: FeatureItem(
                icon: 'ai_prediction.jpeg',
                title: 'Variety Detection',
                description:
                    'Identify groundnut varieties with your phone camera.',
              ),
              onTap: () {
                Get.to(() => LeafSpotDetectionScreen(
                  model: 'assets/aimodel/variety_identifier_model.tflite',
                  label: 'assets/aimodel/labels_variety.txt',
                  isDisease: false,
                ));
              }
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  FeatureItem(
      {required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0),
              topLeft: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
            ),
            child: Image.asset(
              'assets/images/${icon}', // Placeholder for your app logo
              width: 130,
              height: 130,
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
