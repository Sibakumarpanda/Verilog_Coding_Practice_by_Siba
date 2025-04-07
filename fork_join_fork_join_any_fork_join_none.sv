//Example-1
module fork_join;  
  initial begin     
    fork      
        $display($time,"\tProcess-1 Started");     
        $display($time,"\tProcess-2 Started");       
    join    
    $display($time,"\tOutside Fork-Join");   
  end  
endmodule
//Output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr  7 08:38 2025
                   0	Process-1 Started
                   0	Process-2 Started
                   0	Outside Fork-Join
           V C S   S i m u l a t i o n   R e p o r t
//Example-2
module fork_join_any;  
  initial begin     
    fork      
        $display($time,"\tProcess-1 Started");     
        $display($time,"\tProcess-2 Started");       
    join_any    
    $display($time,"\tOutside Fork-Join_any");  
  end  
endmodule 
//Output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr  7 08:39 2025
                   0	Process-1 Started
                   0	Outside Fork-Join_any
                   0	Process-2 Started
           V C S   S i m u l a t i o n   R e p o r t 
//Example-3
module fork_join_none;  
  initial begin     
    fork      
        $display($time,"\tProcess-1 Started");     
        $display($time,"\tProcess-2 Started");       
    join_none    
    $display($time,"\tOutside Fork-Join_none");   
  end  
endmodule 
//Output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr  7 08:43 2025
                   0	Outside Fork-Join_none
                   0	Process-1 Started
                   0	Process-2 Started
           V C S   S i m u l a t i o n   R e p o r t 
//Example-4
module fork_join_delay;  
  initial begin     
    fork      
     #3;   
     $display($time,"\tProcess-1 Started");           
     #5 ;        
     $display($time,"\tProcess-2 Started");       
    join    
     #1 ;  
    $display($time,"\tOutside Fork-Join_delay");   
  end  
endmodule 
//Output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr  7 08:50 2025
                   0	Process-1 Started
                   0	Process-2 Started
                   6	Outside Fork-Join_delay
           V C S   S i m u l a t i o n   R e p o r t 
/* Explanation of Output
At time 0: Both "Process-1 Started" and "Process-2 Started" are printed because the delays are not affecting the timing of the $display statements within the fork block.
At time 6: "Outside Fork-Join_delay" is printed after the join and the additional delay of #1 
The delay #3; is placed before the $display statement, but it is not associated with any specific process. In SystemVerilog, a delay statement without a preceding event or statement does not affect the timing of subsequent statements within a fork block.
  Therefore, $display($time, "\tProcess-1 Started"); executes immediately at time 0 */

//Example-5
module fork_join_delay2;  
  initial begin     
    fork      
      begin
        #3;   
        $display($time,"\tProcess-1 Started");      
      end
      
      begin
        #5;  
        $display($time,"\tProcess-2 Started"); 
      end
      
    join    
    #1 ;  
    $display($time,"\tOutside Fork-Join_delay");   
  end  
endmodule
//Output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr  7 08:59 2025
                   3	Process-1 Started
                   5	Process-2 Started
                   6	Outside Fork-Join_delay
           V C S   S i m u l a t i o n   R e p o r t 
//Example-6
//we need to run 5 processes  inside any block like fork-join , fork_join_any, or fork_join_none such that simulation should exit after executing any 2 processes. how to write system verilog code for this

module fork_join_any_example;

  initial begin
    int comp_proc = 0;

    fork
      begin
        #3;
        $display($time, "\tProcess-1 Completed");
        comp_proc++;
      end

      begin
        #5;
        $display($time, "\tProcess-2 Completed");
        comp_proc++;
      end

      begin
        #7;
        $display($time, "\tProcess-3 Completed");
        comp_proc++;
      end

      begin
        #9;
        $display($time, "\tProcess-4 Completed");
        comp_proc++;
      end

      begin
        #11;
        $display($time, "\tProcess-5 Completed");
        comp_proc++;
      end
    join_any

    // Wait for any 2 processes to complete
    wait(comp_proc >= 2);

    $display($time, "\tSimulation exits after any 2 processes complete");
    $finish;
  end

endmodule
//Output
Compiler version U-2023.03-SP2_Full64; Runtime version U-2023.03-SP2_Full64;  Apr  7 09:20 2025
                   3	Process-1 Completed
                   5	Process-2 Completed
                   5	Simulation exits after any 2 processes complete
