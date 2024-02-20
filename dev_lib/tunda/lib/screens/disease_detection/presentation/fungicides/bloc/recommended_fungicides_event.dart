part of 'recommended_fungicides_bloc.dart';

abstract class RecommendedFungicidesEvent extends Equatable {
  const RecommendedFungicidesEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendedFungicides extends RecommendedFungicidesEvent {
  final String diseaseLabel;

  const FetchRecommendedFungicides(this.diseaseLabel);

  @override
  List<Object> get props => [diseaseLabel];
}

class FetchDiseaseInfo extends RecommendedFungicidesEvent {
  final String diseaseLabel;

  const FetchDiseaseInfo(this.diseaseLabel);

  @override
  List<Object> get props => [diseaseLabel];
}

class ClearRecommendedFungicides extends RecommendedFungicidesEvent {}
