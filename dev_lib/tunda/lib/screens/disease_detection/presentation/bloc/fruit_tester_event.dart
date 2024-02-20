part of 'fruit_tester_bloc.dart';

abstract class FruitTesterEvent extends Equatable {
  const FruitTesterEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends FruitTesterEvent {
  final convertedImage;
  const LoadData({required this.convertedImage});
}

// Define the event here
