#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    nutrient_food_1 <- eventReactive(input$add_food_1,{
        nutrient_data_1=nutrient_data[nutrient_data$FoodDescription==input$food_id_1,]
        nutrient_data_1$NutrientAmount=nutrient_data_1$NutrientValue/100*input$Food_amount_1
        nutrient_data_1
    })
    
   # nutrient_food_1<-reactive({
#        nutrient_food_1=subset(nutrient_food_1_temp(),FoodDescription==input$food_id_1)
#        nutrient_food_1
#    })
    
    output$food1_name=renderText({
        if(nrow(nutrient_food_1())>0){
            paste(input$food_id_1,": ",input$Food_amount_1,"g",sep="")
        }
        })
    
    
    output$food_1_plot <- renderPlotly({
            nutrient_food_1_plot=ggplot(data=subset(nutrient_food_1(),FoodDescription==input$food_id_1))+
                geom_col(aes(x=NutrientName,y=NutrientAmount,fill=NutrientName))+
                theme_bw()+
                theme(panel.grid = element_blank(),legend.position = "none",axis.text.x = element_text(size=8))
            
            ggplotly(nutrient_food_1_plot)
        })
    #####################################################
    nutrient_food_2 <- eventReactive(input$add_food_2,{
        nutrient_data_2=nutrient_data[nutrient_data$FoodDescription==input$food_id_2,]
        nutrient_data_2$NutrientAmount=nutrient_data_2$NutrientValue/100*input$Food_amount_2
        nutrient_data_2
    })
    
    output$food2_name=renderText({
        if(nrow(nutrient_food_2())>0){
            paste(input$food_id_2,": ",input$Food_amount_2,"g",sep="")
        }
    })
    
    
    output$food_2_plot <- renderPlotly({
        nutrient_food_2_plot=ggplot(data=subset(nutrient_food_2(),FoodDescription==input$food_id_2))+
            geom_col(aes(x=NutrientName,y=NutrientAmount,fill=NutrientName))+
            theme_bw()+
            theme(panel.grid = element_blank(),legend.position = "none",axis.text.x = element_text(size=8))
        
        ggplotly(nutrient_food_2_plot)
    })
    #####################################################
    nutrient_food_3 <- eventReactive(input$add_food_3,{
        nutrient_data_3=nutrient_data[nutrient_data$FoodDescription==input$food_id_3,]
        nutrient_data_3$NutrientAmount=nutrient_data_3$NutrientValue/100*input$Food_amount_3
        nutrient_data_3
    })
    
    output$food3_name=renderText({
        if(nrow(nutrient_food_3())>0){
            paste(input$food_id_3,": ",input$Food_amount_3,"g",sep="")
        }
    })
    
    
    output$food_3_plot <- renderPlotly({
        nutrient_food_3_plot=ggplot(data=subset(nutrient_food_3(),FoodDescription==input$food_id_3))+
            geom_col(aes(x=NutrientName,y=NutrientAmount,fill=NutrientName))+
            theme_bw()+
            theme(panel.grid = element_blank(),legend.position = "none",axis.text.x = element_text(size=8))
        
        ggplotly(nutrient_food_3_plot)
    })
    #####################################################
    nutrient_food_comb <- eventReactive(input$add_food_3,{
        nutrient_comb=rbind(nutrient_food_1(),nutrient_food_2())
        nutrient_comb=rbind(nutrient_comb,nutrient_food_3())
        #nutrient_comb=ddply(nutrient_comb,.(NutrientName),summarize,NutrientAmount=sum(NutrientAmount))
        nutrient_comb
    })
    
    output$comb_name=renderText({
        paste(input$food_id_1,": ",input$Food_amount_1,"g; ",
              input$food_id_2,": ",input$Food_amount_2,"g; ",
              input$food_id_3,": ",input$Food_amount_3,"g",sep="")
    })
    
    
    output$comb_plot <- renderPlotly({
        comb_plot=ggplot(data=nutrient_food_comb())+
            geom_col(aes(x=NutrientName,y=NutrientAmount,fill=NutrientName))+
            theme_bw()+
            theme(panel.grid = element_blank(),legend.position = "none",axis.text.x = element_text(size=8))
        
        ggplotly(comb_plot)
    })
})
