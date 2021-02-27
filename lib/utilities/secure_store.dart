import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class SecureStore {
  // Create storage
  final storage = FlutterSecureStorage();

  // Read value
  readValue({@required String key}) async {
    String value = await storage.read(key: key);
    return value;
  }

  // Write value
  writeValue({@required String key, @required String value}) async {
    await storage.write(key: key, value: value);
  }

  // delete all
  deleteAll() async {
    await storage.deleteAll();
  }
}
