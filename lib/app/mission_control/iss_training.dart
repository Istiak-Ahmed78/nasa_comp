import 'package:flutter/material.dart';

class ISSInfoPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[700]!),
                ),
                child: Column(
                  children: [
                    Text(
                      'NASA Mission Control: Classroom',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Training • Math Worksheet',
                      style: TextStyle(color: Colors.blue[100], fontSize: 14),
                    ),
                  ],
                ),
              ),

              // Teaching Moments Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green[300]!),
                ),
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.rocket_launch,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Teaching Moments',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[100],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTeachingMomentChip(
                          'Orbital mechanics and velocity',
                          Colors.blue,
                        ),
                        _buildTeachingMomentChip(
                          'International cooperation',
                          Colors.purple,
                        ),
                        _buildTeachingMomentChip(
                          'Life in microgravity',
                          Colors.orange,
                        ),
                        _buildTeachingMomentChip(
                          'Scientific research in space',
                          Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Content - Responsive Row
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    // Tablet/Desktop layout
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildLinksPanel()),
                        SizedBox(width: 12),
                        Expanded(child: _buildActivitiesPanel()),
                      ],
                    );
                  } else {
                    // Mobile layout - stacked
                    return Column(
                      children: [
                        _buildLinksPanel(),
                        SizedBox(height: 12),
                        _buildActivitiesPanel(),
                      ],
                    );
                  }
                },
              ),

              SizedBox(height: 16),

              // Quick ISS Facts
              _buildFactsPanel(),

              SizedBox(height: 16),

              // Footer
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  'NASA Educational Resources | Mission Control: Classroom\nAll materials aligned with NGSS Standards',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeachingMomentChip(String text, MaterialColor color) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color[800],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildLinksPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[300]!),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: Colors.cyanAccent, size: 18),
              SizedBox(width: 8),
              Text(
                'Helpful Educational Links',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[100],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Column(
            children: [
              LinkButton(
                text: "Earth photos from ISS",
                color: Colors.blue[300]!,
                onTap: () {},
              ),
              SizedBox(height: 6),
              LinkButton(
                text: "NBL Official Info",
                color: Colors.orange[300]!,
                onTap: () {},
              ),
              SizedBox(height: 6),
              LinkButton(
                text: "Real-time ISS Tracker",
                color: Colors.green[300]!,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow[700]!),
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber, size: 18),
              SizedBox(width: 8),
              Text(
                'Classroom Activity Ideas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[200],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Column(
            children: [
              ActivityStep(
                label: "Before the Pass:",
                detail: "Calculate the ISS speed and altitude",
              ),
              SizedBox(height: 8),
              ActivityStep(
                label: "During the Pass:",
                detail: "Time the crossing with stopwatches",
              ),
              SizedBox(height: 8),
              ActivityStep(
                label: "After the Pass:",
                detail: "Research what experiments are happening onboard",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFactsPanel() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepPurple[800],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink[200]!),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.pink[200], size: 18),
              SizedBox(width: 8),
              Text(
                'Quick ISS Facts for Students',
                style: TextStyle(
                  color: Colors.pink[200],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 400) {
                // Two columns for wider screens
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildFactsColumn1()),
                    SizedBox(width: 16),
                    Expanded(child: _buildFactsColumn2()),
                  ],
                );
              } else {
                // Single column for narrow screens
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFactsColumn1(),
                    SizedBox(height: 8),
                    _buildFactsColumn2(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFactsColumn1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFactItem('Speed: 27,600 km/h (17,150 mph)'),
        _buildFactItem('Altitude: ~420 km above Earth'),
        _buildFactItem('Orbit time: 90 minutes'),
        _buildFactItem('Daily orbits: 15.5 times per day'),
      ],
    );
  }

  Widget _buildFactsColumn2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFactItem('Size: Football field sized'),
        _buildFactItem('Mass: 450,000 kg'),
        _buildFactItem('Crew: Usually 6-7 people'),
        _buildFactItem('Countries: 15 nations involved'),
      ],
    );
  }

  Widget _buildFactItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: Colors.white)),
          Expanded(child: Text(text, style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

// Helper link button widget
class LinkButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  const LinkButton({
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// Activity step widget
class ActivityStep extends StatelessWidget {
  final String label, detail;
  const ActivityStep({required this.label, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.yellow[100],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(detail, style: TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}
