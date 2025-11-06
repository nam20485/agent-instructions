# Consolonia Development Instructions

self-contained reference for creating, scaling, and validating Consolonia-based console applications with Avalonia interoperability.

<overview>
## Purpose
- Equip agents with end-to-end guidance for building text-mode UIs with Consolonia while reusing Avalonia expertise.
- Highlight packages, tooling, layouts, theming, testing, and integration workflows unique to Consolonia.
- Provide quick-look references, canonical examples, and validation expectations for production-ready console apps.

## Capabilities
- Declarative XAML or Blazor view authoring rendered inside a terminal window.
- Full Avalonia control set (with noted exceptions) plus Consolonia-specific brushes, caret handling, and message boxes.
- Hot reload, live preview, and gallery tooling for rapid prototyping and theming.
- Automated UI verification using Consolonia.NUnit test harnesses.
</overview>

<technology_stack>
## Core Platform
- Target .NET 9.0.102 SDK (aligns with repo `global.json`).
- Requires Avalonia UI 11+ concepts (XAML markup, MVVM, data binding).
- Consolonia runtime extends Avalonia to render UI elements as console characters; it shares the Avalonia dependency graph.

## NuGet Packages
| Package | Purpose |
|---------|---------|
| `Consolonia` | Meta-package bundling all runtime dependencies for console apps. |
| `Consolonia.Core` | Core rendering engine and console host integration. |
| `Consolonia.Platform` | Platform abstractions for Windows, macOS, and Linux terminals. |
| `Consolonia.PlatformSupport` | Auto-detects OS console capabilities and wires host adapters. |
| `Consolonia.Controls` | Consolonia-specific controls, brushes, and caret utilities. |
| `Consolonia.Themes` | Modern and TurboVision-inspired theme resource dictionaries. |
| `Consolonia.NUnit` | NUnit-based UI test harness (dummy console, key input helpers). |
| `Consolonia.Blazor` | Enables Blazor-style `.razor` bindings on top of Consolonia. |
| `Consolonia.PreviewHost` | CLI preview host for live axaml/project rendering. |
| `Consolonia.Templates` | `dotnet new` templates for scaffolding console projects. |

