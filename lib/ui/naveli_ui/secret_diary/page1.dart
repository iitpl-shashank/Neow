import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/page4.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/page2.dart';
import 'package:naveli_2023/ui/naveli_ui/secret_diary/page5.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Amit\'s Secret Diary',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage('assets/images/diary_1.png'),
            scale: 0.9,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 65, top: 10, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 300,
              ),
              _buildCard('Daily Diary',
                  'Record your daily activities and feelings.', 'task_1',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      )

                  //  Navigator.pushNamed(context, Page4()),
                  ),
              const SizedBox(height: 16),
              _buildCard('Monthly Mission',
                  'Set and track your monthly targets.', 'target_1',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page4()),
                      )

                  //  Navigator.pushNamed(context, Page4()),
                  ),
              const SizedBox(height: 16),
              _buildCard('Reminders',
                  'Set alerts for important dates and tasks.', 'notepad_1',
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page5()),
                      )

                  //  Navigator.pushNamed(context, Page4()),

                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, String image,
      {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: Container(
          height: 45,
          width: 50,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$image.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
