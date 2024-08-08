import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stryde_mobile_app/core/models/car_models_model.dart';
import 'package:stryde_mobile_app/core/models/make_model.dart';
import 'package:stryde_mobile_app/core/models/trims_model.dart';
import 'package:stryde_mobile_app/features/garage/repository/garage_repository.dart';

class GarageState {
  final List<MakeDisplay> makes; // List of car makes
  final List<ModelDisplay> models; // List of car models
  final List<Trim> trims; // List of car trims
  final bool isLoading;

  GarageState({
    this.makes = const [],
    this.models = const [], // Initialize models
    this.trims = const [], // Initialize trims
    this.isLoading = false,
  });

  GarageState copyWith({
    List<MakeDisplay>? makes,
    List<ModelDisplay>? models, // Allow updating models
    List<Trim>? trims, // Allow updating trims
    bool? isLoading,
  }) {
    return GarageState(
      makes: makes ?? this.makes,
      models: models ?? this.models, // Update models
      trims: trims ?? this.trims, // Update trims
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class GarageNotifier extends StateNotifier<GarageState> {
  final GarageRepository _garageRepository;

  GarageNotifier({required GarageRepository garageRepository})
      : _garageRepository = garageRepository,
        super(GarageState());

  Future<void> fetchCarMakes(int year) async {
    state = state.copyWith(isLoading: true); // Set loading to true
    try {
      final makes = await _garageRepository.getCarMakesforYear(year: year);
      state = state.copyWith(
        makes: makes, // Update makes with List<MakeDisplay>
        isLoading: false, // Set loading to false
      );
    } catch (e) {
      state = state.copyWith(isLoading: false); // Reset loading on error
      // Optionally, handle errors appropriately here
    }
  }

  Future<void> fetchCarModels(String make) async {
    state = state.copyWith(isLoading: true); // Set loading to true
    try {
      final models = await _garageRepository.getModelsForCarMake(make: make);
      state = state.copyWith(
        models: models, // Update models with List<ModelDisplay>
        isLoading: false, // Set loading to false
      );
    } catch (e) {
      state = state.copyWith(isLoading: false); // Reset loading on error
      // Optionally, handle errors appropriately here
    }
  }

  Future<void> fetchTrimsForModel(String make, String model) async {
    state = state.copyWith(isLoading: true); // Set loading to true
    try {
      final trims =
          await _garageRepository.getTrimsForModel(make: make, model: model);
      state = state.copyWith(
        trims: trims, // Update trims with List<Trim>
        isLoading: false, // Set loading to false
      );
    } catch (e) {
      state = state.copyWith(isLoading: false); // Reset loading on error
      // Optionally, handle errors appropriately here
    }
  }
}

final garageCarMakeProvider =
    StateNotifierProvider<GarageNotifier, GarageState>((ref) {
  final garageRepository = ref.read(garageRepositoryProvider);
  return GarageNotifier(garageRepository: garageRepository);
});
