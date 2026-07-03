import 'package:flutter/material.dart';

class GlobalFooter extends StatelessWidget {
  const GlobalFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Disclaimer
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 14,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              const Text(
                'Disclaimer: Demo usage only.',
                style: TextStyle(fontSize: 11, color: Colors.white54),
              ),
            ],
          ),

          // Center: Copyright
          Row(
            children: [
              const Text(
                'Elogant™ Petrophysics',
                style: TextStyle(fontSize: 11, color: Colors.white70),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '|',
                  style: TextStyle(fontSize: 11, color: Colors.white24),
                ),
              ),
              const Text(
                'Copyright © 2026 by Alfazen Inc.',
                style: TextStyle(fontSize: 11, color: Colors.white70),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '|',
                  style: TextStyle(fontSize: 11, color: Colors.white24),
                ),
              ),
              const Text(
                'Last Updated on 02 July 2026',
                style: TextStyle(fontSize: 11, color: Colors.white70),
              ),
            ],
          ),

          // Right: Social Links
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.mail, size: 14, color: Colors.white54),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(
                  Icons.language,
                  size: 14,
                  color: Colors.white54,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
