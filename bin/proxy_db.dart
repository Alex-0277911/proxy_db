// Pattern Proxy дозволяє створити проміжний об'єкт, який контролює доступ до
// іншого об'єкту. Цей шаблон часто використовується для кешування даних,
// зниження навантаження на мережу або забезпечення контролю доступу до
// віддалених ресурсів.

// Pattern Proxy Dart з використанням класу, що отримує доступ до віддаленої
// бази даних через мережу.

// Створюємо абстрактний клас Database, який визначає метод readData().

abstract class Database {
  Future<String> readData();
}

// Клас RemoteDatabase реалізує цей метод і забезпечує доступ до віддаленої
// бази даних через мережу.

class RemoteDatabase implements Database {
  // реалізуємо метод з абстрактного класу
  @override
  Future<String> readData() async {
    // Симулюємо час на доступ до бази даних через мережу
    await Future.delayed(Duration(seconds: 5));
    return 'Data from remote database';
  }
}

// Клас DatabaseProxy є проксі-об'єктом, який зберігає
// посилання на об'єкт RemoteDatabase і кешує отримані дані. Коли метод
// readData() викликається на об'єкті DatabaseProxy, він перевіряє, чи є
// кешовані дані, якщо так, то повертає їх, інакше викликає метод readData()
// на об'єкті RemoteDatabase та кешує результат.

class DatabaseProxy implements Database {
  final RemoteDatabase _remoteDatabase = RemoteDatabase();
  String _cachedData = '';

  @override
  Future<String> readData() async {
    if (_cachedData == '') {
      _cachedData = await _remoteDatabase.readData();
    }
    return _cachedData;
  }
}

Future<void> main() async {
  // створюємо проксі до БД
  final database = DatabaseProxy();

  print('Read data from database:');
  // Викликається доступ до віддаленої бази даних
  print(await database.readData());

  print('Read data from cache:');
  // Кешовані дані повертаються миттєво
  print(await database.readData());
}
