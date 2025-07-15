import 'package:core/core.dart';
import 'package:use_case/src/download_file_use_case_impl.dart';
import 'package:use_case/src/get_file_use_case.dart';

mixin UseCaseHelper {

  static GetFileUseCase getFileUseCase(){
    return GetIt.I.get<GetFileUseCase>();
  }

  static DownloadFileUseCase downloadFileUseCase(){
    return GetIt.I.get<DownloadFileUseCase>();
  }

}