import 'package:flutter/material.dart';

final Map<String, IconData> suitPartIcons = {
  'Helmet': Icons.emoji_emotions,
  'Torso': Icons.safety_divider,
  'Gloves': Icons.back_hand,
  'Boots': Icons.hiking,
};

class SuitAssemblyStep2 extends StatefulWidget {
  final VoidCallback? nextStep;

  const SuitAssemblyStep2({Key? key, this.nextStep}) : super(key: key);

  @override
  _SuitAssemblyStep2State createState() => _SuitAssemblyStep2State();
}

class _SuitAssemblyStep2State extends State<SuitAssemblyStep2> {
  List<String> equippedParts = [];
  String? draggingPart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 550),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFF181f28),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.deepOrange[200]!, width: 1.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Step 2: Suiting Up in the EMU',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFAE5D),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Astronauts wear the Extravehicular Mobility Unit (EMU) for spacewalks',
                style: TextStyle(fontSize: 14, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Icon(Icons.emoji_people, size: 44, color: Colors.white38),
              SizedBox(height: 12),
              Text(
                'Drag and drop each part of the spacesuit to complete the assembly',
                style: TextStyle(
                  color: Colors.white.withOpacity(.95),
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children:
                    suitPartIcons.keys.map((part) {
                      return Draggable<String>(
                        data: part,
                        feedback: Opacity(
                          opacity: 0.85,
                          child: _buildPartContainer(part, true),
                        ),
                        childWhenDragging: _buildPartContainer(
                          part,
                          false,
                          isDragging: true,
                        ),
                        child: _buildPartContainer(
                          part,
                          equippedParts.contains(part),
                        ),
                        onDragStarted: () {
                          setState(() {
                            draggingPart = part;
                          });
                        },
                        onDragEnd: (details) {
                          setState(() {
                            draggingPart = null;
                          });
                        },
                      );
                    }).toList(),
              ),
              SizedBox(height: 30),
              DragTarget<String>(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    height: 210,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color:
                            candidateData.isNotEmpty
                                ? Colors.lightGreenAccent
                                : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sports_kabaddi,
                          size: 60,
                          color: Colors.white30,
                        ),
                        SizedBox(height: 8),
                        Text(
                          equippedParts.isEmpty
                              ? 'Drop suit parts here'
                              : 'Parts equipped: ${equippedParts.length}/4',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (equippedParts.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Wrap(
                              spacing: 10,
                              children:
                                  equippedParts.map((part) {
                                    return Chip(
                                      label: Text(
                                        part,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      backgroundColor: Colors.lightGreenAccent,
                                    );
                                  }).toList(),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                onWillAccept: (data) => !equippedParts.contains(data),
                onAccept: (data) {
                  setState(() {
                    equippedParts.add(data);
                  });
                },
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: equippedParts.length == 4 ? widget.nextStep : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) =>
                          equippedParts.length == 4
                              ? Color(0xFFf77e31)
                              : Color(0xFF42281f),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    equippedParts.length == 4
                        ? 'Complete Suit Assembly'
                        : 'Complete Suit Assembly First',
                    style: TextStyle(
                      fontSize: equippedParts.length == 4 ? 16 : 12,
                      letterSpacing: 0.4,
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

  Widget _buildPartContainer(
    String part,
    bool equipped, {
    bool isDragging = false,
  }) {
    return Container(
      width: 110,
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: equipped ? Color(0xFF21c37b) : Color(0xFF232b39),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          width: equipped ? 2 : 1,
          color: equipped ? Colors.greenAccent : Colors.grey.shade700,
        ),
        boxShadow: [
          if (equipped && !isDragging)
            BoxShadow(color: Colors.green.withOpacity(0.16), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            suitPartIcons[part],
            color: equipped ? Colors.white : Colors.white70,
            size: 34,
          ),
          SizedBox(height: 7),
          SizedBox(
            height: 20, // Fixed height to prevent overflow
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$part${equipped ? " ✓" : ""}',
                style: TextStyle(
                  color: equipped ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
