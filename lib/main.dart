import 'package:flutter/material.dart';
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
      home: MissionControlClassroomScreen(),
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
                      MaterialPageRoute(builder: (_) => ISSDirectScreen()),
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

  // For suit assembly simulation
  List<String> equippedParts = [];

  // For weight adjustment challenge
  Map<String, int> weights = {
    'Left Weight': 45,
    'Right Weight': 50,
    'Chest Weight': 50,
    'Back Weight': 50,
  };
  final int targetTotalWeight = 200;

  void nextStep() {
    if (step < totalSteps) {
      setState(() => step++);
    } else {
      // After last step (4), navigate to launch sequence
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
              Container(
                height: 180,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueGrey.shade900,
                ),
                child: Image.asset(
                  'assets/Step-Taining.jpg', // Place your image at assets/images/
                  fit: BoxFit.cover,
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

class ISSDirectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Direct to ISS')),
      body: Center(
        child: Text(
          'Welcome directly aboard the International Space Station!',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
