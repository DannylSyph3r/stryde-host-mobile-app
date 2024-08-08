import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stryde_mobile_app/core/models/car_models_model.dart';
import 'package:stryde_mobile_app/core/models/make_model.dart';
import 'package:stryde_mobile_app/core/models/trims_model.dart';
import 'package:stryde_mobile_app/services/dio/dio.dart';
import 'package:stryde_mobile_app/services/dio/dio_exceptions.dart';
import 'package:stryde_mobile_app/shared/app_urls.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class GarageRepository {
  final DioClient _dioClient;
  final Ref _ref;

  GarageRepository({required DioClient dioClient, required Ref ref})
      : _dioClient = dioClient,
        _ref = ref;

  // Method to fetch car makes for a specific year
  Future<List<MakeDisplay>> getCarMakesforYear({required int year}) async {
    try {
      "Make Request made".log();
      final Map<String, dynamic> responseInMap =
          await _dioClient.get(path: AppUrls.getMakesUrl(year));

      // Deserialize the response using the CarMakes model class
      final carMakesResponse = CarMakes.fromJson(responseInMap);

      // Create a list of MakeDisplay objects from the car makes response
      final List<MakeDisplay> makeDisplays = carMakesResponse.makes
          .map(
            (make) => MakeDisplay(
              makeId: make.makeId,
              makeDisplay: make.makeDisplay,
            ),
          )
          .toList();

      // Log the list of makeDisplays
      "Fetched makeDisplays: ${makeDisplays.map((m) => m.makeDisplay).join(', ')}"
          .log();

      // Return the list of MakeDisplay objects
      return makeDisplays;
    } on DioException catch (exception) {
      final appDioException =
          AppDioException.fromDIOException(dioException: exception);
      appDioException.errorMessage.log(); // Logging the error message
      return []; // Return an empty list to indicate an error
    } catch (e) {
      final errorMessage = 'Error fetching makes: $e';
      errorMessage.log(); // Logging the error message
      return []; // Return an empty list to indicate an error
    }
  }

  Future<List<ModelDisplay>> getModelsForCarMake({required String make}) async {
    try {
      "Model Request made".log();
      final Map<String, dynamic> responseInMap =
          await _dioClient.get(path: AppUrls.getModelsForMakeUrl(make));

      // Deserialize the response using the CarModel class
      final carModelResponse = CarModel.fromJson(responseInMap);

      // Create a list of ModelDisplay objects from the car models response
      final List<ModelDisplay> modelDisplays =
          carModelResponse.models // Fixed reference from `m` to `models`
              .map(
                (model) => ModelDisplay(
                  // Changed from `make` to `model`
                  modelName: model
                      .modelName, // Updated the mapping to use the correct properties
                  modelMakeid: model.modelMakeId,
                ),
              )
              .toList();

      // Log the list of modelDisplays
      "Fetched modelDisplays: ${modelDisplays.map((m) => m.modelName).join(', ')}"
          .log();

      // Return the list of ModelDisplay objects
      return modelDisplays;
    } on DioException catch (exception) {
      final appDioException =
          AppDioException.fromDIOException(dioException: exception);
      appDioException.errorMessage.log(); // Logging the error message
      return []; // Return an empty list to indicate an error
    } catch (e) {
      final errorMessage = 'Error fetching models: $e';
      errorMessage.log(); // Logging the error message
      return []; // Return an empty list to indicate an error
    }
  }

  Future<List<Trim>> getTrimsForModel(
      {required String make, required String model}) async {
    try {
      "Trim Request made".log();

      // Call the updated URL for fetching trims based on the car make and model
      final Map<String, dynamic> responseInMap =
          await _dioClient.get(path: AppUrls.getTrimSpecsforModel(make, model));

      // Check if the response contains the expected key
      if (responseInMap.containsKey("Trims")) {
        // Create a list of Trim objects from the trims in the response
        final List<Trim> trims = List<Trim>.from(
          responseInMap["Trims"].map((x) => Trim.fromJson(x)),
        );

        // Log the list of trims
        "Fetched trims: ${trims.map((t) => t.modelTrim).join(', ')}".log();

        // Return the list of Trim objects
        return trims;
      } else {
        "No trims found in the response".log();
        return []; // Return an empty list if "Trims" key is not found
      }
    } on DioException catch (exception) {
      final appDioException =
          AppDioException.fromDIOException(dioException: exception);
      appDioException.errorMessage.log(); // Logging the error message
      return []; // Return an empty list to indicate an error
    } catch (e) {
      final errorMessage = 'Error fetching trims: $e';
      errorMessage.log(); // Logging the error message
      return []; // Return an empty list to indicate an error
    }
  }
}

final garageRepositoryProvider = Provider<GarageRepository>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return GarageRepository(dioClient: dioClient, ref: ref);
});
