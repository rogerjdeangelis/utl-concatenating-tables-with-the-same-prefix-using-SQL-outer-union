Concatenating tables with the same prefix using SQL outer union                                               
                                                                                                              
                                                                                                              
https://tinyurl.com/y3bx9xus                                                                                  
https://github.com/rogerjdeangelis/utl-concatenating-tables-with-the-same-prefix-using-SQL-outer-union        
                                                                                                              
SAS Forun                                                                                                     
https://tinyurl.com/y3gvzj7j                                                                                  
https://communities.sas.com/t5/SAS-Programming/Multiple-proc-sql-tables-with-same-prefix/m-p/555456           
                                                                                                              
macros                                                                                                        
https://tinyurl.com/y9nfugth                                                                                  
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories                    
                                                                                                              
                                                                                                              
*_                   _                                                                                        
(_)_ __  _ __  _   _| |_                                                                                      
| | '_ \| '_ \| | | | __|                                                                                     
| | | | | |_) | |_| | |_                                                                                      
|_|_| |_| .__/ \__,_|\__|                                                                                     
        |_|                                                                                                   
;                                                                                                             
                                                                                                              
* create some data;                                                                                           
                                                                                                              
data have_a have_b have_c;                                                                                    
    set sashelp.class(obs=3);                                                                                 
run;quit;                                                                                                     
                                                                                                              
                                                                                                              
Up to 40 obs from HAVE_A total obs=3                                                                          
                                                                                                              
Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                              
                                                                                                              
 1     Alfred      M      14     69.0      112.5                                                              
 2     Alice       F      13     56.5       84.0                                                              
 3     Barbara     F      13     65.3       98.0                                                              
                                                                                                              
 Up to 40 obs from HAVE_B total obs=3                                                                         
                                                                                                              
Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                              
                                                                                                              
 1     Alfred      M      14     69.0      112.5                                                              
 2     Alice       F      13     56.5       84.0                                                              
 3     Barbara     F      13     65.3       98.0                                                              
                                                                                                              
 Up to 40 obs from HAVE_C total obs=3                                                                         
                                                                                                              
Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                              
                                                                                                              
 1     Alfred      M      14     69.0      112.5                                                              
 2     Alice       F      13     56.5       84.0                                                              
 3     Barbara     F      13     65.3       98.0                                                              
                                                                                                              
*            _               _                                                                                
  ___  _   _| |_ _ __  _   _| |_                                                                              
 / _ \| | | | __| '_ \| | | | __|                                                                             
| (_) | |_| | |_| |_) | |_| | |_                                                                              
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                             
                |_|                                                                                           
;                                                                                                             
                                                                                                              
Up to 40 obs from WANT total obs=9                                                                            
                                                                                                              
Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                              
                                                                                                              
 1     Alfred      M      14     69.0      112.5                                                              
 2     Alice       F      13     56.5       84.0                                                              
 3     Barbara     F      13     65.3       98.0                                                              
 4     Alfred      M      14     69.0      112.5                                                              
 5     Alice       F      13     56.5       84.0                                                              
 6     Barbara     F      13     65.3       98.0                                                              
 7     Alfred      M      14     69.0      112.5                                                              
 8     Alice       F      13     56.5       84.0                                                              
 9     Barbara     F      13     65.3       98.0                                                              
                                                                                                              
*          _       _   _                                                                                      
 ___  ___ | |_   _| |_(_) ___  _ __                                                                           
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                          
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                         
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                         
                                                                                                              
;                                                                                                             
                                                                                                              
proc sql;                                                                                                     
  select                                                                                                      
      substr(memname,6)                                                                                       
  into                                                                                                        
      :sfxs1-                                                                                                 
  from                                                                                                        
      sashelp.vtable                                                                                          
  where                                                                                                       
      libname="WORK" and                                                                                      
      memname eqt "HAVE_"                                                                                     
 ;                                                                                                            
                                                                                                              
 %let sfxsn=&sqlobs;                                                                                          
                                                                                                              
 create                                                                                                       
     table want as                                                                                            
 %do_over(sfxs, phrase=                                                                                       
     select                                                                                                   
            *                                                                                                 
     from                                                                                                     
            have_?                                                                                            
     , between= outer union corr                                                                              
 )                                                                                                            
;quit;                                                                                                        
                                                                                                              
