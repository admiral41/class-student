import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_hive_api/core/failure/failure.dart';
import 'package:student_management_hive_api/features/batch/domain/entity/batch_entity.dart';

final batchRemoteDataSourceProvider =
    Provider.autoDispose<BatchRemoteDataSource>(
        (ref) => BatchRemoteDataSource());

class BatchRemoteDataSource {
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      List<BatchEntity> lstBatchEntity = [
        const BatchEntity(batchName: 'A', batchId: '1'),
        const BatchEntity(batchName: 'B', batchId: '2'),
        const BatchEntity(batchName: 'C', batchId: '3'),
      ];
      return Right(lstBatchEntity);
    } catch (e) {
      return Left(Failure(error: 'error'));
    }
  }
}
