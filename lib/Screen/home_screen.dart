import 'package:flutter/material.dart';
import 'package:rajshai_town/box_category_page/community_page.dart';
import 'package:rajshai_town/box_category_page/events_festivals_page.dart';
import 'package:rajshai_town/box_category_page/study_page.dart';
import 'package:rajshai_town/box_category_page/tourist_attractions_page.dart';
import 'package:rajshai_town/widget/category_item.dart';
import 'package:rajshai_town/widget/other_box_category.dart';
import '../Category_page/dining_page.dart';
import '../Category_page/guideline_page.dart';
import '../hotel/hotel_page.dart';
import '../Category_page/parks_page.dart';
import '../Category_page/shopping_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Explore Rajshahi"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: const HomeScreenContent(),
      backgroundColor: Colors.white,
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (_currentPage != nextPage) {
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12.0),
          sliver: SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageSlider(),
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _CategorySectionDelegate(
            child: categorySection(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          sliver: SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              otherCategoryCard(
                Icons.map,
                "Tourist Attractions",
                Colors.black,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TouristAttractionsPage()),
                  );
                },
              ),
              otherCategoryCard(
                Icons.event,
                "Events & Festivals",
                Colors.black,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventsFestivalsPage()),
                  );
                },
              ),
              otherCategoryCard(
                Icons.school,
                "Study",
                Colors.black,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudyPage()),
                  );
                },
              ),
              otherCategoryCard(
                Icons.groups,
                "Our Community",
                Colors.black,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommunityPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Image.asset(
                "assets/images/image1.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/images/image2.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "assets/images/image3.jpg",
                fit: BoxFit.cover,
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget categorySection() {
    return Container(
      height: 100,
      color: Colors.white, // Background matching parent widgets
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryItem(Icons.park, "Parks", ParksPage()),
          CategoryItem(Icons.hotel, "Hotels", HotelsPage()),
          CategoryItem(Icons.shopping_cart, "Shopping", ShoppingPage()),
          CategoryItem(Icons.book_online, "Guideline", GuidelinePage()),
          CategoryItem(Icons.restaurant, "Dining", DiningPage()),
        ],
      ),
    );
  }
}

class _CategorySectionDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _CategorySectionDelegate({required this.child});

  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _CategorySectionDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

