
`include "interface.sv"
`include "tb_pkg.sv"
module top;
  import uvm_pkg::*;
  import tb_pkg::*;
  
  bit clk; 

  //----------------------------------------------------------------------------
  intf i_intf(clk);
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  mul DUT(.in1(i_intf.in1),
          .in2(i_intf.in2),
          .clk(i_intf.clk),
          .out(i_intf.out)
          );
  //----------------------------------------------------------------------------               
  always #5 clk=~clk;

  initial begin
    clk<=0;
  end
  
  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    run_test("mul_test");
  end
  //----------------------------------------------------------------------------
endmodule


UVM_INFO /home/runner/mul_coverage.sv(50) @ 6305: uvm_test_top.env_h.coverage_h [mul_coverage] Coverage is 85.937500
UVM_INFO /home/runner/mul_scoreboard.sv(109) @ 6305: uvm_test_top.env_h.scoreboard_h [PASSED] *** TEST PASSED - 629 vectors ran, 629 vectors passed***