import 'package:equatable/equatable.dart';
import 'package:sfx/src/data/entity/studentTaskImage_model.dart';

enum HWDetailsPageState { init, loading, success, error, noImage }

class HWDetailsState extends Equatable{
  final HWDetailsPageState pageState;
  final StudentTaskImage imagesForDetailsPage;

  const HWDetailsState({
    required this.pageState,
    required this.imagesForDetailsPage
  });
  HWDetailsState copyWith({
    HWDetailsPageState? pageState,
    StudentTaskImage? imagesForDetailsPage
  }) {
    return HWDetailsState(
        pageState: pageState ?? this.pageState,
        imagesForDetailsPage: imagesForDetailsPage ?? this.imagesForDetailsPage
    );
  }

  @override
  List<Object?> get props => [pageState, imagesForDetailsPage];
}