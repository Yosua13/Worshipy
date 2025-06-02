import 'package:flutter/material.dart';
import 'package:learning_audio/database/khotbah.dart';
import 'package:learning_audio/database/worship.dart';
import 'package:learning_audio/widgets/song_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1C1B1B),
      drawer: Drawer(
        backgroundColor: const Color(0xFF737373),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF5A5A5A),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo_worshipy_1.png",
                    width: 75,
                  ),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: const Text(
                'Favorite',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.short_text_rounded, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo_worshipy_1.png",
              width: 35,
            ),
            const SizedBox(width: 8),
            const Text(
              'Worshipy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Satoshi",
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      color: Color(0xFFD6D6D6),
                      fontFamily: "Satoshi",
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Yosua Reynaldi",
                    style: TextStyle(
                      color: Color(0xFFD6D6D6),
                      fontFamily: "Satoshi ",
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              "Find the best songs of 2025",
              style: TextStyle(
                color: Color(0xFF818181),
                fontFamily: "Satoshi",
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade800,
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: "Looking for ...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Icon(Icons.search, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    dividerColor: Colors.transparent,
                    // isScrollable: true,
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: 'Worship'),
                      Tab(text: 'Praise'),
                      Tab(text: 'Hymn'),
                      Tab(text: 'Khotbah'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SongList(
                          mp3: worship,
                          searchController: _searchController,
                        ),
                        SongList(
                          mp3: worship,
                          searchController: _searchController,
                        ),
                        SongList(
                          mp3: worship,
                          searchController: _searchController,
                        ),
                        SongList(
                          mp3: khotbah,
                          searchController: _searchController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
