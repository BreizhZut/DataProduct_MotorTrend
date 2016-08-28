#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out mo?mre about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    
    # prepare data for plotting
    pdata <- reactive({
        data.frame(
            model=as.character(row.names(mtcars)),
            x = setvar(input$x),
            y = setvar(input$y),
            col = setfac(input$colf),
            size = setvar(input$sizev)
        )
    })
    
    # Change slider according to columns selection for size  
    observe({
        var <- input$sizev
        if(identical(var,input$x)| identical(var,input$y)){
            # reset 3rd variable checkbox
            updateCheckboxInput(session, "usesize",
                                label=paste("NA"),value=F)
            # rest slider
            updateSliderInput(session, "sval",
                              label="NA",value=50)
        } else{
            updateCheckboxInput(session, "usesize",
                                label=paste("Use ",input$sizev))
            if(input$usesize){
                updateSliderInput(session, "sval",
                                  label=paste("Delta ",input$sizev),value=50)
            } else {
                updateSliderInput(session, "sval",
                                  label="NA",value=50)
            }
        }
    })
    output$slid <- renderText(setlab(input$sizev)) 
    
    # Function for generating tooltip text
    cars_tooltip <- function(x) {
        if (is.null(x)) return(NULL)
        if (is.null(x$model)) return(NULL)
        
        paste0(
            "<b>",x$model, "</b><br>",
            "<i>",input$x,"</i>: ",format(x$x),"<br>",
            "<i>",input$y,"</i>: ",format(x$y),"<br>", 
            "<i>",input$sizev,"</i>: ",format(x$size),"<br>"
        )
    }
    
    # Function for generating tooltip text
    res_tooltip <- function(x) {
        if (is.null(x)) return(NULL)
        if (is.null(x$model)) return(NULL)
        
        paste0(
            "<b>",x$model, "</b><br>",
            "<i>",input$y," actual </i>: ",format(x$val),"<br>",
            "<i>",input$y," prediction </i>: ",format(x$pr),"<br>",
            "<i> residual </i>: ", format(x$res),"<br>",
            "<i>",input$sizev,"</i>: ",format(x$size),"<br>"
        )
    }
    
    # create figure with ggvis
    mainplot <- reactive({
        
        # Custom Linear model
        if(input$usesize){
            # include extra variable
            if(input$usecross) {
                # multiple slopes
                modfit <- lm(y~x*col+x*size,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col+size,data=pdata())
            }
        } else {
            if(input$usecross) {
                # multiple slope
                modfit <- lm(y~x*col,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col,data=pdata())
            }
        }
        
        locvis <- pdata %>%
            ggvis(~x,~y) %>%
            layer_points(size=~size,fill=~col,key := ~model,
                         size.hover := 500,fillOpacity := 0.4, fillOpacity.hover := 0.6
            ) %>%
            # use axis titles
            add_axis("x",title=setlab(input$x)) %>%
            add_axis("y",title=setlab(input$y)) %>%
            # set legends
            add_legend(c("fill","stroke"),title=setlab(input$colf),orient='left') %>%
            add_legend("size",title=setlab(input$sizev)) %>%
            # set scales
            scale_numeric("x",domain = setrang(input$x)) %>%
            scale_numeric("y",domain = setrang(input$y)) %>%
            scale_numeric("size",range = c(30,300)) %>%
            # add tooltip
            add_tooltip(cars_tooltip,"hover") %>%
            # set figure size
            set_options(width = 700, height = 350)
        
        # create function for extending fitting to the full range of the plot
        gety_ext <- function(x){
            # compute y(x) folloming the line passing hrough dfp
            dfp$y[1] + (dfp$y[2]-dfp$y[1])/(dfp$x[2]-dfp$x[1])*(x-dfp$x[1])
        }
        getx_ext <- function(y){
            # compute x(y) folloming the line passing hrough dfp
            dfp$x[1] + (dfp$x[2]-dfp$x[1])/(dfp$y[2]-dfp$y[1])*(y-dfp$y[1])
        }
        correct_ext <- function(dfloc){
            # change point outside the axis range
            ymin <- setrang(input$y)[1]
            ymax <- setrang(input$y)[2]
            # recompute x as a function of the range in y
            dfloc$x[dfloc$y<ymin] <- getx_ext(ymin)
            dfloc$x[dfloc$y>ymax] <- getx_ext(ymax)
            # change y accordingly to the correct range.
            dfloc$y[dfloc$y<ymin] <- ymin
            dfloc$y[dfloc$y>ymax] <- ymax
            dfloc
        }
        
        # quick and durty linear model for getting a size input
        sizemod <- lm(size~x+col,data=pdata())
        for(cv in levels(pdata()$col)){
            # create date frame for plotting the fit line 
            # starting form range of x with a given color
            xrange <- range(pdata()$x[pdata()$col==cv])
            dfp <- data.frame(
                x=xrange,
                col =rep(cv,2)
            )
            # use linear model to predict the size variable
            spr <- predict(sizemod,newdata=dfp,interval="confidence",level=0.90)
            # choose value within confidence interval
            dfp$size <- spr[,"fit"] + (input$sval-5)/90.*(spr[,"upr"] - spr[,"lwr"])
            # use linear model to predict y
            dfp$y <- predict(modfit,newdata=dfp)
            # cut line out of the plot frame
            dfp   <- correct_ext(dfp)
            # add layer with new line
            locvis <- locvis %>%
                layer_paths(data=dfp,x=~x,y=~y,stroke=~col,strokeWidth:=4)
          
            # create the fit line ranging the range of the plot
            dfext <- data.frame(
                x = setrang(input$x),
                col =rep(cv,2)
            )
            dfext$y <- sapply(dfext$x,gety_ext)
            # cut line out of the plot frame
            dfext   <- correct_ext(dfext)
            # add layer with new line
            locvis <- locvis %>%
                layer_paths(data=dfext,x=~x,y=~y,stroke=~col,strokeWidth:=2,strokeDash:=6)
        }
        locvis
    })
    
    mainplot %>% bind_shiny("plot1")
    
    # create figure with ggvis
    resplot <- reactive({
        
        # Custom Linear model
        if(input$usesize){
            # include extra variable
            if(input$usecross) {
                # multiple slopes
                modfit <- lm(y~x*col+x*size,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col+size,data=pdata())
            }
        } else {
            if(input$usecross) {
                # multiple slope
                modfit <- lm(y~x*col,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col,data=pdata())
            }  
        }
        
        resdata <- data.frame(
            model = pdata()$model,
            val = pdata()$y,
            pr = predict(modfit),
            res = modfit$residuals,
            size = pdata()$size,
            col  = pdata()$col
        )
        
        resdata %>% ggvis(~pr,~res) %>%
            layer_points(size=~size,fill=~col,key := ~model,
                         size.hover := 500,fillOpacity := 0.4, fillOpacity.hover := 0.6
            ) %>%
            # use axis titles
            add_axis("x",title=paste("Prediction ",setlab(input$y))) %>%
            add_axis("y",title="Residuals") %>%
            # set legends
            add_legend(c("fill","stroke"),title=setlab(input$colf),orient='left') %>%
            add_legend("size",title=setlab(input$sizev)) %>%
            # set scales
            scale_numeric("x",domain = setrang(input$y)) %>%
            scale_numeric("size",range = c(30,300)) %>%
            # add tooltip
            add_tooltip(res_tooltip,"hover") %>%
            # set figure size
            set_options(width = 700, height = 200)
    })
  
    resplot %>% bind_shiny("plot2")
    
    modinfo <- reactive({
        # Custom Linear model
       
        if(input$usesize){
            # include extra variable
            if(input$usecross) {
                # multiple slopes
                modfit <- lm(y~x*col+x*size,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col+size,data=pdata())
            }
        } else {
            if(input$usecross) {
                # multiple slope
                modfit <- lm(y~x*col,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col,data=pdata())
            }
        }
        summary(modinfo)
    })
    
    output$formula0 <- renderText(
        paste("Single slope ignoring",input$sizev,"variable:",
            input$y,"~",input$x,"+",input$colf))
    output$formula1 <- renderText(
        paste("Single slope including",input$sizev," variable:",
            input$y,"~",input$x,"+",input$colf,"+",input$sizev))
    output$formula2 <- renderText(
        paste("Multiple slopes ignoring",input$sizev,"variable:",input$y,"~",
            input$x,"*",input$colf))
    output$formula3 <- renderText(
        paste("Multiple slopes including",input$sizev,"variable:",
            input$y,"~",input$x,"*",input$colf,"+",input$x,"*",input$sizev
        ))
  
    output$curformula <- renderText({
        # Custom Linear model
       
        if(input$usesize){
            # include extra variable
            if(input$usecross) {
                paste("Multiple slopes ignoring",input$sizev,"variable:",input$y,"~",
                      input$x,"*",input$colf)
            } else {
                paste("Single slope including",input$sizev," variable:",
                      input$y,"~",input$x,"+",input$colf,"+",input$sizev)
            }
        } else {
            if(input$usecross) {
                paste("Multiple slopes ignoring",input$sizev,"variable:",input$y,"~",
                      input$x,"*",input$colf)
            } else {
                paste("Single slope ignoring",input$sizev,"variable:",
                      input$y,"~",input$x,"+",input$colf)
            }
        }
    })
    
    output$modcoef <- renderTable({
        # Custom Linear model
        if(input$usesize){
            # include extra variable
            if(input$usecross) {
                # multiple slopes
                modfit <- lm(y~x*col+x*size,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col+size,data=pdata())
            }
        } else {
            if(input$usecross) {
                # multiple slope
                modfit <- lm(y~x*col,data=pdata())
            } else {
                # single slope
                modfit <- lm(y~x+col,data=pdata())
            }
        }
        modcoefs <- summary(modfit)$coef
        # modifiy row names
        patarr  <- c("^x","col","size")
        reparr  <- c(input$x,paste(input$colf,"= "),input$sizev)
        for(i in 1:length(patarr)){
            row.names(modcoefs) <- gsub(patarr[i],reparr[i],row.names(modcoefs))
        }
        modcoefs
        })
    
    
    
    output$allmod <- renderTable({
        # single slope
        strmod0 <- paste("Single slope without",input$sizev) #paste(input$y,"~",input$x,"+",input$colf)
        modfit0 <- lm(y~x+col,data=pdata())
        # single slope extra variable
        strmod1 <- paste("Single slope with",input$sizev)#paste(input$y,"~",input$x,"+",input$colf,"+",input$sizev)
        modfit1 <- lm(y~x+col+size,data=pdata())
        # multiple slope
        strmod2 <- paste("Multiple slopes without",input$sizev)
        modfit2 <- lm(y~x*col,data=pdata())
        # multiple slope extra variable
        strmod3 <- paste("Multiple slopes with",input$sizev) #paste(input$y,"~",input$x,"*",input$colf,"+",input$x,"*",input$sizev)
        modfit3 <- lm(y~x*col+x*size,data=pdata())
        anmod <- anova(modfit0,modfit1,modfit2,modfit3)
        r2sq <- data.frame("R squared"=c(
            summary(modfit0)$r.squared,
            summary(modfit1)$r.squared,
            summary(modfit2)$r.squared,
            summary(modfit3)$r.squared
            
        ))
        row.names(anmod) <- c(strmod0,strmod1,strmod2,strmod3)
        anmod<- (cbind(anmod,r2sq))
        subset(anmod,select=c("Res.Df","RSS","F","Pr(>F)","R.squared"))
        
    })
        
})