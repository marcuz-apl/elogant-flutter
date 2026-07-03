# Global Agent Customizations

## Architecture & Technology Stack
- **Framework:** The project must strictly use **Flutter (Dart)** for all UI, data processing, and platform wrappers.
- **No Python Backend:** We are using a Pure Flutter architecture. Do NOT introduce Python scripts or backend wrappers (like FastAPI) into the core application runtime. All petrophysical logic must be translated to Dart.
- **Data Parsing:** Use the Dart `las_dart` package for reading `.LAS` files.
- **Visualizations:** Use interactive Flutter charting libraries for multi-track plotting (e.g., `fl_chart`, `syncfusion_flutter_charts`, or custom Canvas widgets).

## Design & Aesthetics
- **Premium UI:** The application must feature a "sleek interface". Prioritize modern web and desktop design principles: dynamic animations, clean typography, appropriate spacing, and glassmorphism where appropriate. Avoid basic MVP looks.
- **Responsiveness:** Ensure UI widgets scale correctly between Desktop window sizes and Web browsers.

## Development Workflow
- **Step-by-Step:** Develop in incremental, testable chunks. Do not attempt to deliver the entire application in a single monolithic commit.
- **Documentation:** Always preserve mathematical formulas and their context when translating from Python to Dart.

## Implementation Plans
- **Tech Notes:** For every Implementation Plan that is created and executed, you MUST summarize it and save the summary to the `./technotes/` directory in a markdown file.
