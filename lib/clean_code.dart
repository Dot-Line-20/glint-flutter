abstract class PayableInterface {
  Future<void> pay();
}

class CardPayment implements PayableInterface {
  @override
  Future<void> pay() async {
    // Card payment logic.
  }
}

class PaypalPayment implements PayableInterface {
  @override
  Future<void> pay() async {
    // Paypal payment logic.
  }
}

class AliPayPayment implements PayableInterface {
  @override
  Future<void> pay() async {
    // AliPay payment logic.
  }
}

enum PaymentType { card, payPal, aliPay }

class PaymentFactory {
  const PaymentFactory();

  PayableInterface initializePayment(PaymentType paymentType) {
    // Filter by `paymentType` and return the correct [PayableInterface].
    switch (paymentType) {
      case PaymentType.card:
        return CardPayment();
      case PaymentType.payPal:
        return PaypalPayment();
      case PaymentType.aliPay:
        return AliPayPayment();
    }
  }
}

class PaymentRepository {
  PaymentRepository({
    required PaymentFactory paymentFactory,
  }) : _paymentFactory = paymentFactory;

  final PaymentFactory _paymentFactory;

  Future<void> pay(PaymentType paymentType) async {
    // Get the respective payableInterface based on the `paymentType`.
    PayableInterface payment = _paymentFactory.initializePayment(paymentType);

    // Make payment.
    payment.pay();
  }
}

abstract class QuackInterface {
  String quack();
}

abstract class FlyInterface {
  String fly();
}

abstract class SwimInterface {
  String swim();
}

class RubberDuck implements QuackInterface, SwimInterface {
  @override
  String quack() {
    return "Quack!!!";
  }

  @override
  String swim() {
    return "Duck Swimming";
  }
}

abstract class Animal {
  void eat();
  void sleep();
}

class Bird implements Animal, FlyInterface {
  @override
  void eat() {}

  @override
  void sleep() {}

  @override
  String fly() {
    // TODO: implement fly
    throw UnimplementedError();
  }
}

class Dog implements Animal {
  @override
  void eat() {}

  @override
  void sleep() {}
}

abstract class DataRepositoryInterface {
  Future<void> logInUser();

  Future<void> signUpUser();
}

class DataRepository extends DataRepositoryInterface {
  @override
  Future<void> logInUser() async {
    // Implementation...
  }

  @override
  Future<void> signUpUser() async {
    // Implementation...
  }
}

import 'dart:convert';

import 'package:hive/hive.dart' show Box;

abstract class ILocalDataSource {
  SomeModel getSomeModel();
  Future<void> saveSomeModel(SomeModel model);
}

class LocalDataSource implements ILocalDataSource {
  LocalDataSource({required Box box}) : _box = box;

  final Box _box;

  @override
  SomeModel getSomeModel() {
    try {
      final encodedJson = _box.get('model_key');
      final model = SomeModel.fromJson(json.decode(encodedJson));
      return model;
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveSomeModel(SomeModel model) async {
    try {
      await _box.put('model_key', json.encode(model.toJson()));
    } catch (_) {
      throw CacheException();
    }
  }
}