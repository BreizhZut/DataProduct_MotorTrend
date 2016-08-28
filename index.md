# Motor Trend Data set
Dylan Tweed  

## Choosing the variable (Sidebar)

Variables selected into `pdata` are chosen through a menu for each entry except model.

* Among the continuous variables for 
    * `x` (abscissa), `y` (ordinate), `size` (bubble size)
* Among the factor variables for 
    * `col` (bubble color)
    

```r
data(mtcars)
# Copy selected data into a new dataframe
pdata <- data.frame(
            model=as.character(row.names(mtcars)),
            x = mtcars$wt, y = mtcars$mpg,
            col = as.factor(mtcars$cyl),size = mtcars$disp
        )
```

## Choosing the Linear model (Sidebar)

Model options `usesize` and `usecross` are selected by the user


```r
usesize <- F
usecross <- F
# Custom Linear model
if(usesize){ # include extra variable
    if(usecross) { # multiple slopes
        modfit <- lm(y~x*col+x*size,data=pdata)
    } else { # single slope
        modfit <- lm(y~x+col+size,data=pdata)
    }
} else { # does not include extra variable
    if(usecross) { # multiple slopes
        modfit <- lm(y~x*col,data=pdata)
    } else { # single slope
        modfit <- lm(y~x+col,data=pdata)
    }}
```

## Visualization (Visualization Tab)

<!--html_preserve--><div id="plot_id716904780-container" class="ggvis-output-container">
<div id="plot_id716904780" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id716904780_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id716904780" data-renderer="svg">SVG</a>
 | 
