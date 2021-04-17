
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
    
 import uvm_pkg::*;
 `include "mul_sequence_item.sv"        // transaction class
 `include "mul_sequence.sv"             // sequence class
 `include "mul_sequencer.sv"            // sequencer class
 `include "mul_driver.sv"               // driver class
 `include "mul_monitor.sv"
 `include "mul_agent.sv"                // agent class  
 `include "mul_coverage.sv"             // coverage class
 `include "mul_scoreboard.sv"
 `include "mul_env.sv"                  // environment class
 `include "mul_test.sv"                 // test1

endpackage
`endif 


