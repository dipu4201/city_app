import 'package:flutter/material.dart';

class GuidelinePage extends StatefulWidget {
  @override
  _GuidelinePageState createState() => _GuidelinePageState();
}

class _GuidelinePageState extends State<GuidelinePage> {
  final List<String> _guidelines = [
    "ঐতিহাসিক ও সাংস্কৃতিক স্থানগুলোর প্রতি সম্মান প্রদর্শন করুন।",
    "পার্ক ও খোলা জায়গায় ময়লা-আবর্জনা ফেলা নিষেধ। পরিষ্কার-পরিচ্ছন্নতা বজায় রাখুন।",
    "ট্রাফিক নিয়ম মেনে চলুন এবং পথচারীদের নিরাপত্তা নিশ্চিত করুন।",
    "অপ্রয়োজনীয় শব্দদূষণ ও যানবাহনের হর্ন ব্যবহার পরিহার করুন।",
    "স্থানীয় ব্যবসা এবং ক্ষুদ্র ব্যবসায়ীদের সমর্থন করুন।",
    "পরিবেশ রক্ষায় গাছ লাগান ও প্লাস্টিক পণ্যের ব্যবহার কমান।",
    "বাচ্চাদের পার্ক ও খেলার মাঠে নিরাপত্তা নিশ্চিত করুন।",
    "রাস্তার পশুপাখিদের প্রতি সহানুভূতিশীল আচরণ করুন।",
    "জনসাধারণের পানি, বিদ্যুৎ ও অন্যান্য সম্পদ ব্যবহারে সচেতন হোন।",
    "সকল ধরণের সরকারি নিয়ম-নীতির প্রতি সম্মান দেখান এবং মেনে চলুন।",
  ];

  // Controller to handle new guideline input
  final TextEditingController _guidelineController = TextEditingController();

  // Function to show the Add Guideline dialog
  void _showAddGuidelineDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("নতুন নির্দেশনা যোগ করুন"),
          content: TextField(
            controller: _guidelineController,
            decoration: const InputDecoration(
              hintText: "নতুন নির্দেশনা লিখুন...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("বাতিল"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_guidelineController.text.isNotEmpty) {
                  setState(() {
                    _guidelines.add(_guidelineController.text);
                  });
                  _guidelineController.clear();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("নতুন নির্দেশনা যোগ করা হয়েছে!")),
                  );
                }
              },
              child: const Text("যোগ করুন"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guideline"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "সিটির নির্দেশনা",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _guidelines.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.info_outline, color: Colors.teal),
                      title: Text(
                        _guidelines[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.delete, color: Colors.red),
                      //   onPressed: () {
                      //     setState(() {
                      //       _guidelines.removeAt(index);
                      //     });
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(content: Text("নির্দেশনা মুছে ফেলা হয়েছে")),
                      //     );
                      //   },
                      // ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddGuidelineDialog(context),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
