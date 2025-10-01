import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa2/app/docking/destinyLab.dart';
import 'package:nasa2/app/docking/docking.dart';
import 'package:nasa2/app/docking/issi_view.dart';
import 'package:nasa2/app/mission_control/mission_controle_page.dart';
import 'package:nasa2/app/steps/iss_docking.dart';
import 'package:nasa2/app/steps/issi_onboarding.dart';
import 'package:nasa2/app/steps/step2.dart';
import 'package:nasa2/app/steps/step3.dart';
import 'package:nasa2/app/steps/step4.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ZeroGExplorerApp());
}

class ZeroGExplorerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zero-G Explorer',
      theme: ThemeData.dark(),
      home: StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Zero-G Explorer'), centerTitle: true),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Atro background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Main Content
          Container(
            padding: EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DO YOU WANT TO BE AN ASTRONAUT?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Experience astronaut training from NASA\'s Neutral Buoyancy Lab to the International Space Station.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NBLTrainingScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('YES - Train Me!'),
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CupolaExperience()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('NO - Skip to ISS'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NBLTrainingScreen extends StatefulWidget {
  @override
  _NBLTrainingScreenState createState() => _NBLTrainingScreenState();
}

class _NBLTrainingScreenState extends State<NBLTrainingScreen> {
  int step = 1;
  final int totalSteps = 7;

  String? nasaImageUrl;
  bool isLoadingImage = true;
  final String apiQuery = "Neutral Buoyancy Lab";

  @override
  void initState() {
    super.initState();
    fetchNasaImage();
  }

  Future<void> fetchNasaImage() async {
    final Uri url = Uri.https('images-api.nasa.gov', '/search', {
      'q': apiQuery,
      'media_type': 'image',
      'page': '1',
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['collection']?['items'];
        if (items != null && items.isNotEmpty) {
          final firstItem = items[0];
          final links = firstItem['links'];
          if (links != null && links.isNotEmpty) {
            setState(() {
              nasaImageUrl = links[0]['href'];
              isLoadingImage = false;
            });
          }
        } else {
          setState(() {
            isLoadingImage = false;
          });
          print("No images found for query");
        }
      } else {
        setState(() {
          isLoadingImage = false;
        });
        print("NASA API error: HTTP ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoadingImage = false;
      });
      print("Error fetching NASA image: $e");
    }
  }

  void nextStep() {
    if (step < totalSteps) {
      setState(() => step++);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LaunchSequenceScreen()),
      );
    }
  }

  Widget buildNeutralBuoyancyStep(
    BuildContext context,
    Function nextStep,
    Function skipChallenge,
  ) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 570),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFF181f28),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Color(0xFFace4ff), width: 1.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome to NASA's Neutral Buoyancy Lab",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14),
              if (isLoadingImage)
                CircularProgressIndicator(color: Colors.cyanAccent)
              else if (nasaImageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    nasaImageUrl!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'No image available',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              SizedBox(height: 16),
              Text(
                "NASA Neutral Buoyancy Lab",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFace4ff),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "The Neutral Buoyancy Lab is a massive 6.2 million gallon pool where astronauts train for spacewalks.",
                style: TextStyle(color: Colors.white.withOpacity(.85)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 7),
              Text(
                "Your mission: Learn how astronauts achieve ",
                style: TextStyle(
                  color: Colors.white.withOpacity(.95),
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "neutral buoyancy",
                      style: TextStyle(
                        color: Color(0xFFace4ff),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " – floating neither up nor down in the water.",
                      style: TextStyle(color: Colors.white.withOpacity(.95)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              Text(
                "Experience authentic NASA training procedures!",
                style: TextStyle(
                  color: Color(0xFFF9DC6B),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 17),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => nextStep(),
                    child: Text('Begin NBL Training Protocol'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xFF2e53e1),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                  SizedBox(width: 18),
                  OutlinedButton(
                    onPressed: () => skipChallenge(),
                    child: Text('Skip to Weight Challenge'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Include your other step widgets here (SuitAssemblyStep2, PreBreatheStep, etc...)

  Widget stepContent() {
    switch (step) {
      case 1:
        return buildNeutralBuoyancyStep(context, nextStep, () {
          setState(() {
            step = 4; // Skip to weight adjustment challenge
          });
        });
      case 2:
        return SuitAssemblyStep2(nextStep: nextStep);
      case 3:
        return PreBreatheStep(onComplete: nextStep);
      case 4:
        return CableConnectionWidget(onComplete: nextStep);
      case 5:
        return MissionSequenceWidget(onComplete: nextStep);
      case 6:
        return DestinyLabOnboarding(onComplete: nextStep);
      case 7:
        return CupolaExperience();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NBL Training Protocol - Step $step')),
      body: Padding(padding: EdgeInsets.all(24), child: stepContent()),
    );
  }
}

class LaunchSequenceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simplified launch sequence and ISS docking placeholders
    return Scaffold(
      appBar: AppBar(title: Text('Launch Sequence')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Launching to the International Space Station...',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(value: 0.7),
            SizedBox(height: 20),
            Text('Altitude: 24,800 km'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final dockingSuccess = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => ISSDockingAlignmentStep()),
                );
                if (dockingSuccess == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ISSOnboardingTasksStep()),
                  );
                }
              },
              child: Text('Proceed to ISS Docking'),
            ),
          ],
        ),
      ),
    );
  }
}

// class ISSDirectScreen extends StatelessWidget {
//   const ISSDirectScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Direct to ISS')),
//       body: Center(
//         child: Text(
//           'Welcome directly aboard the International Space Station!',
//           style: TextStyle(fontSize: 20),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
