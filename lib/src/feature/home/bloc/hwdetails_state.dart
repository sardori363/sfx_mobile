import 'package:equatable/equatable.dart';

enum HWDetailsPageState { init, loading, success, error, noImage, goToSuccess}

class HWDetailsState extends Equatable{
  final HWDetailsPageState pageState;
  final dynamic imagesForDetailsPage;
  final bool isFileTypeFile;

  const HWDetailsState({
    required this.pageState,
    required this.imagesForDetailsPage,
    required this.isFileTypeFile
  });
  HWDetailsState copyWith({
    HWDetailsPageState? pageState,
    dynamic? imagesForDetailsPage,
    bool? isFileTypeFile
  }) {
    return HWDetailsState(
        pageState: pageState ?? this.pageState,
        imagesForDetailsPage: imagesForDetailsPage ?? this.imagesForDetailsPage,
        isFileTypeFile: isFileTypeFile ?? this.isFileTypeFile
    );
  }

  @override
  List<Object?> get props => [pageState, imagesForDetailsPage, isFileTypeFile];
}