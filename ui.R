#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)
library(plyr)
nutrient_data=read.table("nutrient_amount_per100gfood_data_forshiny.txt",
                         header=T,sep="\t",stringsAsFactors = F,comment.char = "",quote = "")
food_names=unique(nutrient_data$FoodDescription)

# Define UI for application that calculates carb and calories from food items
shinyUI(fluidPage(

    # Application title
    titlePanel("Food nutrient calculator"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        
        sidebarPanel(
            h3("food item 1:"),
            selectInput(
                "food_id_1", "Choose Food Item 1", choices = food_names
                ),
            numericInput(
                "Food_amount_1","unit grams consumed", min=1,step=1,value=100
                ),
            actionButton("add_food_1","add_food_1"),
            
            h3("food item 2:"),
            selectInput(
                "food_id_2", "Choose Food Item 2", choices = food_names
            ),
            numericInput(
                "Food_amount_2","unit grams consumed", min=1,step=1,value=100
            ),
            actionButton("add_food_2","add_food_2"),
            
            h3("food item 3:"),
            selectInput(
                "food_id_3", "Choose Food Item 3", choices = food_names
            ),
            numericInput(
                "Food_amount_3","unit grams consumed", min=1,step=1,value=100
            ),
            actionButton("add_food_3","add_food_3")#,
            ),
        
            mainPanel(
                tabsetPanel(type = "tabs",
                            tabPanel("How to",
                                     h4("data source: https://www.canada.ca/en/health-canada/services/food-nutrition/healthy-eating/nutrient-data/canadian-nutrient-file-2015-download-files.html"),
                                     h4("select 3 food items on the left and click 'add_food' botton to display nutritions"),
                                     h4("code files available on Github at: https://github.com/qingmaopsu/shiny_app_assignment")),
                            tabPanel("Food1_nutrients",plotlyOutput("food_1_plot"),
                                     textOutput("food1_name")),
                            tabPanel("Food2_nutrients",plotlyOutput("food_2_plot"),
                                     textOutput("food2_name")),
                            tabPanel("Food3_nutrients",plotlyOutput("food_3_plot"),
                                     textOutput("food3_name")),
                            tabPanel("comb_nutrients",plotlyOutput("comb_plot"),
                                     textOutput("comb_name"))
                )
                )
        )
    
))
