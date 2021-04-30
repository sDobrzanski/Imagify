import 'dart:async';

import 'package:imagify/model/photo.dart';
import 'package:bloc/bloc.dart';
import 'bottom_nav_bloc_events.dart';
import 'bottom_nav_bloc_states.dart';
import 'package:imagify/repositories/photos_repository.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final PhotosRepository photosRepository;
  int currentIndex = 0;
  String keyword;

  BottomNavigationBloc({
    this.photosRepository,
  })  : assert(photosRepository != null),
        super(null);

  BottomNavigationState get initialState => PageLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is AppStarted) {
      this.add(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        //Future<List<Photo>> data = _getRandomPhotos();
        yield FirstPageLoadedWithRandom();
      }
      if (this.currentIndex == 1) {
        yield SecondPageLoaded();
      }
    }
  }

  // Future<List<Photo>> _getRandomPhotos() async {
  //   Future<List<Photo>> data = photosRepository.fetchRandomPhotos();
  //   return data;
  // }
}
