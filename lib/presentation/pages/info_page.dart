import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 Information"),
        backgroundColor: Colors.green[700], // Warna hijau untuk tema kesehatan
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title or Heading
              Text(
                "Important Information about COVID-19",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 16),

              // Informative Section 1: What is COVID-19?
              Text(
                "What is COVID-19?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "COVID-19 is a disease caused by the SARS-CoV-2 virus. It primarily spreads through respiratory droplets when an infected person coughs, sneezes, or talks. The disease can cause mild to severe respiratory illness, and in some cases, it can lead to death.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Informative Section 2: Symptoms
              Text(
                "Symptoms of COVID-19",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Common symptoms include:\n"
                "- Fever\n"
                "- Dry cough\n"
                "- Fatigue\n"
                "- Loss of taste or smell\n"
                "- Difficulty breathing",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Informative Section 3: Prevention Tips
              Text(
                "How to Prevent COVID-19?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "To prevent the spread of COVID-19, follow these safety measures:\n"
                "- Wear a mask in public spaces\n"
                "- Wash hands frequently with soap and water\n"
                "- Maintain social distancing (at least 6 feet)\n"
                "- Avoid crowded places and gatherings\n"
                "- Get vaccinated if eligible",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Informative Section 4: Latest News or Updates
              Text(
                "Latest News about COVID-19 Vaccines",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "As of [Date], several COVID-19 vaccines have been approved and are being distributed globally. These vaccines are highly effective in preventing severe illness and death caused by COVID-19. Stay informed about vaccination schedules and guidelines in your area.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Footer with a disclaimer or additional information
              Text(
                "For more information, please visit the official health websites like World Health Organization (WHO) or your local health department.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
