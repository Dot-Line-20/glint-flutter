import 'package:get/get.dart';

class HomePageController extends GetxController with StateMixin {
  final Rx<bool> isLogged = false.obs;
  final Rx<List> list = Rx([]);
  final Rx<int> count1 = 0.obs;
  //클래스 모델은 REFRESH() or UPDATE()가 필요

  void changeState() {
    isLogged.toggle();
  }

  Stream<List> lista() {
    return Stream.empty();
  }

  // Stream<List<Video>> lista() {
  //   Stream<QuerySnapshot> stream =
  //       Firestore.instance.collection('videos').snapshots();

  //   return stream.map((qShot) => qShot.documents
  //       .map((doc) => Video(
  //           title: doc.data['title'],
  //           url: doc.data['url'],
  //           datum: doc.data['datum']))
  //       .toList());
  // }

  @override
  void onInit() {
    list.bindStream(lista());

    //만약 hasToken이 false라면, isLogged에 변화는 없을 것입니다. 그러면 ever()는 호출되지 않을 것입니다. 이런 동작을 피하기 위해서, .value가 동일한 값으로 변경되더라도 observable 의 첫 변경은 이벤트를 발생시킬 것입니다.
    ever(isLogged, fireRoute);
    isLogged.firstRebuild = false;

    /// 'count1'이 변경될 때마다 호출
    ever(count1, (_) => print("$_ has been changed"));

    /// 'count1'이 처음으로 변경될 때 호출
    once(count1, (_) => print("$_ was changed once"));

    /// Anti DDos - 'count1'이 변경되고 1초간 변화가 없을 때 호출
    debounce(count1, (_) => print("debouce$_"),
        time: Duration(seconds: 1)); //타이핑이 끝났을 때에만 검색

    /// 'count1'이 변경되고 있는 동안 1초 간격으로 호출
    interval(count1, (_) => print("interval $_"),
        time: Duration(
            seconds: 1)); //interval은 엄청 빠른 터치(클릭)를 이용한 어뷰징(abusing)을 막는데 사용
    //참고: Worker는 Controller 혹은 클래스를 시작할 때만 사용할 수 있습니다. 그래서 항상 onInit 내에 있거나(권장사항), 클래스 생성자, StatefulWidget의 initState 안에(권장하지는 않지만 부작용은 없습니다.) 있어야 합니다.
  }

  fireRoute(logged) {
    if (logged) {
      //Get.off(Home());
    } else {
      //Get.off(Login());
    }
  }

  void rebuild(item, limit) {
    // 첫 번째 parameter: 조건, 반드시 true 혹은 false를 return
// 두 번째 parameter: 조건이 true 일 경우 적용할 새 value

    //list.addIf(item < limit, item);

    //update(['text'], counter < 10);
  }

  static HomePageController get to =>
      Get.find<HomePageController>(); // add this line
  getData() {
    /*
    다음 화면으로 이동하고 돌아올때 바로 데이터를 받거나 업데이트할 경우:

var data = await Get.to(Payment());
다른 화면에서 이전화면으로 데이터를 전달할때:

Get.back(result: 'success');
    */
  }
}
