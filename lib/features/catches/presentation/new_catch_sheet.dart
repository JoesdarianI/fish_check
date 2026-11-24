import 'package:fish_check/features/catches/presentation/blocs/catch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCatchSheet extends StatefulWidget {
  const NewCatchSheet({super.key});

  @override
  State<NewCatchSheet> createState() => _NewCatchSheetState();
}

class _NewCatchSheetState extends State<NewCatchSheet> {
  final _formKey = GlobalKey<FormState>();
  final _species = TextEditingController();
  final _location = TextEditingController();
  final _note = TextEditingController();

  @override
  void dispose() {
    _species.dispose();
    _location.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<CatchCubit>().addCatch(
          species: _species.text.trim(),
          locationName: _location.text.trim(),
          latitude: 46.805,
          longitude: -121.726,
          note: _note.text.trim(),
        );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.viewInsetsOf(context).bottom + 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Log a catch', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 18),
            TextFormField(
              controller: _species,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Fish species', prefixIcon: Icon(Icons.phishing)),
              validator: (value) => value == null || value.trim().isEmpty ? 'Add a species.' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _location,
              decoration: const InputDecoration(labelText: 'Spot name', prefixIcon: Icon(Icons.place_outlined)),
              validator: (value) => value == null || value.trim().isEmpty ? 'Add a spot name.' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _note,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Note (optional)', prefixIcon: Icon(Icons.notes)),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save catch'),
            ),
          ],
        ),
      ),
    );
  }
}
