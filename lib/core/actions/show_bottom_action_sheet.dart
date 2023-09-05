import 'package:flutter/material.dart';
import 'package:secret_spice/core/db/models/recipe_model.dart';
import 'package:secret_spice/features/recommendation/presentation/widgets/bottom_sheet_action_sheet_modal.dart';


class ShowBottomActionSheet {
  final BuildContext _context;

  const ShowBottomActionSheet({
    required BuildContext context,
  }): _context = context;

  void showBottomActionSheet(RecipeModel recipe, [void Function()? onClose]){
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: _context,
      builder: (context) {
        return BottomActionSheetModal(
          recipe: recipe,
        );
      }
    ).whenComplete(() => {
      if (onClose != null) {
        onClose()
      } else {
        null
      }
    });
  }
}
