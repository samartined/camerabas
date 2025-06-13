import 'package:camerabas/models/ssh_config.dart';
import 'package:ssh2/ssh2.dart';

class SSHService {
  SSHClient? _client;
  final SSHConfig config;

  SSHService({required this.config, SSHClient? client}) : _client = client;

  // Method to check the connection
  Future<bool> checkConnection() async {
    try {
      final client =
          _client ??
          SSHClient(
            host: config.host,
            port: config.port,
            username: config.username,
            passwordOrKey: config.password ?? config.privateKeyPath,
          );

      await client.connect();
      await client.disconnect();

      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to connect
  Future<bool> connect() async {
    try {
      _client ??= SSHClient(
        host: config.host,
        port: config.port,
        username: config.username,
        passwordOrKey: config.password ?? config.privateKeyPath,
      );

      await _client!.connect();
      return true;
    } catch (e) {
      _client = null;
      return false;
    }
  }

  // Method to disconnect
  Future<void> disconnect() async {
    try {
      if (_client != null) {
        await _client!.disconnect();
      }
    } catch (e) {
      _client = null;
      throw Exception('Error al desconectar: $e');
    }
  }

  // Method to execute commands
  Future<String> executeCommand(String command) async {
    try {
      if (_client != null) {
        final connected = await connect();
        if (!connected) {
          throw Exception('No se pudo establecer la conexión SSH');
        }
      }

      final result = await _client!.execute(command);
      return result.toString();
    } catch (e) {
      _client = null;
      throw Exception('Error al ejecutar el comando: $e');
    }
  }
}
