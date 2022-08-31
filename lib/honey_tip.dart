//COPY
//b = jsonDecode(jsonEncode(a));

//NULL SAFETY
// var car = van == null ? bus : audi;         // Old pattern
// var car = audi ?? bus;                      // New pattern
// var car = van == null ? null : audi.bus;    // Old pattern
// var car = audi?.bus;                        // New pattern
// (item as Car).name = 'Mustang';         // Old pattern
// if (item is Car) item.name = 'Mustang'; // New pattern

//KEY
//By using keys flutter recognizes widgets better. This gives better performance.

//STATE_MANAGEMENT
// Provider 와 가능하면 RiverPod 를 배우고 Provider가 어떻게 작동하는지 알아 보려면 InheritedWidget 을 배우십시오 . 많은 전문 개발 팀이 BloC 라이브러리 (내부적으로 Provider를 사용함)를 사용하므로 반드시 목록에 있어야 합니다. Redux 와 MobX

//
//https://itnext.io/comparing-darts-loops-which-is-the-fastest-731a03ad42a2

//LISTVIEW IMAGE
//https://medium.com/flutter-community/flutter-memory-optimization-series-8c4a73f3ea81

//CONCUREEN
// Future<void> test() async {
//   final result = await Future.wait([
//     Future.value(100),
//     Future.value(200),
//   ]);
// }

// class Validator {
//   bool call(String text) {
//     return text.length > 10;
//   }
// }

// validatorTest() {
//   final Validator validator = Validator();
//   validator("");
//   validator("");
//   validator("");
//   validator("");
// }

// mapTest() {
//   const bool flag = true;
//   const mapping = {
//     "name": "Marrio",
//     "age": "10",
//     if (flag) ...{
//       "avgRating": 45,
//     }
//   };
// }

class FileSystem {
  FileSystem._();
  static final instance = FileSystem._();
}

/*
    ValueBuilder(
              initialValue: false,
              onUpdate: (value) => print("GOOD"),
              onDispose: () => print("GOOD"),
              builder: (bool value, Function(bool) updatefn) => Switch(
                value: value,
                onChanged: updatefn,
              ),
            ),
            ObxValue(
                (Rx<bool> data) => Switch(value: data.value, onChanged: data),
                false.obs),
            GetX(builder: (controller) {
              return Text("${controller}");
            }),
*/