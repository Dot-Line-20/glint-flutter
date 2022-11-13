import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

enum GTActionType {
  follow,
  unfollow,
  delete,
  edit,
  report,
}

extension GTActionTypeExtension on GTActionType {
  String get title {
    switch (this) {
      case GTActionType.follow:
        return "팔로우";
      case GTActionType.unfollow:
        return "팔로우 취소";
      case GTActionType.delete:
        return "삭제";
      case GTActionType.edit:
        return "수정";
      case GTActionType.report:
        return "신고";
    }
  }

  String get icon {
    switch (this) {
      case GTActionType.follow:
        return "assets/icons/ic_follow.svg";
      case GTActionType.unfollow:
        return "assets/images/broken_heart.svg";
      case GTActionType.delete:
        return "assets/images/rabbi.svg";
      case GTActionType.edit:
        return "assets/images/search.svg";
      case GTActionType.report:
        return "assets/images/spam.svg";
    }
  }

  Color get color {
    switch (this) {
      case GTActionType.follow:
        return AppColorTheme.Gray2;
      case GTActionType.unfollow:
        return AppColorTheme.Gray2;
      case GTActionType.delete:
        return AppColorTheme.Sys_Red;
      case GTActionType.edit:
        return AppColorTheme.Gray2;
      case GTActionType.report:
        return AppColorTheme.Sys_Red;
    }
  }
}

class GTBottomSheet {
  List<GTActionType> _buttonTypeList = [];
  GTBottomSheet(List<GTActionType> buttonTypeList) {
    _buttonTypeList = buttonTypeList;
  }

  Future show() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: Get.overlayContext!,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            height: 140,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColorTheme.Gray3,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      height: 5,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: _buttonTypeList
                        .map((e) => GTAcitionButton(actionType: e))
                        .toList(),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class GTAcitionButton extends StatelessWidget {
  final GTActionType actionType;

  const GTAcitionButton({Key? key, required this.actionType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Get.back(result: actionType),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColorTheme.Gray5,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: [
                SvgPicture.asset(actionType.icon),
                Text(
                  actionType.title,
                  style: AppTextTheme.T7.copyWith(color: actionType.color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
