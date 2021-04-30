import 'package:flutter_bloc/flutter_bloc.dart';
import 'db_event.dart';
import 'db_state.dart';
import 'package:imagify/repositories/database_helper.dart';

class DbBloc extends Bloc<DbEvent, DbState> {
  final DatabaseHelper _databaseHelper;

  DbBloc(DatabaseHelper databaseHelper)
      : assert(databaseHelper != null),
        _databaseHelper = databaseHelper,
        super(FavPhotosLoading());

  @override
  Stream<DbState> mapEventToState(DbEvent event) async* {
    if (event is LoadFavPhotos) {
      yield* _mapFavPhotosToState(event);
    }

    if (event is AddPhoto) {
      yield* _mapAddPhotoToState(event);
    }

    if (event is DeletePhoto) {
      yield* _mapDeletePhotoToState(event);
    }

    if (event is DeleteAllPhotos) {
      yield* _mapDeleteAllPhotosToState(event);
    }
  }

  Stream<DbState> _mapFavPhotosToState(LoadFavPhotos event) async* {}
  Stream<DbState> _mapAddPhotoToState(AddPhoto event) async* {}
  Stream<DbState> _mapDeletePhotoToState(DeletePhoto event) async* {}
  Stream<DbState> _mapDeleteAllPhotosToState(DeleteAllPhotos event) async* {}
}
