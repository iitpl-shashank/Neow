import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Report Card - Aug',
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Logged messages section
            Center(
              child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Main Highlights")),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLoggedMessage('You logged "Yoga" 15 times, way to go!'),
                  const SizedBox(height: 8),
                  _buildLoggedMessage(
                      'You logged "Music" 25 times, way to go!'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHabitRow(
                    'Music',
                    'assets/images/music.png',
                    completed: 2,
                    total: 4,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Learning',
                    'assets/images/learning.png',
                    completed: 1,
                    total: 4,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Cleaning',
                    'assets/images/cleaning.png',
                    completed: 3,
                    total: 10,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Body care',
                    'assets/images/body_care.png',
                    completed: 0,
                    total: 10,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Gratitude',
                    'assets/images/gratitude.png',
                    completed: 4,
                    total: 10,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Gratitude',
                    'assets/images/sleep.png',
                    completed: 4,
                    total: 10,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Gratitude',
                    'assets/images/hangout.png',
                    completed: 4,
                    total: 4,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Gratitude',
                    'assets/images/workout.png',
                    completed: 4,
                    total: 4,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Gratitude',
                    'assets/images/screen_time.png',
                    completed: 4,
                    total: 4,
                  ),
                  const SizedBox(height: 16),
                  _buildHabitRow(
                    'Gratitude',
                    'assets/images/food_1.png',
                    completed: 4,
                    total: 4,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildKeyActivity('Yoga', '15/08/2024'),
                  _buildKeyActivity('Workout', '15/08/2024'),
                ],
              ),
            ),

            // To-do list section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildKeyActivity('Yoga', '15/08/2024'),
                  _buildKeyActivity('Workout', '15/08/2024'),
                ],
              ),
            ),

            // Download Report Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    'Download Report',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedMessage(String message) {
    return Container(
      padding: EdgeInsets.fromLTRB(45, 13, 45, 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        "\u2022  $message",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildKeyActivity(String activity, String date) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12), // Matches the rounded corners in image
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Key activities',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.purple,
              ),
            ),
            // Divider line matching the image
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 8),
            // Activity items
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Yoga (14/08/2024)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Workout (14/08/2024)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitRow(
    String title,
    String avatarPath, {
    required int completed,
    required int total,
  }) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple.shade50,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  avatarPath,
                  width: 48,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    total,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < completed
                              ? Colors.purple.shade100
                              : Colors.purple.shade50,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/soul.png",
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              const Divider(height: 1),
            ],
          ),
        ),
      ],
    );
  }
}
