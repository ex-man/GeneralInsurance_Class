ui <- fluidPage(
  titlePanel("Scatter Plot with colour"),
  selectInput(
    "select",
    label = "Colouring Var:",
    choices = list("Region", "Unit", "Segment", "Business", "Year")
  ),
  plotOutput(outputId = "graph")
)