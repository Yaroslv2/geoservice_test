part of 'homepage_cubit.dart';

@immutable
abstract class HomePageState {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageLoadedSuccess extends HomePageState {
  final String imageUrl;
  final Map<String, int> tileCoords;

  const HomePageLoadedSuccess({
    required this.imageUrl,
    required this.tileCoords,
  });
}
