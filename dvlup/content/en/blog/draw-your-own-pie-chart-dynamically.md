---
title: 'Draw Your Own Xamarin Pie Chart dynamically'
date: Thu, 18 Apr 2019 17:55:53 +0000
draft: false
tags: ['android', 'c#', 'custom control', 'drawing', 'iOS', 'tutorial', 'UI', 'UWP', 'windows', 'windows10', 'Xamarin', 'Xamarin', 'xamarin forms']
---

In this tutorial, I'll show you how to draw your own pie chart just using lines and a list of data items. The code itself is in C#, but the concept can be used on any platform that has a drawing library and ArcSegments.

![](/dvlup-blog/wp-content/uploads/2019/04/2019-04-18_13-44-40.png)

You can view the entire solution in [this GitHub Gist](https://gist.github.com/LanceMcCarthy/b64ee5afdd27b125b8b47816799306e0). Okay, let's get started!

Setting Up
----------

The first thing you'll need to understand is how the platform's drawing library makes arcs. In this code, I'll be using [RadPath](https://docs.telerik.com/devtools/xamarin/controls/path/path-overview) from [Telerik UI for Xamarin](https://www.telerik.com/xamarin-ui) most libraries work the same way. RadPath lets you use a custom Geometry which has [RadArcSegment](https://docs.telerik.com/devtools/xamarin/controls/path/getting-started/geometry-structure#radarcsegment)  object, which has helpful **StartAngle** and **SweepAngle** properties.

Let's start with the data model, with simple **Title** and **Value** properties:

```
public class ChartDataPoint
{
    public string Title { get; set; }
    public double Value { get; set; }
}
```

Next, let's create a list that is populated with some activities to represent a 24 hour period.

```
var dataPoints = new List<ChartDataPoint>
{
    new ChartDataPoint { Title = "Work", Value = 9 },
    new ChartDataPoint { Title = "Commute", Value = 1.5 },
    new ChartDataPoint { Title = "Leisure", Value = 6 },
    new ChartDataPoint { Title = "Sleep", Value = 7.5 },
};
```

Finally, to finish the setup, create a list of colors we can use for the pie slices.

```
var colors = new List<Color>
{
    Color.FromHex("#BAB65A"),
    Color.FromHex("#6196D1"),
    Color.FromHex("#3D4268"),
    Color.FromHex("#8A56E2"),
};
```

Part 1 - Creating the Slices
----------------------------

Now that we have some items, lets move on to generating and drawing the slices. First, we'll create a container to put the pie and legend into. A **Grid** is convenient option because we can have two rows, one for the pie and one for the legend.

```
// Root container to hold the chart and any legend
var container = new Grid();
container.RowDefinitions.Add(new RowDefinition { Height = new GridLength(3, GridUnitType.Star) });
container.RowDefinitions.Add(new RowDefinition { Height = new GridLength(1, GridUnitType.Star) });
```

Now we can start calulating the slice sizes, to do this, we need a total value to get a percentage of that total. We also need a variable to hold the current position on the 360 degree arc where the slices are rendered.

```
// Sum up all the values to be displayed
var totalValue = dataPoints.Sum(d => d.Value);

// Variable to keep track of where each slice ended.
double currentPosition = 0;
```

Now for the guts of the operation. We need iterate over the data points and create the arc segments using the data point's **Value** property. The code comments will guide you through what each line does, in a nustshell here's the lifecycle

*   Calculate the data item's percentage of the total sum
*   Use that percentage to get what percent of 360 degree pie that slice needs
*   Create the RadArcSegment using the current position for the StartAngle and the angle percentage as the SweepAngle
*   Construct the RadPath using the ArgSegment's geometry and a color from the colors list

```
// Iterate over the data points to create slices.
for (int i = 0; i < dataPoints.Count; i++)
{
    // Determine the what percentage that data item's value is of the whole
    double slicePercentage = dataPoints\[i\].Value / totalValue;

    // Calculate the sweep angle using that percentage amount.
    double sweep = slicePercentage \* 360;

    // Create the ArcSegment using the current position and sweep
    var segment = new RadArcSegment
    {
        Center = new Point(0.5, 0.5),
        Size = new Size(1, 1),
        StartAngle = currentPosition,
        SweepAngle = sweep,
    };

    // Important - Calculate the last segment's ending angle in order to have a valid start angle for the next loop.
    currentPosition = currentPosition + sweep - 360;

    // Prepare the required PathFigure and add the ArcSegment
    var figure = new RadPathFigure { StartPoint = new Point(0.5, 0.5) };
    figure.Segments.Add(segment);

    // Create the PathGeometry and add the PathFigure
    var geometry = new RadPathGeometry();
    geometry.Figures.Add(figure);

    // Construct the RadPath
    // - Select a Fill color from the brushes parameter (important: use a modulus to wrap to the beginning)
    // - Use the Geometry created from the value
    var slice = new RadPath
    {
        Fill = new RadSolidColorBrush(colors\[i % colors.Count\]),
        Geometry = geometry,
        HorizontalOptions = LayoutOptions.Center,
        VerticalOptions = LayoutOptions.Center,
        WidthRequest = 100,
        HeightRequest = 100,
        Margin = new Thickness(0, 20, 0, 0)
    };

    // This isn't necessary, but added for completion.
    Grid.SetRow(slice, 0);

    // Finally, add it to the container.
    container.Children.Add(slice);
}
```

At this point, you now have a full 360 degree chart, with colored slices for each of the data points representing their percentage of the whole.

Part 2 - Creating the Legend
----------------------------

The next phase of the operation is to create the legend. This needs to create text for each slice, as well as a marker that matches the same color of that slice. This could have been done in the same loop as creating the slice, but having a separate loop lets you decide to use a legend or not.

Again, we iterate over the data points. This time we use the **Title** property of the data point to create the text. To match the color, we use the same modulus to get index and assign it to a RadBorder that creates a thick bar underneath the text.

```
// Create a horizontal StackLayout to hold the legend items
var legendPanel = new StackLayout
{
    Orientation = StackOrientation.Horizontal,
    HorizontalOptions = LayoutOptions.Center,
    VerticalOptions = LayoutOptions.Center,
    Margin = new Thickness(0, 16, 0, 0),
    Spacing = 5
};

// Iterate over the data points and create a legend item with a matching color
for (int i = 0; i < dataPoints.Count; i++)
{
    // Use a RadBorder with only a bottom thickness and match the color to the slice
    var legendItem = new RadBorder
    {
        BorderColor = colors\[i % colors.Count\],
        BorderThickness = new Thickness(0, 0, 0, 2)
    };

    // Create a Label for each data point and use the Title property
    var label = new Label
    {
        Text = dataPoints\[i\].Title,
        FontSize = 12,
        Margin = new Thickness(0, 0, 0, 2),
        TextColor = Color.DimGray
    };

    legendItem.Content = label;

    legendPanel.Children.Add(legendItem);
}

// Insert the legend panel in the root container's 2nd row.
Grid.SetRow(legendPanel, 1);
container.Children.Add(legendPanel);
```

The last thing to do is add the entire container to the UI. In this example, I'm just setting the entire page's content to the container Grid..

```
this.Content = container;
```

Wrapping Up
-----------

I hope this is useful for those times when you need ultimate control over rendering of a chart. If you need more complex setup, I recommend the [RadPieChart](https://docs.telerik.com/devtools/xamarin/controls/chart/series/pie/pie-series) itself, which is far more feature complete than drawing a few arcs :)