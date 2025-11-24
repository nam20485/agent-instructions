# Consolonia Examples

## Example 1: Program.cs

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

## Example 2: App.axaml

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

## Example 3: MainView.axaml

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

## Example 4: UI Test

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

## Example 5: Platform-Specific Markup

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
