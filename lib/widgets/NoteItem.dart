import 'package:flutter/material.dart';

import 'package:testblocapp/notes/models/Note.dart';

class NoteItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Note note;

  NoteItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key('__note_item_${note.id}'),
        onDismissed: onDismissed,
        child: Card(
          child: ListTile(
            onTap: onTap,
            title: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  note.title,
                ),
              ),

            subtitle: note.note.isNotEmpty
                ? Text(
                    note.note,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
          ),
        ));
  }
}