> Reference: [Consolonia Packages Wiki](https://github.com/jinek/Consolonia/wiki/Packages)
</technology_stack>

<setup>
## Environment Preparation
- Install the .NET 9 SDK (minimum 9.0.102) and ensure `dotnet --info` reports the target version.
- Update PATH for global .NET tools (`dotnet tool install -g ...`).
- Optionally clone [jinek/Consolonia](https://github.com/jinek/Consolonia) to inspect gallery, controls, and tests.

## Install Project Templates
1. `dotnet new install Consolonia.Templates --prerelease`
2. Verify availability: `dotnet new --list | findstr consolonia`
3. Keep templates current by rerunning the install command when new previews drop.

## Create a Project from Template
1. `dotnet new consolonia.app -n MyConsoloniaApp`
2. `cd MyConsoloniaApp`
3. `dotnet run`

The template includes Avalonia-style project structure, `Program.cs`, `App.axaml`, and a basic `MainView`.

## Create a Project from Scratch
Follow [QuickStart-from-scratch](https://github.com/jinek/Consolonia/wiki/QuickStart-from-scratch) when templates are unavailable:
1. `dotnet new console -n MyConsoloniaApp`
2. `dotnet add package Consolonia`
3. Replace `Program.cs` to call `UseConsolonia().UseAutoDetectedConsole()`.
4. Add `App.axaml`, `MainView.axaml`, and backing code-behind per wiki examples.
</setup>

<workflow>
## Development Workflow
1. **Scaffold** using `Consolonia.Templates` or manual setup.
2. **Design UI** in Avalonia XAML (or Blazor components) with console-aware layout (character grids, resource-driven spacing).
3. **Style** using `Consolonia.Themes` and resource dictionaries for margins, padding, and color palettes.
4. **Preview** using `Consolonia.Gallery`, `Consolonia.PreviewHost`, or `XamlPlayground.Console` for rapid iteration.
5. **Implement logic** via MVVM or reactive patterns identical to Avalonia apps.
6. **Test** with `Consolonia.NUnit` to validate rendering and input sequences.
7. **Package** as a .NET console application or blend with multi-platform Avalonia solutions.

### Running & Debugging
- `dotnet run` launches the interactive console window.
- Use VS Code/Visual Studio integrated terminal to debug; breakpoints work identically to Avalonia desktop apps.
- Run `dotnet watch` for continuous compilation; pair with PreviewHost for live reload of axaml files.

### Layout Customization Workflow
1. Define baseline spacing resources (`Spacing`, `FullMargin`) in `App.axaml`.
2. Use style selectors (`<Style Selector="Border.card">`) to centralize character-based layout adjustments.
3. Test different console sizes by setting `PixelBufferSize` in tests or launching with custom console dimensions.
</workflow>

<architecture>
## Console Rendering Model
- Consolonia maps each Avalonia pixel to a single console character cell (monospace).
- Each cell owns a character, foreground, and background color; glyphs include Unicode box-drawing and emoji.
- Layout units (Width, Height, Margin, Padding) translate directly to character counts; treat them as integer design tokens.

## Layout Considerations
- Favor relative layouts (`Grid`, `StackPanel`, `DockPanel`) over absolute positioning to keep designs responsive.
- Use `LineBrush` to draw borders with selectable styles (SingleLine, DoubleLine, Edge, EdgeWide, Bold).
- Leverage Unicode symbols via `SymbolsControl` to express icons without bitmap assets.
- Apply transforms only when resulting geometry remains horizontal or vertical; diagonal transforms are unsupported in text mode.

## Color Strategy
- Set `Foreground` and `Background` per control; rely on theme resources for consistency.
- Use `BrightenBrush`, `ShadeBrush`, and other Consolonia brushes to fine-tune terminal palettes.

> Reference: [Architecture Wiki](https://github.com/jinek/Consolonia/wiki/Architecture)
</architecture>

<controls>
## Avalonia Control Coverage
- Majority of core Avalonia controls are implemented (`Button`, `TextBox`, `TabControl`, `TreeView`, `DataGrid`, etc.).
- Review the [Controls compatibility matrix](https://github.com/jinek/Consolonia/wiki/Controls) to confirm availability; `ColorPicker` is currently unimplemented.
- Services such as `IClipboard`, `ILauncher`, and `IScreenImpl` are available, while advanced IME features remain in development.

## Consolonia-Specific Controls & Brushes
- `LineBrush`: Configure border rendering with multiple line styles per edge.
- `LineSeparator`: Vertical or horizontal separators using a chosen brush.
- `SymbolsControl`: Render single characters or fill regions with repeating symbols.
- `CaretControl`: Manage caret visibility, style, and margins within templates.

## Windowing & Dialogs
- Consolonia substitutes Avalonia `Window` with `consolonia:Window` overlaying the main console buffer.
- Use `Show`, `Hide`, or `ShowDialog(owner)` for modal flows; dialogs return typed results via `Close(result)`.
- `MessageBox` helper supports simple dialogs or fully customized button content.

> References: [Consolonia Controls Wiki](https://github.com/jinek/Consolonia/wiki/Consolonia-Controls), [Windows & Dialogs Wiki](https://github.com/jinek/Consolonia/wiki/Windows-%26-Dialogs)
</controls>

<themes>
## Theme Options
- `ModernTheme` (Light/Dark) – crisp, Unicode-driven framing.
- `ModernContrastTheme` – high-contrast accessibility variant.
- `TurboVisionTheme`, `TurboVisionDarkTheme`, `TurboVisionElegantTheme`, `TurboVisionGrayTheme`, `TurboVisionCompatibleTheme` – modernized Turbo Pascal aesthetics.

## Applying Themes
- Add theme resources in `App.axaml`:

```xml
<Application xmlns="https://github.com/avaloniaui"
						 xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
						 xmlns:console="https://github.com/jinek/consolonia"
						 RequestedThemeVariant="Default">
	<Application.Styles>
		<console:ModernTheme />
	</Application.Styles>
</Application>
```

- Switch variants at runtime via `Application.RequestedThemeVariant` or user preferences.
- Combine with additional style includes (e.g., `Consolonia.AvaloniaEdit/Theme.axaml`).

> Reference: [Themes Wiki](https://github.com/jinek/Consolonia/wiki/Themes)
</themes>

<tools>
## CLI & Preview Tooling

### dotnet new Templates
- Command: `dotnet new consolonia.app -n <ProjectName>`
- Provides ready-to-run console host with sample view.

### Consolonia.Gallery
- Install: `dotnet tool install -g Consolonia.Gallery --prerelease`
- Launch via `Consolonia.Gallery` to explore interactive control demos and theme previews.
- Source: [`src/Consolonia.Gallery`](https://github.com/jinek/Consolonia/tree/pre-main/src/Consolonia.Gallery)

### XamlPlayground.Console
- Install: `dotnet tool install -g XamlPlayground.Console`
- Run `xamlplayground` for sandboxed Avalonia/Consolonia markup experimentation with hot reload.
- Repository: [tomlm/XamlPlayground.Console](https://github.com/tomlm/XamlPlayground.Console)

### Consolonia.PreviewHost
- Install: `dotnet tool install -g Consolonia.PreviewHost --prerelease`
- Preview single files or projects: `Consolonia.PreviewHost <path-to-axaml|csproj|folder>`
- Supports watch mode with automatic refresh; integrate with VS Code or Visual Studio terminals.

> Reference: [Tools Wiki](https://github.com/jinek/Consolonia/wiki/Tools)
</tools>

<testing>
## Test Infrastructure
- Reference `Consolonia.NUnit` from the test project.
- Derive tests from `ConsoloniaAppTestBase<TApp>` to boot the app inside an in-memory console.
- Control console dimensions via `PixelBufferSize` passed to the base constructor.

## Interaction Helpers
- `UITest.KeyInput(params Key[] keys)` sends simulated keystrokes.
- `UITest.AssertHasText(params string[] regex)` asserts rendered buffer matches expectations.
- `UITest.AssertHasNoText(params string[] regex)` verifies absence of text.

## Running Tests
- Execute `dotnet test` (works cross-platform).
- Combine with CI pipelines to guard regressions; capture console snapshots for diagnostics.

> References: [`src/Consolonia.NUnit`](https://github.com/jinek/Consolonia/tree/pre-main/src/Consolonia.NUnit), [Unit Testing Wiki](https://github.com/jinek/Consolonia/wiki/Unit-Testing)
</testing>

<blazor_support>
## Blazor Bindings Integration
- Add package reference: `<PackageReference Include="Consolonia.Blazor" />`
- Configure builder: replace `.UseConsolonia()` with `.UseConsoloniaBlazor()` in `BuildAvaloniaApp()`.
- Author `.razor` components with full IntelliSense, dependency injection, and hot reload.
- Use services such as `INavigation` and `ISingleViewApplicationLifetime` for navigation and lifecycle.
- Show dialogs from Blazor handlers with `new MessageBox().ShowDialogAsync(...)`.

> Reference: [Consolonia.Blazor Wiki](https://github.com/jinek/Consolonia/wiki/Consolonia.Blazor)
</blazor_support>

<multi_platform>
## Integrating with Existing Avalonia Solutions
1. Install templates and add a new console host project (`dotnet new consolonia.app -n MyApp.Console`).
2. Reference the shared UI project (`MyApp.Console` → `MyApp` shared library).
3. Derive the console `App` class from the shared Avalonia `App` to reuse resources.
4. Remove redundant `MainWindow` from the console project; rely on shared views.
5. Override styles in the console project to adjust spacing and layout for character cells.

## Layout Adaptation
- Centralize spacing via shared resources (`<x:Double x:Key="Spacing">1</x:Double>`).
- Use CSS-class-like selectors (`class="card"`) to adjust border thickness for console rendering.
- Validate on multiple OS terminals; adjust fonts and colors for accessibility.
- Review the HexView port case study for a full walkthrough of migrating desktop layouts to Consolonia character grids ([Porting a GUI app to Console](https://medium.com/@tomlairdmcconnell/porting-a-gui-app-to-console-fbbf8ec32aa8)).

> Reference: [Multiple Platforms Wiki](https://github.com/jinek/Consolonia/wiki/Multiple-Platforms)
</multi_platform>

<platform_specific>
## Platform-Specific Markup
- Use `console:OnPlatformEx` (extension of Avalonia `OnPlatform`) to tailor content for Console, Windows, Linux, etc.
- Inline example:

```xml
<TextBlock Text="{console:OnPlatformEx 'Unknown', Windows='Windows', Console='Console', Linux='Linux'}" />
```

- Full markup example:

```xml
<console:OnPlatformEx>
	<console:OnPlatformEx.Default>
		<TextBlock Text="This is not the console platform." />
	</console:OnPlatformEx.Default>
	<console:OnPlatformEx.Console>
		<TextBlock Text="Console-specific layout" />
	</console:OnPlatformEx.Console>
</console:OnPlatformEx>
```

> Reference: [Platform Specific Code Wiki](https://github.com/jinek/Consolonia/wiki/platform%20specific%20code)
</platform_specific>

<examples>
## Example: `Program.cs`

```csharp
using Avalonia;
using Consolonia;

public static class Program
{
		public static void Main(string[] args)
		{
				BuildAvaloniaApp()
						.UseConsolonia()
						.UseAutoDetectedConsole()
						.StartWithConsoleLifetime(args);
		}

		public static AppBuilder BuildAvaloniaApp() =>
				AppBuilder.Configure<App>()
									.LogToTrace();
}
```

## Example: `App.axaml`

```xml
<Application xmlns="https://github.com/avaloniaui"
						 xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
						 xmlns:console="https://github.com/jinek/consolonia"
						 x:Class="MyConsoloniaApp.App"
						 RequestedThemeVariant="Default">
	<Application.Styles>
		<console:ModernTheme />
		<StyleInclude Source="avares://Consolonia.AvaloniaEdit/Theme.axaml" />
	</Application.Styles>
	<Application.Resources>
		<x:Double x:Key="Spacing">1</x:Double>
		<Thickness x:Key="FullMargin">1,1,1,1</Thickness>
	</Application.Resources>
</Application>
```

## Example: `MainView.axaml`

```xml
<UserControl xmlns="https://github.com/avaloniaui"
						 xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
						 xmlns:console="https://github.com/jinek/consolonia"
						 x:Class="MyConsoloniaApp.MainView">
	<Grid RowDefinitions="Auto,*" ColumnDefinitions="*,*" Margin="{StaticResource FullMargin}">
		<TextBlock Grid.ColumnSpan="2"
							 Text="Welcome to Consolonia"
							 Classes="title"
							 HorizontalAlignment="Center"
							 Margin="0,0,0,{StaticResource Spacing}" />
		<Border Grid.Row="1"
						Grid.Column="0"
						BorderThickness="1"
						BorderBrush="Purple">
			<Border.BorderBrush>
				<console:LineBrush LineStyle="Edge" Brush="Purple" />
			</Border.BorderBrush>
			<StackPanel Spacing="{StaticResource Spacing}" Margin="1">
				<Button Content="Gallery" Command="{Binding OpenGalleryCommand}" />
				<Button Content="Preview" Command="{Binding OpenPreviewCommand}" />
			</StackPanel>
		</Border>
		<console:SymbolsControl Grid.Row="1"
														Grid.Column="1"
														Text="★"
														Fill="True"
														Foreground="Gold" />
	</Grid>
</UserControl>
```

## Example: UI Test

```csharp
using Consolonia.NUnit;
using NUnit.Framework;

[TestFixture]
public class MainViewTests : ConsoloniaAppTestBase<App>
{
		public MainViewTests()
				: base(new PixelBufferSize(120, 40))
		{
		}

		[Test]
		public async Task ShowsWelcomeMessage()
		{
				await UITest.AssertHasText("Welcome to Consolonia");
				await UITest.KeyInput(Key.Tab, Key.Enter);
				await UITest.AssertHasNoText("Unhandled Exception");
		}
}
```
</examples>

<validation>
## Validation Checklist
- `dotnet build` – ensures console host and resource dictionaries compile.
- `dotnet test` – executes Consolonia.NUnit scenarios.
- `Consolonia.PreviewHost` – renders axaml files to confirm styling.
- Manual QA using `Consolonia.Gallery` for control comparisons.
</validation>

<resources>
## Reference Library
- [Consolonia Repository (pre-main)](https://github.com/jinek/Consolonia/tree/pre-main)
- [QuickStart Wiki](https://github.com/jinek/Consolonia/wiki/QuickStart)
- [QuickStart from Scratch](https://github.com/jinek/Consolonia/wiki/QuickStart-from-scratch)
- [Tools Wiki](https://github.com/jinek/Consolonia/wiki/Tools)
- [Controls Wiki](https://github.com/jinek/Consolonia/wiki/Controls)
- [Consolonia Controls Wiki](https://github.com/jinek/Consolonia/wiki/Consolonia-Controls)
- [Themes Wiki](https://github.com/jinek/Consolonia/wiki/Themes)
- [Unit Testing Wiki](https://github.com/jinek/Consolonia/wiki/Unit-Testing)
- [Platform Specific Code Wiki](https://github.com/jinek/Consolonia/wiki/platform%20specific%20code)
- [Multiple Platforms Wiki](https://github.com/jinek/Consolonia/wiki/Multiple-Platforms)
- [Consolonia — Avalonia for Console Applications (Medium)](https://medium.com/@tomlairdmcconnell/consolonia-avalonia-for-console-applications-4eb13b3d487b)
- [Porting a GUI app to Console (Medium)](https://medium.com/@tomlairdmcconnell/porting-a-gui-app-to-console-fbbf8ec32aa8)
</resources>

<additional_modules>
## Related Instruction Modules
- [ai-application-development-guide.md](./ai-application-development-guide.md) – overarching application patterns for .NET/Avalonia.
- [ai-development-environment-guide.md](./ai-development-environment-guide.md) – environment setup, terminal management, PowerShell usage.
- [ai-testing-validation.md](./ai-testing-validation.md) – repository-wide validation expectations.
- [ai-quick-reference.md](./ai-quick-reference.md) – fast lookup for repo conventions.
</additional_modules>
