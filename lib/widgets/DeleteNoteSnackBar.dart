import 'package:flutter/material.dart';

import 'package:testblocapp/notes/models/Note.dart';

class DeleteNoteSnackBar extends SnackBar {
  DeleteNoteSnackBar({
    @required Note note,
    @required VoidCallback onUndo,
  }) : super(
          content: Text(
            'Видалити ${note.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Відмінити',
            onPressed: onUndo,
          ),
        );
}
