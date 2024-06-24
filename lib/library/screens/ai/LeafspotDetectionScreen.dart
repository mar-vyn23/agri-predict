import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/custom_theme.dart';
import '../../utils/circular_progress.dart';

class LeafSpotDetectionScreen extends StatefulWidget {
  final String model;
  final String label;
  final bool isDisease;

  LeafSpotDetectionScreen(
      {Key? key,
      required this.model,
      required this.label,
      required this.isDisease})
      : super(key: key);

  @override
  State<LeafSpotDetectionScreen> createState() =>
      _LeafSpotDetectionScreenState();
}

class _LeafSpotDetectionScreenState extends State<LeafSpotDetectionScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> yoloResults = [];
  final FlutterVision vision = FlutterVision();
  File? imageFile;
  int imageHeight = 1;
  int imageWidth = 1;
  bool isLoaded = false;
  bool _processing = false;
  String? _disease;
  double _confidence = 0.0;
  String? _recommendation;
  String? _model;
  String? _label;
  TabController? _tabController;
  bool? isDisease;

  @override
  void initState() {
    super.initState();
    initModel();
    loadYoloModel().then((value) {
      setState(() {
        isLoaded = true;
      });
    });
    _tabController = TabController(length: 1, vsync: this);
  }

  initModel() async {
    _model = widget.model;
    _label = widget.label;
    isDisease = widget.isDisease;
  }

  @override
  void dispose() async {
    super.dispose();
    vision.closeYoloModel();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      loadYoloModel();
      return Scaffold(
        appBar: AppBar(
          title: FxText.titleLarge(
            'Model has not yet loaded',
            color: Colors.white,
            fontWeight: 900,
          ),
          backgroundColor: CustomTheme.primary,
        ),
        body: Center(
          child: Text("Model is loading....please wait"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
          title: FxText.titleLarge(
            'AGRI-PREDICT',
            color: Colors.white,
            fontWeight: 900,
          ),
          centerTitle: true,
          backgroundColor: CustomTheme.primary,
          actions: [
            PopupMenuButton<String>(onSelected: (String choice) {
              // Handle the selected menu item here
            }, itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Variety Identifier',
                  child: Text(
                    'Variety Identifier',
                    style: TextStyle(
                        color: isDisease! ? Colors.black : Colors.green),
                  ),
                  onTap: () {
                    _model = 'assets/aimodel/variety_identifier_model.tflite';
                    _label = 'assets/aimodel/labels_variety.txt';
                    setState(() {
                      isDisease = false;
                      imageFile = null;
                      _confidence = 0.0;
                      _disease = null;
                      _recommendation = null;
                      yoloResults = [];
                    });
                    loadYoloModel();
                  },
                ),
              ];
            })
          ]),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 2, left: 1, right: 1), // Add margins
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width - 20, // Adjust width
                  decoration: BoxDecoration(
                    color: imageFile == null
                        ? Color(0xffC4C4C4).withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.zero, // Remove rounded corners
                    border: Border.all(
                        color: Colors.black, width: 2), // Add black border
                    image: imageFile != null
                        ? DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageFile == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            isDisease!
                                ? "Your processed image with the identified variety shall appear here"
                                : "Your processed image with the identified variety shall appear here",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'Time New Roman'),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : null,
                ),
                ...displayBoxesAroundRecognizedObjects(size),
              ],
            ),
          ),
          SizedBox(
              height: 15), // Add space between the Expanded widget and the Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Select or Capture an image",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Time New Roman'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: !_processing
                    ? () {
                        setState(() {
                          imageFile = null;
                          _confidence = 0.0;
                          _disease = null;
                          _recommendation = null;
                          yoloResults = [];
                        });
                        imageDialog(context, true);
                      }
                    : null,
                child: Image.asset(
                  'assets/images/uploadIcon.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 6,
            child: NestedScrollView(
              body: _processing
                  ? Align(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: _confidence,
                          ),
                          const Text(
                            'Processing image...',
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                    )
                  : imageFile != null && _disease != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            TabBar(
                              isScrollable: true,
                              controller: _tabController,
                              labelColor: Color.fromARGB(255, 53, 4, 228),
                              dividerColor: Colors.transparent,
                              tabAlignment: TabAlignment.start,
                              unselectedLabelColor: Colors.black,
                              onTap: (index) {},
                              labelStyle: TextStyle(fontSize: 20),
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              indicator: const ShapeDecoration(
                                shape: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 8, 8, 8), // Set the color to transparent
                                    width: 2,
                                  ),
                                ),
                              ),
                              tabs: [
                                Text("Results"),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                "The overall confidence of the result is:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Time New Roman'),
                                              ),
                                              SizedBox(
                                                width: 70,
                                                height: 70,
                                                child: CustomPaint(
                                                  painter: CircleProgressBar(
                                                    percentage: _confidence,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        isDisease!
                                            ? Text(
                                                'Disease: $_disease',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'Time New Roman'),
                                              )
                                            : Text(
                                                'GNUT VARIETY: $_disease',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'Time New Roman'),
                                                textAlign: TextAlign.center,
                                              ),
                                        const SizedBox(height: 10.0),
                                      
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'After selecting an image and processing it your results will appear here',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'Time New Roman'),
                            textAlign: TextAlign.center,
                          ),
                        ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [];
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: _disease != null && _confidence > 0
            ? () {
                // Display bottom sheet with recommendations
                _showRecommendations(context);
              }
            : null,
        child: _disease != null && _confidence > 0
            ? const Text('View Recommendations')
            : _disease != null && _confidence < 0
                ? const Text('No confidence in results')
                : const Text('No results yet'),
      ),
    );
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: _label!,
        modelPath: _model!,
        modelVersion: "yolov8",
        quantization: true,
        numThreads: 2,
        useGpu: false);
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
      });
    }
  }

  yoloOnImage() async {
    setState(() {
      _processing = true;
    });

    yoloResults.clear();
    Uint8List byte = await imageFile!.readAsBytes();
    final image = await decodeImageFromList(byte);
    imageHeight = image.height;
    imageWidth = image.width;

    try {
      final result = await Future.delayed(Duration(seconds: 5), () {
        print("Model has started running");
        return vision.yoloOnImage(
          bytesList: byte,
          imageHeight: image.height,
          imageWidth: image.width,
          iouThreshold: 0.8,
          confThreshold: 0.4,
          classThreshold: 0.5,
        );
      });
      print("Model has completed running successfully");

      if (result.isNotEmpty) {
        setState(() {
          yoloResults = result;
          _processing = false;
        });
        _processResults(result);
      } else {
        setState(() {
          _processing = false;
        });
        // Handle case where No results obtained
        result.isEmpty
            ? showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('No results obtained'),
                  content: Text(
                      'Either your image is unclear or it is not groundnut variety'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              )
            : showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delay'),
                  content:
                      Text('The model is taking too much time in processing'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
      }
    } catch (e) {
      setState(() {
        _processing = false;
      });
      // Handle timeout or other errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while processing the image.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];

    double factorX = screen.width / imageWidth;
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / imageHeight;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);
    return yoloResults.map((result) {
      double boxWidth = (result["box"][2] - result["box"][0]) * factorX * 0.8;
      double boxHeight = (result["box"][3] - result["box"][1]) * factorY * 0.8;

      // Calculate text width using TextPainter
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text:
              "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
          style: const TextStyle(fontSize: 18.0),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      double textWidth = textPainter.size.width;

      if (textWidth > boxWidth) {
        // Increase box width if tag text doesn't fit
        boxWidth = textWidth + 20;
      }

      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY,
        width: boxWidth,
        height: boxHeight,
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                background: Paint()..color = colorPick,
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

void _processResults(List<dynamic> results) {
  // Check if results are not empty
  if (results.isNotEmpty) {
    // Map to store cumulative confidence and count for each tag
    Map<String, List<double>> tagConfidences = {};

    // Iterate through results to aggregate confidence values for each tag
    for (var result in results) {
      String tag = result['tag'];
      double confidence = result['box'][4];

      // Initialize list if tag is encountered for the first time
      tagConfidences[tag] ??= [];

      // Add confidence to the list for the current tag
      tagConfidences[tag]!.add(confidence);
    }

    // Variables to track the dominant tag and its average confidence
    String? dominantTag;
    double maxAverageConfidence = 0.0;

    // Calculate average confidence for each tag and determine the dominant one
    tagConfidences.forEach((tag, confidences) {
      double totalConfidence = confidences.reduce((a, b) => a + b);
      double averageConfidence = totalConfidence / confidences.length;

      // Update dominant tag if current tag has higher average confidence
      if (averageConfidence > maxAverageConfidence) {
        maxAverageConfidence = averageConfidence;
        dominantTag = tag;
      }
    });

    // Update state variables with the dominant tag and its average confidence
    if (dominantTag != null) {
      _disease = dominantTag;
      _confidence = maxAverageConfidence;

      // Get recommendation based on the detected disease
      _recommendation = _getRecommendationForDisease(dominantTag!);
    } else {
      // Handle case where no results or confidence values are found
      _disease = null;
      _confidence = 0.0;
      _recommendation = null;
    }
  } else {
    // Handle case where results list is empty
    _disease = null;
    _confidence = 0.0;
    _recommendation = null;
  }
}




  String? _getRecommendationForDisease(String? disease) {
    // Implement your logic to provide recommendations for different diseases
    return "Recommendations for $_disease";
  }

  getImageDialog(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final pickedImage = await picker.pickImage(
      source: source,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        yoloOnImage();
      });
    }
  }

  void _showRecommendations(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Recommendations on $_disease:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. Practice good field sanitation.\n'
                '2. Use disease-resistant crop varieties.\n'
                '3. Implement integrated pest management strategies.\n'
                '4. Consult with agricultural experts for guidance.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        );
      },
    );
  }

  void imageDialog(BuildContext context, bool image) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Media Source"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.gallery);
                        Navigator.pop(context);
                      } else {}
                    },
                    icon: const Icon(Icons.image)),
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.camera);
                        Navigator.pop(context);
                      } else {}
                    },
                    icon: const Icon(Icons.camera_alt)),
              ],
            ),
          );
        },
        context: context);
  }
}
