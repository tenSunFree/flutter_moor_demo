import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'database/database.dart';

class Repository {
  final Database database;

  final BehaviorSubject<LoginEntity> _loginEntitySubject =
      BehaviorSubject.seeded(null);

  Observable<LoginEntity> _loginEntityObservable;

  Observable<LoginEntity> get loginEntityObservable => _loginEntityObservable;

  Repository() : database = Database() {
    _loginEntityObservable =
        _loginEntitySubject.switchMap(database.watchLoginEntityStream);
  }

  void insertLoginEntity(String email, String password) {
    debugPrint('repository.dart, insertLoginEntity');
    database.insertLoginEntity(
        LoginTableCompanion(email: Value(email), password: Value(password)));
  }

  void close() {
    database.close();
    _loginEntitySubject.close();
  }
}
