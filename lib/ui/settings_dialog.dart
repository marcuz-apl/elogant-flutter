import 'package:flutter/material.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Calculation Parameters'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSettingField('GR Clean', '40.0'),
            _buildSettingField('GR Clay', '135.0'),
            _buildSettingField('Neutron Matrix', '15.0'),
            _buildSettingField('Density Matrix', '2.65'),
            _buildSettingField('Archie a', '1.0'),
            _buildSettingField('Archie m', '1.8'),
            _buildSettingField('Archie n', '2.0'),
            _buildSettingField('Rw', '0.45'),
            const Divider(),
            const Text(
              'Cut-offs',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildSettingField('VCL Cut-off', '0.5'),
            _buildSettingField('PHIE Cut-off', '0.1'),
            _buildSettingField('SW Cut-off', '0.6'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Apply'),
        ),
      ],
    );
  }

  Widget _buildSettingField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
