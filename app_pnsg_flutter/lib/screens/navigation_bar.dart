import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final Color backgroundColor;

  const CustomBottomNavigationBar({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        onDestinationSelected(index); // Notifica o índice selecionado
      },
      selectedItemColor: Colors.lightBlue,
      currentIndex: selectedIndex,
      backgroundColor: backgroundColor,
      unselectedItemColor: Colors.black,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups_rounded),
          label: 'Pastorais',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Contribua',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Informações',
        ),
      ],
    );
  }
}
