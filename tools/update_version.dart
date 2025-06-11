import 'dart:io';

void main() async {
  final commitCount = await _getGitCommitCount();
  final versionCode = commitCount;
  final versionName = _getVersionName();

  final pubspec = File('pubspec.yaml');
  final lines = await pubspec.readAsLines();

  final newLines = lines.map((line) {
    if (line.startsWith('version:')) {
      return 'version: $versionName+$versionCode';
    }
    return line;
  }).toList();

  await pubspec.writeAsString(newLines.join('\n'));

  // ignore: avoid_print
  print('✅ Updated version: $versionName+$versionCode');
}

Future<int> _getGitCommitCount() async {
  final result = await Process.run('git', ['rev-list', '--count', 'HEAD']);
  return int.parse(result.stdout.toString().trim());
}

String _getVersionName() {
  final now = DateTime.now();
  return '${now.year}.${now.month}.${now.day}';
}
