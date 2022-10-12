import 'package:flutter/material.dart';
import 'package:tracker/stats_screen.dart';
import 'package:tracker/tracker_screen.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(currentIndex: index,
      items:  [
        BottomNavigationBarItem(
          icon: IconButton(icon: 
            Icon(Icons.trending_up_rounded,
          ), onPressed: (){
            if(index == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  StatsScreen(),),);
            }
          },),
          label: "Statistik",
        ),
        BottomNavigationBarItem(
          icon: IconButton(icon: 
            Icon(Icons.sports_martial_arts,
          ), onPressed: (){
            if(index == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerScreen(),));
            }
          },),
          label: "Tracking",
        ),
      ],
    );
  }
}
