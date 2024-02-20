part of 'recommended_fungicides_bloc.dart';

abstract class RecommendedFungicidesState extends Equatable {
  const RecommendedFungicidesState();

  @override
  List<Object> get props => [];
}

class RecommendedFungicidesInitial extends RecommendedFungicidesState {}

class RecommendedFungicidesLoading extends RecommendedFungicidesState {}

class RecommendedFungicidesLoaded extends RecommendedFungicidesState {
  final List<Fungicide> fungicides;
  final Map<String, String> diseaseInfo;

  const RecommendedFungicidesLoaded(this.fungicides, this.diseaseInfo);

  @override
  List<Object> get props => [fungicides];
}

class RecommendedFungicidesError extends RecommendedFungicidesState {}
