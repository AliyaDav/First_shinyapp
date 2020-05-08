---
title: "CEO"
author: "Aliya Davletshina"
date: "5/8/2020"
output: 
  html_document:
    keep_md: true
---






```
>  [1] Health Care Equipment                     
>  [2] Semiconductors                            
>  [3] Application Software                      
>  [4] Specialty Chemicals                       
>  [5] Pharmaceuticals                           
>  [6] Restaurants                               
>  [7] IT Consulting & Other Services            
>  [8] Internet & Direct Marketing Retail        
>  [9] Construction Machinery & Heavy Trucks     
> [10] Automobile Manufacturers                  
> [11] Food Retail                               
> [12] Hotels, Resorts & Cruise Lines            
> [13] Technology Hardware, Storage & Peripherals
> [14] Personal Products                         
> [15] Auto Parts & Equipment                    
> [16] Systems Software                          
> [17] Internet Software & Services              
> [18] Semiconductor Equipment                   
> [19] Biotechnology                             
> [20] Health Care Supplies                      
> [21] Communications Equipment                  
> [22] Interactive Media & Services              
> [23] Data Processing & Outsourced Services     
> [24] Diversified Support Services              
> [25] Managed Health Care                       
> [26] Health Care Technology                    
> [27] Financial Exchanges & Data                
> [28] Internet Services & Infrastructure        
> [29] Aerospace & Defense                       
> [30]                                           
> [31] Research & Consulting Services            
> [32] Electronic Manufacturing Services         
> [33] Advertising                               
> 33 Levels:  Advertising Aerospace & Defense ... Technology Hardware, Storage & Peripherals
```

```
> [1] 2480
```

```
> [1] 33
```

```
>  [1] "EXEC_FULLNAME" "CO_PER_ROL"    "CONAME"        "CEOANN"       
>  [5] "SALARY"        "TOTAL_CURR"    "GVKEY"         "YEAR"         
>  [9] "BECAMECEO"     "JOINED_CO"     "LEFTCO"        "GENDER"       
> [13] "PAGE"          "CITY"          "STATE"         "INDDESC"      
> [17] "SIC"
```


```
> # A tibble: 2 x 2
> # Groups:   GENDER [2]
>   GENDER     n
>   <fct>  <int>
> 1 FEMALE   172
> 2 MALE    1237
```

<img src="README_figs/README-unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />
  
<img src="README_figs/README-unnamed-chunk-5-1.png" width="100%" style="display: block; margin: auto;" />


```
> # A tibble: 9,202 x 2
> # Groups:   GENDER [2]
>     PAGE GENDER
>    <int> <fct> 
>  1    18 MALE  
>  2    31 MALE  
>  3    31 MALE  
>  4    31 MALE  
>  5    31 MALE  
>  6    31 MALE  
>  7    34 MALE  
>  8    34 MALE  
>  9    34 MALE  
> 10    34 MALE  
> # … with 9,192 more rows
```

<img src="README_figs/README-unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" />

```
> [1] 57
```


```
> # A tibble: 9,202 x 3
> # Groups:   GENDER [2]
>    GENDER SALARY avg_salary
>    <fct>   <dbl>      <dbl>
>  1 MALE    1893.       473.
>  2 MALE     742.       473.
>  3 MALE     942.       473.
>  4 FEMALE   823.       469.
>  5 MALE     815.       473.
>  6 MALE    1900        473.
>  7 MALE     825        473.
>  8 MALE     947.       473.
>  9 FEMALE   828.       469.
> 10 MALE     634.       473.
> # … with 9,192 more rows
```

```
> [1]  0 24
```

<img src="README_figs/README-unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" />

<img src="README_figs/README-unnamed-chunk-8-1.png" width="100%" style="display: block; margin: auto;" />
