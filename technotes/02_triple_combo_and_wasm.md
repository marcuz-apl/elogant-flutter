# Triple Combo Plot & Drift WASM Implementation

## Overview
This implementation tackled two major challenges: building a highly specialized petrophysical visualization (Triple Combo Plot) and fixing a compilation crash by decoupling native SQLite bindings from the Chrome Web compiler.

## Key Changes
1. **Custom Triple Combo Plot**:
   - Built a high-performance `CustomPainter` (`TrackPainter`) to render well logs.
   - Designed 3 distinct tracks (Lithology, Resistivity, Porosity/Sonic) that share a vertically scrolling Y-axis (Depth).
   - Handled complex mathematical transformations including **logarithmic** X-axes (for Resistivity) and **reversed linear** X-axes (for Sonic/Density) which were not supported natively by `fl_chart`.

2. **Drift WASM Database**:
   - Replaced the failing `dart:ffi` Native bindings with Drift's `WasmDatabase` implementation to support running the app in Google Chrome.
   - Downloaded the official `sqlite3.wasm` into the `web/` directory.
   - Refactored `database.dart` to use **conditional imports** (`connection_native.dart` vs `connection_web.dart`) to seamlessly route the compiler to the correct platform logic depending on the build target.

## Outcomes
The web application now successfully compiles and runs in Chrome. When a user uploads a `.LAS` file, it processes the log data into the WASM SQLite database and immediately displays a beautiful, vertically-scrollable Triple Combo Plot matching industry standard aesthetics.
