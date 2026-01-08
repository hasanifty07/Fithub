import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _nameController = TextEditingController();
  final _kgController = TextEditingController();
  final _ageController = TextEditingController();
  String _lbsResult = "0.0";

  void _calculateLbs(String value) {
    double kg = double.tryParse(value) ?? 0;
    setState(() => _lbsResult = (kg * 2.204).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final tinosStyle = GoogleFonts.tinos(fontSize: 18);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        title: Text("FitHub Dashboard",
            style: GoogleFonts.tinos(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Add New Member",
                        style: GoogleFonts.tinos(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    TextField(
                        controller: _nameController,
                        style: tinosStyle,
                        decoration:
                            const InputDecoration(labelText: "Member Name")),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _ageController,
                            style: tinosStyle,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: "Age"),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            controller: _kgController,
                            style: tinosStyle,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(labelText: "Weight (KG)"),
                            onChanged: _calculateLbs,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text("Converted Weight: $_lbsResult Lbs",
                        style: GoogleFonts.tinos(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                      ),
                      onPressed: () async {
                        try {
                          await Supabase.instance.client
                              .from('members')
                              .insert({
                            'name': _nameController.text,
                            'weight': _kgController.text,
                            'age': _ageController.text,
                          });

                          _nameController.clear();
                          _kgController.clear();
                          _ageController.clear();
                          setState(() => _lbsResult = "0.0");

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Member Added!")));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")));
                        }
                      },
                      child: Text("SAVE MEMBER",
                          style:
                              GoogleFonts.tinos(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //THE UPDATED EXPANDED SECTION
          Expanded(
            child: StreamBuilder(
              stream: Supabase.instance.client
                  .from('members')
                  .stream(primaryKey: ['id']),
              builder: (context, snapshot) {
                //1. Check for errors
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                //2. Check if still waiting for the first response
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                //3. Handle empty data
                final list = snapshot.data as List? ?? [];
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      "No members added yet.",
                      style:
                          GoogleFonts.tinos(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                //4. Show the list if data exists
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final member = list[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(member['age']?.toString() ?? "?",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      title: Text(member['name'], style: tinosStyle),
                      subtitle: Text(
                          "Age: ${member['age']} | Weight: ${member['weight']} kg",
                          style: tinosStyle),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () async => await Supabase.instance.client
                            .from('members')
                            .delete()
                            .eq('id', member['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
