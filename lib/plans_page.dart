import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fithub_by_ifty/dashboard.dart';

class PlansPage extends StatelessWidget {
  const PlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.tinos(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue.shade900);
    final priceStyle = GoogleFonts.tinos(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green.shade700);
    final bodyStyle = GoogleFonts.tinos(fontSize: 15, color: Colors.black87);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text("Choose Your Membership",
            style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPlanCard(
              context,
              title: "Basic Plan – For Beginners",
              price: "৳1,500 / month",
              features:
                  "• Morning Access\n• Equipment Access\n• Locker Facility",
              color: Colors.white,
              isRecommended: false,
              titleStyle: titleStyle,
              priceStyle: priceStyle,
              bodyStyle: bodyStyle,
            ),
            const SizedBox(height: 20),
            _buildPlanCard(
              context,
              title: "Standard Plan – Most Popular",
              price: "৳2,500 / month",
              features:
                  "• Full-day Access\n• Cardio Access\n• 1 Free Trainer Session\n• Basic Diet Chart",
              color: Colors.blue.shade50,
              isRecommended: true,
              titleStyle: titleStyle,
              priceStyle: priceStyle,
              bodyStyle: bodyStyle,
            ),
            const SizedBox(height: 20),
            _buildPlanCard(
              context,
              title: "Premium Plan – Best Value",
              price: "৳4,000 / month",
              features:
                  "• 24/7 Access\n• 4 Trainer Sessions\n• Custom Diet & Yoga\n• VIP Locker",
              color: Colors.white,
              isRecommended: false,
              titleStyle: titleStyle,
              priceStyle: priceStyle,
              bodyStyle: bodyStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context,
      {required String title,
      required String price,
      required String features,
      required Color color,
      required bool isRecommended,
      required TextStyle titleStyle,
      required TextStyle priceStyle,
      required TextStyle bodyStyle}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: isRecommended
            ? Border.all(color: Colors.blue.shade700, width: 2)
            : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(20)),
              child: const Text("RECOMMENDED",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          Text(title, style: titleStyle),
          const SizedBox(height: 8),
          Text(price, style: priceStyle),
          const Divider(height: 30),
          Text(features, style: bodyStyle.copyWith(height: 1.5)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const DashboardPage()), // Go to Fitness, not Dashboard
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Select This Plan"),
            ),
          )
        ],
      ),
    );
  }
}
