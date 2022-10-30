import 'package:flutter/material.dart';
import 'package:glint/app/data/models/category.dart';

class CategoryDialog {
  static Future<int?> show(BuildContext context, List<Category> categories) {
    return showDialog<int>(
      context: context,
      builder: (context) {
        int selectedId = 0;
        return AlertDialog(
          title: const Text('카테고리'),
          content: SingleChildScrollView(
            child: ListBody(
              children: categories
                  .asMap()
                  .entries
                  .map(
                    (e) => GestureDetector(
                      onTap: () => Navigator.pop(context, e.key),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color:
                              selectedId == e.key ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          e.value.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }
}
