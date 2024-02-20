import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:tunda/presentation/fungicides/models/fungicide.dart';
// import 'package:tunda/presentation/fungicides/repository/fungicide_repository.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/models/fungicide.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/repository/fungicide_repository.dart';

part 'recommended_fungicides_event.dart';
part 'recommended_fungicides_state.dart';

class RecommendedFungicidesBloc
    extends Bloc<RecommendedFungicidesEvent, RecommendedFungicidesState> {
  final FungicideRepository fungicideRepository;
  RecommendedFungicidesBloc(this.fungicideRepository)
      : super(RecommendedFungicidesInitial()) {
    on<FetchRecommendedFungicides>((event, emit) async {
      emit(RecommendedFungicidesLoading());
      try {
        final List<Fungicide> fungicides = await fungicideRepository
            .getFungicidesForDisease(event.diseaseLabel);
        final Map<String, String> diseaseInfo =
            await fungicideRepository.getDiseaseInfo(event.diseaseLabel);
        emit(RecommendedFungicidesLoaded(
          fungicides,
          diseaseInfo,
        ));
        print('diseaseInfo are $diseaseInfo');

        // emit(RecommendedFungicidesLoaded(fungicides));
      } catch (e) {
        emit(RecommendedFungicidesError());
      }
    });
    on<ClearRecommendedFungicides>((event, emit) async {
      emit(RecommendedFungicidesInitial());
    });
  }
}
