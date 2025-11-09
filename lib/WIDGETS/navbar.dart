import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentindex;
  final Function(int) onTapItem;

  const Navbar({
    super.key,
    required this.currentindex,
    required this.onTapItem,
  });

  final items = const [
    Icons.home,
    Icons.search,
    Icons.favorite_outlined,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(items.length, (i) {
            final bool isSelected = currentindex == i;
            return GestureDetector(
              onTap: () => onTapItem(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black12 : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  items[i],
                  size: 28,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
            );
          }),  
        ),
      ),
    );
  }
}
