
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class mul_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(mul_scoreboard)
  
  uvm_analysis_imp_drv #(mul_sequence_item, mul_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(mul_sequence_item, mul_scoreboard) aport_mon;
  
  uvm_tlm_fifo #(mul_sequence_item) expfifo;
  uvm_tlm_fifo #(mul_sequence_item) outfifo;
  
  int q1[$];
  int q2[$];
  int i;
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic [15:0]t_out;
  
  function new(string name="mul_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	aport_drv = new("aport_drv", this);
	aport_mon = new("aport_mon", this);
	expfifo= new("expfifo",this);
	outfifo= new("outfifo",this);
  endfunction


  function void write_drv(mul_sequence_item tr);
    `uvm_info("write_drv STIM", tr.convert2string(), UVM_MEDIUM)
    //write scoreboard code here
    t_out  = tr.in1*tr.in2;
    tr.out = t_out;
    q1.push_back(t_out);
    void'(expfifo.try_put(tr));
  endfunction

  function void write_mon(mul_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    q2.push_back(tr.out);
    void'(outfifo.try_put(tr));
  endfunction
  
  task run_phase(uvm_phase phase);
	mul_sequence_item exp_tr, out_tr;
    i=0;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
  //    	$display("i = %0d",i);
  //    	$display("q1 = %h",q1[i]);
  //    	$display("q2 = %h",q2[i]);
      
      	i++;
    /*  if (out_tr.out===exp_tr.out) begin
            PASS();
           `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
	  end
      
      	else begin
	   ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	end */
    end  
  endtask
  
  
  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    $display("INSIDE CHECK PHASE ");
    foreach(q1[i])
      begin
        if(q1[i]==q2[i+2]) begin
          	//$display("q1=%h q2=%h : i=%d",q1[i],q2[i+2],i);
          	PASS();
          `uvm_info ("PASS ",$sformatf("q1=%h q2=%h : PASS",q1[i],q2[i+2]) , UVM_LOW)
        end
      	else begin
        	//$display("FAIL");
         	ERROR();
          `uvm_warning("ERROR",$sformatf("q1=%h q2=%h : ERROR",q1[i],q2[i+2]))
        end
        if(i==(q1.size()-2)) begin
          $display("BREAKING LOOP");
          break;
        end
      end
  endfunction
  
  
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

endclass

