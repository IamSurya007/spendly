import 'dart:io';
import 'dart:convert';

void main() {
  final file = File('C:\\Users\\sheik\\.gemini\\antigravity\\brain\\e65adaea-268a-41c1-8534-9dc9aa104cca\\.system_generated\\logs\\transcript.jsonl');
  if (file.existsSync()) {
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      final json = jsonDecode(line);
      if (json['type'] == 'USER_INPUT') {
        print('=== USER INPUT ===');
        print(json['content']);
        break; // print only the first one
      }
    }
  } else {
    print('transcript.jsonl not found');
  }
}
