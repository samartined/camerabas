import 'package:equatable/equatable.dart';

class SSHConfig extends Equatable {
  final String host;
  final String username;
  final String? password;
  final String? privateKeyPath;
  final int port;
  final String motionCommand;
  final String motionStopCommand;

  const SSHConfig({
    required this.host,
    required this.username,
    this.password,
    this.privateKeyPath,
    this.port = 22,
    required this.motionCommand,
    required this.motionStopCommand,
  });

  @override
  List<Object?> get props => [
    host,
    username,
    password,
    privateKeyPath,
    port,
    motionCommand,
    motionStopCommand,
  ];

  SSHConfig copyWith({
    String? host,
    String? username,
    String? password,
    String? privateKeyPath,
    int? port,
    String? motionCommand,
    String? motionStopCommand,
  }) {
    return SSHConfig(
      host: host ?? this.host,
      username: username ?? this.username,
      password: password ?? this.password,
      privateKeyPath: privateKeyPath ?? this.privateKeyPath,
      port: port ?? this.port,
      motionCommand: motionCommand ?? this.motionCommand,
      motionStopCommand: motionStopCommand ?? this.motionStopCommand,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'host': host,
      'username': username,
      'password': password,
      'privateKeyPath': privateKeyPath,
      'port': port,
      'motionCommand': motionCommand,
      'motionStopCommand': motionStopCommand,
    };
  }

  factory SSHConfig.fromMap(Map<String, dynamic> map) {
    return SSHConfig(
      host: map['host'] as String,
      username: map['username'] as String,
      password: map['password'] as String?,
      privateKeyPath: map['privateKeyPath'] as String?,
      port: map['port'] as int? ?? 22,
      motionCommand: map['motionCommand'] as String? ?? 'sudo systemctl start motion',
      motionStopCommand: map['motionStopCommand'] as String? ?? 'sudo systemctl stop motion',
    );
  }
}
