import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/generated_content/model/generated_content.dart';
import 'package:dishlocal/data/categories/generated_content/repository/failure/generated_content_failure.dart';
import 'package:dishlocal/data/categories/generated_content/model/dish_details.dart';

abstract class GeneratedContentRepository {
  Future<Either<GeneratedContentFailure, DishDetails>> generateDishDescription({
    required String imageUrl,
    required String dishName,
  });
}