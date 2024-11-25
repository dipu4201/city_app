import 'package:flutter/material.dart';
import 'package:rajshai_town/widget/custom_appbar.dart';

class EventsFestivalsPage extends StatefulWidget {
  @override
  _EventsFestivalsPageState createState() => _EventsFestivalsPageState();
}

class _EventsFestivalsPageState extends State<EventsFestivalsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> upcomingEvents = [
    {
      'title': 'রাজশাহী ফুড ফেস্টিভ্যাল',
      'date': '১-৫ ডিসেম্বর, ২০২৪',
      'description': 'রাজশাহীর বিভিন্ন রেস্তোরাঁর খাবারের বৈচিত্র্য উপভোগ করুন।',
      'location': 'সাহেব বাজার বড় মসজিদ চত্বর',
      'time': 'দুপুর ১২টা - রাত ১০টা',
    },
    {
      'title': 'সাংস্কৃতিক ঐতিহ্য মেলা',
      'date': '১৫ জানুয়ারি, ২০২৫',
      'description': 'রাজশাহীর ঐতিহ্যবাহী সংস্কৃতি তুলে ধরার এক মিলনমেলা।',
      'location': 'রাজশাহী কলেজ প্রাঙ্গণ',
      'time': 'সকাল ১০টা - সন্ধ্যা ৬টা',
    },
    {
      'title': 'পাঠা উৎসব',
      'date': '১০ ফেব্রুয়ারি, ২০২৫',
      'description': 'রাজশাহীর ঐতিহ্যবাহী পিঠা ও মিষ্টান্ন নিয়ে বার্ষিক উৎসব।',
      'location': 'গ্রীন প্লাজা, রাজশাহী সিটি কর্পোরেশন',
      'time': 'সন্ধ্যা ৪টা - রাত ৯টা',
    },
  ];

  final List<Map<String, String>> ongoingEvents = [
    {
      'title': 'রাজশাহী আর্ট এক্সিবিশন',
      'date': 'চলমান, ৩১ অক্টোবর, ২০২৪ পর্যন্ত',
      'description': 'কমিউনিটি সেন্টারে স্থানীয় শিল্পীদের সৃজনশীল কাজ প্রদর্শনী।',
      'location': 'আর্ট কমপ্লেক্স, পদ্মা গার্ডেন',
      'time': 'সকাল ১১টা - বিকাল ৫টা',
    },
    {
      'title': 'মোনসুন মিউজিক ফেস্ট',
      'date': 'চলমান, ১৫ নভেম্বর, ২০২৪ পর্যন্ত',
      'description': 'প্রতিটি সপ্তাহের শেষে সরাসরি সংগীত ও পরিবেশনা।',
      'location': 'সিটি সেন্টার প্লাজা',
      'time': 'সন্ধ্যা ৬টা - রাত ৯টা',
    },
    {
      'title': 'চারুকলা উৎসব',
      'date': 'চলমান, নভেম্বর ৩০, ২০২৪ পর্যন্ত',
      'description': 'রাজশাহী বিশ্ববিদ্যালয়ের চারুকলা বিভাগে শিল্পকর্ম প্রদর্শনী।',
      'location': 'চারুকলা ইনস্টিটিউট, রাজশাহী বিশ্ববিদ্যালয়',
      'time': 'সকাল ১০টা - বিকাল ৪টা',
    },
  ];

  final List<Map<String, String>> pastEvents = [
    {
      'title': 'রাজশাহী নদী উৎসব',
      'date': '১৫ সেপ্টেম্বর, ২০২৪',
      'description': 'পদ্মা নদীকে কেন্দ্র করে নৌকা বাইচ এবং স্থানীয় খাবারের উৎসব।',
      'location': 'পদ্মা নদীর তীর, বারকুলা',
      'time': 'সকাল ৮টা - বিকাল ৫টা',
    },
    {
      'title': 'ঐতিহ্যবাহী নৃত্য প্রতিযোগিতা',
      'date': '২০ আগস্ট, ২০২৪',
      'description': 'রাজশাহীর সেরা নৃত্য প্রতিভাগুলোর পরিবেশনা।',
      'location': 'শাহ মখদুম থিয়েটার হল',
      'time': 'বিকাল ৪টা - রাত ৮টা',
    },
    {
      'title': 'মধুমেলা বইমেলা',
      'date': '১২-১৮ ফেব্রুয়ারি, ২০২৪',
      'description': 'বইপ্রেমীদের জন্য রাজশাহীতে আয়োজিত বার্ষিক বইমেলা।',
      'location': 'জিন্নাহ মাঠ, রাজশাহী',
      'time': 'সকাল ১১টা - রাত ৮টা',
    },
    {
      'title': 'আম উৎসব',
      'date': '২৫ জুন, ২০২৪',
      'description': 'রাজশাহীর বিখ্যাত আম নিয়ে ফেস্টিভ্যাল এবং প্রদর্শনী।',
      'location': 'রাণীবাজার আমবাগান',
      'time': 'সকাল ৯টা - দুপুর ২টা',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Ongoing'),
                Tab(text: 'Past'),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEventList(upcomingEvents),
                _buildEventList(ongoingEvents),
                _buildEventList(pastEvents),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(List<Map<String, String>> events) {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12.0),
            title: Text(
              event['title'] ?? 'No Title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'তারিখ: ${event['date'] ?? 'No Date'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'স্থান: ${event['location'] ?? 'No Location'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'সময়: ${event['time'] ?? 'No Time'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event['description'] ?? 'No Description',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.tealAccent),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Details for ${event['title'] ?? 'this event'}!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
