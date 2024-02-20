part of 'fruit_tester_bloc.dart';

abstract class FruitTesterState extends Equatable {
  const FruitTesterState();

  @override
  List<Object> get props => [];
}

class FruitTesterInitial extends FruitTesterState {}

class FruitTesterLoading extends FruitTesterState {}

class FruitTesterLoaded extends FruitTesterState {
  final String topScore;
  final String topLabel;
  const FruitTesterLoaded({required this.topLabel, required this.topScore});
  @override
  List<Object> get props => [topScore, topLabel];
}

class FruitTesterError extends FruitTesterState {}
