
fluidPage(
  titlePanel("Hotel Booking Demand 2015"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "arrival_date_month",
                     label = "Arrival Month",
                     choices = unique(travel$arrival_date_month)),
    ),
    mainPanel(
      fluidRow(
      column(7, plotOutput("count")),
      column(5, plotOutput("lead"))
  )
)
)
)