part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchWeather extends WeatherEvent {
  final Position position;

  const FetchWeather({required this.position});

  @override
  // TODO: implement props
  List<Object?> get props => [position];
}
