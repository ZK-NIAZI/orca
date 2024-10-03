import '../../../constants/asset_paths.dart';
import '../models/bottom_nav_model.dart';

class DashboardState {
  final List<BottomNavModel> tabs;

  factory DashboardState.initial() {
    return DashboardState(tabs: [
      BottomNavModel(icon: AssetPaths.icHome, isSelected: true),
      BottomNavModel(icon: AssetPaths.icSearch, isSelected: false),
      BottomNavModel(icon: AssetPaths.icFav, isSelected: false),
      BottomNavModel(icon: AssetPaths.icProfile, isSelected: false),
    ]);
  }

  DashboardState({required this.tabs});

  DashboardState copyWith({List<BottomNavModel>? tabs}) {
    return DashboardState(
      tabs: tabs ?? this.tabs,
    );
  }
}
