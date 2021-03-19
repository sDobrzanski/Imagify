import 'package:flutter/material.dart';
import 'package:imagify/screens/favourites_page.dart';
import 'package:imagify/screens/home_page.dart';
import 'package:imagify/bloc/bottom_nav_bloc.dart';
import 'package:imagify/bloc/bottom_nav_bloc_events.dart';
import 'package:imagify/bloc/bottom_nav_bloc_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final BottomNavigationBloc bottomNavigationBloc =
        BlocProvider.of<BottomNavigationBloc>(context);

    return Scaffold(
        body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (BuildContext context, BottomNavigationState state) {
        if (state is PageLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FirstPageLoadedWithRandom) {
          return HomePage(
            photosList: state.photosListRandom,
          );
        }
        if (state is SecondPageLoaded) {
          return FavouritesPage();
        }
        return Container();
      },
    ), bottomNavigationBar:
            BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (BuildContext context, BottomNavigationState state) {
      return BottomNavigationBar(
        currentIndex: bottomNavigationBloc.currentIndex,
        selectedFontSize: 15,
        iconSize: 30,
        selectedItemColor: Color(0xFF512DA8),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
        onTap: (index) => bottomNavigationBloc.add(PageTapped(index: index)),
      );
    }));
  }
}
