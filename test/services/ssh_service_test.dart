import 'package:camerabas/models/ssh_config.dart';
import 'package:camerabas/services/ssh_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ssh2/ssh2.dart';
import 'package:test/test.dart';
import 'ssh_service_test.mocks.dart';

@GenerateMocks([SSHClient])
void main() {
  late MockSSHClient mockSSHClient;
  late SSHService sshService;
  late SSHConfig config;

  setUp(() {
    mockSSHClient = MockSSHClient();
    config = SSHConfig(
      host: 'test.com',
      username: 'test',
      motionCommand: 'sudo systemctl start motion',
      motionStopCommand: 'sudo systemctl stop motion',
    );
    sshService = SSHService(config: config, client: mockSSHClient);
  });

  group('SSHService Tests', () {
    test(
      'checkConnection returns true when connection is successful',
      () async {
        when(mockSSHClient.connect()).thenAnswer((_) async => null);
        when(mockSSHClient.disconnect()).thenAnswer((_) async => null);

        final result = await sshService.checkConnection();

        expect(result, true);
        verify(mockSSHClient.connect()).called(1);
        verify(mockSSHClient.disconnect()).called(1);
      },
    );

    test('checkConnection returns false when connection fails', () async {
      when(mockSSHClient.connect()).thenThrow(Exception('Connection failed'));

      final result = await sshService.checkConnection();

      expect(result, false);
    });

    test('connect returns true when connection is successful', () async {
      when(mockSSHClient.connect()).thenAnswer((_) async => null);

      final result = await sshService.connect();

      expect(result, true);
      verify(mockSSHClient.connect()).called(1);
    });

    test('connect returns false when connection fails', () async {
      when(mockSSHClient.connect()).thenThrow(Exception('Connection failed'));

      final result = await sshService.connect();

      expect(result, false);
    });

    test('executeCommand returns command output when successful', () async {
      when(mockSSHClient.connect()).thenAnswer((_) async => null);
      when(mockSSHClient.execute('test command')).thenAnswer((_) async => 'command output');
      
      final result = await sshService.executeCommand('test command');
      
      expect(result, 'command output');
      verify(mockSSHClient.execute('test command')).called(1);
    });

    test('executeCommand throws exception when connection fails', () async {
      when(mockSSHClient.connect()).thenThrow(Exception('Connection failed'));
      
      expect(
        () => sshService.executeCommand('test command'),
        throwsException,
      );
    });

    test('executeCommand throws exception when command execution fails', () async {
      when(mockSSHClient.connect()).thenAnswer((_) async => null);
      when(mockSSHClient.execute('test command')).thenThrow(Exception('Command failed'));
      
      expect(
        () => sshService.executeCommand('test command'),
        throwsException,
      );
    });
  });
}
