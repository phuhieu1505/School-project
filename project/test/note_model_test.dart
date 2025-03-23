import 'package:flutter_test/flutter_test.dart';
import 'package:project/model/notes_model.dart';

void main() {
  group('Note', () {
    test('should create a note with given properties', () {
      final note = Note('1', 'Subtitle', 'Time', 1, 'Title', false);

      expect(note.id, '1');
      expect(note.subtitle, 'Subtitle');
      expect(note.time, 'Time');
      expect(note.image, 1);
      expect(note.title, 'Title');
      expect(note.isDone, false);
    });

    test('should mark a note as done', () {
      final note = Note('1', 'Subtitle', 'Time', 1, 'Title', false);
      note.isDone = true;

      expect(note.isDone, true);
    });

    test('should update note properties', () {
      final note = Note('1', 'Subtitle', 'Time', 1, 'Title', false);

      note.subtitle = 'Updated Subtitle';
      note.title = 'Updated Title';

      expect(note.subtitle, 'Updated Subtitle');
      expect(note.title, 'Updated Title');
    });
  });
}
