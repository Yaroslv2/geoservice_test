import 'package:bloc/bloc.dart';
import 'package:geoservise_test/application/coords_calculate_func.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomepageInitial());

  Future add(xCoord, yCoord, zoom) async {
    emit(HomePageLoadingState());
    var tileCoords = coordsCalculate(xCoord, yCoord, zoom);

    emit(
      HomePageLoadedSuccess(
        imageUrl:
            "https://core-carparks-renderer-lots.maps.yandex.net/maps-rdr-carparks/tiles?l=carparks&x=${tileCoords["x"]}&y=${tileCoords["y"]}&z=${tileCoords["z"]}&scale=1&lang=ru_RU",
        tileCoords: tileCoords,
      ),
    );
  }
}
