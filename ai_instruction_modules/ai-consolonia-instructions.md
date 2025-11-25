---
description: Guide for building console applications with Consolonia (Avalonia UI for terminal).
scope: consolonia
prerequisites: ai-application-development-guide.md
context: opt-in
---
# Consolonia Development Instructions

<xml>
<instructions role="ui-developer" scope="consolonia">

<overview>
## Overview
Consolonia enables building text-mode UIs using Avalonia XAML/Blazor. It renders UI elements as console characters.

- **Core:** .NET 9.0.102+, Avalonia 11+.
- **Features:** XAML/Blazor, Hot Reload, UI Testing, Cross-platform.
</overview>

<setup>
## Setup & Templates
1. **Install Templates:** `dotnet new install Consolonia.Templates --prerelease`
2. **Create App:** `dotnet new consolonia.app -n MyApp`
3. **Run:** `dotnet run`
</setup>

<workflow>
## Development Workflow
1. **Design:** Use Avalonia XAML/Blazor. Use `Grid`/`StackPanel` for layout.
2. **Style:** Use `Consolonia.Themes` (Modern, TurboVision).
3. **Preview:** Use `Consolonia.PreviewHost` or `XamlPlayground.Console`.
4. **Test:** Use `Consolonia.NUnit` for UI testing.

### Key Concepts
- **Units:** Width/Height/Margin are character counts.
- **Brushes:** `LineBrush` (borders), `SymbolsControl` (icons).
- **Dialogs:** `consolonia:Window` overlays, `MessageBox`.
</workflow>

<tools>
## Tools
- **Gallery:** `dotnet tool install -g Consolonia.Gallery --prerelease`
- **Preview:** `dotnet tool install -g Consolonia.PreviewHost --prerelease`
- **Playground:** `dotnet tool install -g XamlPlayground.Console`
</tools>

<examples>
## Examples
<see example="examples/consolonia-examples.md" />
</examples>

<resources>
## References
- [Consolonia Wiki](https://github.com/jinek/Consolonia/wiki)
- [Packages](https://github.com/jinek/Consolonia/wiki/Packages)
- [Controls](https://github.com/jinek/Consolonia/wiki/Controls)
</resources>

</instructions>
</xml>
