import 'package:bit_m/roots/search.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final List category = ['ALL', 'Trending', 'Rock', 'Looser Core'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF000000), Color(0xFF203A43)],
            center: Alignment.topCenter,
            radius: 1.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TopFullTray(),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Hey There 👋',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withValues(alpha: 0.7),
                    fontSize: 25,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      final allcat = category[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedIndex == index
                                    ? Colors.deepPurpleAccent
                                    : Colors.grey.withValues(alpha: 0.5),
                              ),
                              color: selectedIndex == index
                                  ? Colors.deepPurpleAccent.withValues(
                                      alpha: 0.2,
                                    )
                                  : Colors.white.withValues(alpha: 0.1),
                              borderRadius: selectedIndex == index
                                  ? BorderRadius.circular(10)
                                  : BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(
                                  allcat,
                                  style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.grey.withValues(alpha: 0.5),
                                    fontWeight: selectedIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopFullTray extends StatelessWidget {
  const TopFullTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UpperTray(
          imgPath: 'lib/assets/Images/user.png',
          icon: null,
          isSearch: false,
        ),
        Spacer(),
        UpperTray(
          imgPath: null,
          icon: Icons.search,
          ontap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          ),
          isSearch: true,
        ),
        SizedBox(width: 20),
        UpperTray(imgPath: null, icon: Icons.bubble_chart, isSearch: false),
      ],
    );
  }
}

class UpperTray extends StatefulWidget {
  final String? imgPath;
  final IconData? icon;
  final VoidCallback? ontap;
  final bool isSearch;
  const UpperTray({
    super.key,
    required this.imgPath,
    this.ontap,
    required this.icon,
    required this.isSearch,
  });

  @override
  State<UpperTray> createState() => _UpperTrayState();
}

class _UpperTrayState extends State<UpperTray> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: widget.isSearch
              ? Border.all(
                  color: Colors.deepPurpleAccent.withValues(alpha: 0.6),
                  width: 2,
                )
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(100),
          color: widget.isSearch
              ? Colors.deepPurpleAccent.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.imgPath != null
              ? Image.asset(widget.imgPath!)
              : Icon(widget.icon, color: Colors.white.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