<a id="plot_id716904780_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id716904780" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id716904780_download" class="ggvis-download" data-plot-id="plot_id716904780">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id716904780_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number",
          "size": "number"
        }
      },
      "values": "\"x\",\"y\",\"size\",\"col\",\"model\"\n2.62,21,160,\"6\",\"Mazda RX4\"\n2.875,21,160,\"6\",\"Mazda RX4 Wag\"\n2.32,22.8,108,\"4\",\"Datsun 710\"\n3.215,21.4,258,\"6\",\"Hornet 4 Drive\"\n3.44,18.7,360,\"8\",\"Hornet Sportabout\"\n3.46,18.1,225,\"6\",\"Valiant\"\n3.57,14.3,360,\"8\",\"Duster 360\"\n3.19,24.4,146.7,\"4\",\"Merc 240D\"\n3.15,22.8,140.8,\"4\",\"Merc 230\"\n3.44,19.2,167.6,\"6\",\"Merc 280\"\n3.44,17.8,167.6,\"6\",\"Merc 280C\"\n4.07,16.4,275.8,\"8\",\"Merc 450SE\"\n3.73,17.3,275.8,\"8\",\"Merc 450SL\"\n3.78,15.2,275.8,\"8\",\"Merc 450SLC\"\n5.25,10.4,472,\"8\",\"Cadillac Fleetwood\"\n5.424,10.4,460,\"8\",\"Lincoln Continental\"\n5.345,14.7,440,\"8\",\"Chrysler Imperial\"\n2.2,32.4,78.7,\"4\",\"Fiat 128\"\n1.615,30.4,75.7,\"4\",\"Honda Civic\"\n1.835,33.9,71.1,\"4\",\"Toyota Corolla\"\n2.465,21.5,120.1,\"4\",\"Toyota Corona\"\n3.52,15.5,318,\"8\",\"Dodge Challenger\"\n3.435,15.2,304,\"8\",\"AMC Javelin\"\n3.84,13.3,350,\"8\",\"Camaro Z28\"\n3.845,19.2,400,\"8\",\"Pontiac Firebird\"\n1.935,27.3,79,\"4\",\"Fiat X1-9\"\n2.14,26,120.3,\"4\",\"Porsche 914-2\"\n1.513,30.4,95.1,\"4\",\"Lotus Europa\"\n3.17,15.8,351,\"8\",\"Ford Pantera L\"\n2.77,19.7,145,\"6\",\"Ferrari Dino\"\n3.57,15,301,\"8\",\"Maserati Bora\"\n2.78,21.4,121,\"4\",\"Volvo 142E\""
    },
    {
      "name": "dfext2",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\",\"col\"\n1,30.7851807529396,\"4\"\n6,14.7571144719753,\"4\""
    },
    {
      "name": "dfext4",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\",\"col\"\n1,26.5295983509683,\"6\"\n6,10.501532070004,\"6\""
    },
    {
      "name": "dfext6",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\",\"col\"\n1,24.7143210724487,\"8\"\n5.59017351641606,10,\"8\""
    },
    {
      "name": "dfp1",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\",\"col\"\n1.513,29.1407011525127,\"4\"\n3.19,23.7648877218772,\"4\""
    },
    {
      "name": "dfp3",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\",\"col\"\n2.62,21.3365048759359,\"6\"\n3.46,18.6437897407339,\"6\""
    },
    {
      "name": "dfp5",
      "format": {
        "type": "csv",
        "parse": {
          "x": "number",
          "y": "number"
        }
      },
      "values": "\"x\",\"y\",\"col\"\n3.17,17.7581403065102,\"8\"\n5.424,10.5326880270515,\"8\""
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
    },
    {
      "name": "scale/size",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n71.1\n472"
    },
    {
      "name": "scale/stroke",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0.75\n6.25"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n8.75\n36.25"
    }
  ],
  "scales": [
    {
      "name": "fill",
      "type": "ordinal",
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "category10"
    },
    {
      "domain": {
        "data": "scale/size",
        "field": "data.domain"
      },
      "name": "size",
      "range": [30, 300],
      "zero": false,
      "nice": false,
      "clamp": false
    },
    {
      "name": "stroke",
      "type": "ordinal",
      "domain": {
        "data": "scale/stroke",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "category10"
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "size": {
            "scale": "size",
            "field": "data.size"
          },
          "fill": {
            "scale": "fill",
            "field": "data.col"
          },
          "fillOpacity": {
            "value": 0.4
          }
        },
        "hover": {
          "size": {
            "value": 500
          },
          "fillOpacity": {
            "value": 0.6
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      },
      "key": "data.model"
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.col"
          },
          "strokeWidth": {
            "value": 4
          }
        },
        "ggvis": {
          "data": {
            "value": "dfp1"
          }
        }
      },
      "from": {
        "data": "dfp1"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.col"
          },
          "strokeWidth": {
            "value": 2
          },
          "strokeDash": {
            "value": 6
          }
        },
        "ggvis": {
          "data": {
            "value": "dfext2"
          }
        }
      },
      "from": {
        "data": "dfext2"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.col"
          },
          "strokeWidth": {
            "value": 4
          }
        },
        "ggvis": {
          "data": {
            "value": "dfp3"
          }
        }
      },
      "from": {
        "data": "dfp3"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.col"
          },
          "strokeWidth": {
            "value": 2
          },
          "strokeDash": {
            "value": 6
          }
        },
        "ggvis": {
          "data": {
            "value": "dfext4"
          }
        }
      },
      "from": {
        "data": "dfext4"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.col"
          },
          "strokeWidth": {
            "value": 4
          }
        },
        "ggvis": {
          "data": {
            "value": "dfp5"
          }
        }
      },
      "from": {
        "data": "dfp5"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.x"
          },
          "y": {
            "scale": "y",
            "field": "data.y"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.col"
          },
          "strokeWidth": {
            "value": 2
          },
          "strokeDash": {
            "value": 6
          }
        },
        "ggvis": {
          "data": {
            "value": "dfext6"
          }
        }
      },
      "from": {
        "data": "dfext6"
      }
    }
  ],
  "legends": [
    {
      "orient": "left",
      "title": "Nb of cylinders",
      "fill": "fill",
      "stroke": "stroke"
    },
    {
      "orient": "right",
      "title": "Displacement [cu.in]",
      "size": "size"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "title": "Weight [1000 lbs]",
      "layer": "back",
      "grid": true
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "title": "Miles/(US) gallon",
      "layer": "back",
      "grid": true
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 288
  },
  "handlers": null
};
ggvis.getPlot("plot_id716904780").parseSpec(plot_id716904780_spec);
</script><!--/html_preserve-->

<!--html_preserve--><div id="plot_id748943419-container" class="ggvis-output-container">
<div id="plot_id748943419" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id748943419_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id748943419" data-renderer="svg">SVG</a>
 | 
