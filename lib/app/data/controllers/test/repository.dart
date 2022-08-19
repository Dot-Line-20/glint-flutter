import 'package:firebase_getx_boilerplate/app/data/provider/api_interface.dart';

class TestRepository {
  final FGBPApiInterface api;

  TestRepository(this.api);

  Future<void> get() => api.getInfo();
}
