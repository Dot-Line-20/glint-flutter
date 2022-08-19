import 'package:firebase_getx_boilerplate/app/data/controllers/test/repository.dart';
import 'package:get/get.dart';

class TestController extends GetxController with StateMixin {
  final TestRepository repository;

  TestController(this.repository);

  //....
}
