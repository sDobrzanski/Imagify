import 'package:flutter_bloc/flutter_bloc.dart';
import 'photos_events.dart';
import 'photos_state.dart';
import 'package:imagify/repositories/photos_repository.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosRepository _photosRepository;

  PhotosBloc(PhotosRepository photosRepository)
      : assert(photosRepository != null),
        _photosRepository = photosRepository,
        super(RandomPhotosLoading());

  @override
  Stream<PhotosState> mapEventToState(PhotosEvent event) async* {
    if (event is LoadRandomPhotos) {
      yield* _mapRandomPhotosToState(event);
    }

    if (event is LoadSearchedPhotos) {
      yield* _mapSearchedPhotosToState(event);
    }
  }

  Stream<PhotosState> _mapRandomPhotosToState(LoadRandomPhotos event) async* {
    yield RandomPhotosLoading();
    try {
      var list = _photosRepository.fetchRandomPhotos();
      if (list != null) {
        yield RandomPhotosLoaded(list: list);
      } else {
        yield RandomPhotosError(error: 'Stream is empty');
      }
    } catch (e) {
      yield RandomPhotosError(error: e);
    }
  }

  Stream<PhotosState> _mapSearchedPhotosToState(
      LoadSearchedPhotos event) async* {
    yield SearchedPhotosLoading();
    try {
      var list = _photosRepository.fetchSearchedPhotos(event.searchKey);
      if (list != null) {
        yield SearchedPhotosLoaded(list: list);
      } else {
        yield SearchedPhotosError(error: 'Stream is empty');
      }
    } catch (e) {
      yield SearchedPhotosError(error: e);
    }
  }
}
