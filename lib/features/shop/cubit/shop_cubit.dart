import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/progress_repository.dart';
import '../domain/vehicle_skin.dart';
import '../domain/board_theme.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final ProgressRepository _progressRepository;

  ShopCubit(this._progressRepository)
      : super(ShopState(
          coins: _progressRepository.coins,
          equippedSkin: _progressRepository.equippedSkin,
          equippedTheme: _progressRepository.equippedTheme,
          unlockedSkins: _progressRepository.unlockedSkins,
          unlockedThemes: _progressRepository.unlockedThemes,
        ));

  void refresh() {
    emit(ShopState(
      coins: _progressRepository.coins,
      equippedSkin: _progressRepository.equippedSkin,
      equippedTheme: _progressRepository.equippedTheme,
      unlockedSkins: _progressRepository.unlockedSkins,
      unlockedThemes: _progressRepository.unlockedThemes,
    ));
  }

  Future<bool> buySkin(VehicleSkin skin) async {
    if (state.unlockedSkins.contains(skin.id)) {
      await equipSkin(skin.id);
      return true;
    }
    final success = await _progressRepository.spendCoins(skin.price);
    if (success) {
      await _progressRepository.unlockSkin(skin.id);
      await _progressRepository.setEquippedSkin(skin.id);
      refresh();
      return true;
    }
    return false;
  }

  Future<void> equipSkin(String skinId) async {
    await _progressRepository.setEquippedSkin(skinId);
    refresh();
  }

  Future<bool> buyTheme(BoardThemeData theme) async {
    if (state.unlockedThemes.contains(theme.id)) {
      await equipTheme(theme.id);
      return true;
    }
    final success = await _progressRepository.spendCoins(theme.price);
    if (success) {
      await _progressRepository.unlockTheme(theme.id);
      await _progressRepository.setEquippedTheme(theme.id);
      refresh();
      return true;
    }
    return false;
  }

  Future<void> equipTheme(String themeId) async {
    await _progressRepository.setEquippedTheme(themeId);
    refresh();
  }
}