<a id="plot_id748943419_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id748943419" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id748943419_download" class="ggvis-download" data-plot-id="plot_id748943419">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id748943419_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "pr": "number",
          "res": "number",
          "size": "number"
        }
      },
      "values": "\"pr\",\"res\",\"size\",\"col\",\"model\"\n21.3365048759359,-0.336504875935928,160,\"6\",\"Mazda RX4\"\n20.5190734956067,0.480926504393306,160,\"6\",\"Mazda RX4 Wag\"\n26.553771254765,-3.75377125476502,108,\"4\",\"Datsun 710\"\n19.4291649885011,1.97083501149888,258,\"6\",\"Hornet 4 Drive\"\n16.8926247273381,1.80737527266186,360,\"8\",\"Hornet Sportabout\"\n18.6437897407339,-0.543789740733866,225,\"6\",\"Valiant\"\n16.4758950040331,-2.17589500403307,360,\"8\",\"Duster 360\"\n23.7648877218772,0.635112278122762,146.7,\"4\",\"Merc 240D\"\n23.893112252125,-1.09311225212495,140.8,\"4\",\"Merc 230\"\n18.7079020058577,0.492097994142275,167.6,\"6\",\"Merc 280\"\n18.7079020058577,-0.907902005857724,167.6,\"6\",\"Merc 280C\"\n14.8730883759366,1.52691162406337,275.8,\"8\",\"Merc 450SE\"\n15.9629968830422,1.33700311695779,275.8,\"8\",\"Merc 450SL\"\n15.8027162202326,-0.602716220232565,275.8,\"8\",\"Merc 450SLC\"\n11.0904647336291,-0.690464733629055,472,\"8\",\"Cadillac Fleetwood\"\n10.5326880270515,-0.132688027051498,460,\"8\",\"Lincoln Continental\"\n10.7859314742907,3.91406852570926,440,\"8\",\"Chrysler Imperial\"\n26.9384448455082,5.46155515449183,78.7,\"4\",\"Fiat 128\"\n28.813728600381,1.58627139961901,75.7,\"4\",\"Honda Civic\"\n28.1084936840186,5.79150631598143,71.1,\"4\",\"Toyota Corolla\"\n26.0889573326171,-4.58895733261706,120.1,\"4\",\"Toyota Corona\"\n16.6361756668427,-1.13617566684271,318,\"8\",\"Dodge Challenger\"\n16.9086527936191,-1.7086527936191,304,\"8\",\"AMC Javelin\"\n15.610379424861,-2.31037942486099,350,\"8\",\"Camaro Z28\"\n15.59435135858,3.60564864141997,400,\"8\",\"Pontiac Firebird\"\n27.7879323583993,-0.487932358399277,79,\"4\",\"Fiat X1-9\"\n27.1307816408797,-1.13078164087974,120.3,\"4\",\"Porsche 914-2\"\n29.1407011525127,1.25929884748733,95.1,\"4\",\"Lotus Europa\"\n17.7581403065102,-1.95814030651021,351,\"8\",\"Ford Pantera L\"\n20.8556628875069,-1.15566288750694,145,\"6\",\"Ferrari Dino\"\n16.4758950040331,-1.47589500403307,301,\"8\",\"Maserati Bora\"\n25.0791891569163,-3.67918915691631,121,\"4\",\"Volvo 142E\""
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
    },
    {
      "name": "scale/size",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n71.1\n472"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n8.75\n36.25"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-5.10798051504699\n6.31052949841136"
    }
  ],
  "scales": [
    {
      "name": "fill",
      "type": "ordinal",
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "category10"
    },
    {
      "domain": {
        "data": "scale/size",
        "field": "data.domain"
      },
      "name": "size",
      "range": [30, 300],
      "zero": false,
      "nice": false,
      "clamp": false
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.pr"
          },
          "y": {
            "scale": "y",
            "field": "data.res"
          },
          "size": {
            "scale": "size",
            "field": "data.size"
          },
          "fill": {
            "scale": "fill",
            "field": "data.col"
          },
          "fillOpacity": {
            "value": 0.4
          }
        },
        "hover": {
          "size": {
            "value": 500
          },
          "fillOpacity": {
            "value": 0.6
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      },
      "key": "data.model"
    }
  ],
  "legends": [
    {
      "orient": "left",
      "title": "Nb of cylinders",
      "fill": "fill",
      "4": null
    },
    {
      "orient": "right",
      "title": "Displacement [cu.in]",
      "size": "size"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "title": "Prediction  Miles/(US) gallon",
      "layer": "back",
      "grid": true
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "title": "Residuals",
      "layer": "back",
      "grid": true
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 672,
    "height": 192
  },
  "handlers": null
};
ggvis.getPlot("plot_id748943419").parseSpec(plot_id748943419_spec);
</script><!--/html_preserve-->


## Model properties (Modelization Tab)

Current model coefficients


```
##                      Estimate Std. Error   t value     Pr(>|t|)
## (Intercept)         33.990794  1.8877934 18.005569 6.257246e-17
## Weight              -3.205613  0.7538957 -4.252065 2.130435e-04
## Nb of Cylinders = 6 -4.255582  1.3860728 -3.070244 4.717834e-03
## Nb of Cylinders = 8 -6.070860  1.6522878 -3.674214 9.991893e-04
```

Comparison to other models


```
##                    Res.Df      RSS          F    Pr(>F) R.squared
## mpg~wt+col             28 183.0586         NA        NA 0.8374325
## mpg~wt+col+disp        27 182.9490 0.01700457 0.8973356 0.8375299
## mpg~wt*col             26 155.8888 4.19686441 0.0515866 0.8615610
## mpg~wt*col+wt*size     24 154.7453 0.08867633 0.9154402 0.8625766
```
