import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_getx_boilerplate/app/core/text_theme.dart';
import 'package:firebase_getx_boilerplate/app/widgets/stream/model_stream.dart';
import 'package:flutter/material.dart';

class FGBPStreamWidget extends StatelessWidget {
  const FGBPStreamWidget({Key? key, required this.stream, required this.type})
      : super(key: key);

  final Stream<QuerySnapshot> stream;
  final String type;

  @override
  Widget build(BuildContext context) {
    //Query or Document
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(
            "Error: ${snapshot.error}",
            style: AppTextTheme.regular,
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text("불러오는 중입니다...", style: AppTextTheme.regular);
          default:
            List snapshotData = snapshot.data!.docs;
            if (snapshotData.isEmpty) {
              return const Center(
                  child: Text(
                "없습니다.",
                style: AppTextTheme.regular,
              ));
            }
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshotData.length,
              itemBuilder: (context, index) {
                return ModelStreamWidget(
                  doc: snapshotData[index],
                  type: type,
                );
              },
            );
        }
      },
    );
  }
}
