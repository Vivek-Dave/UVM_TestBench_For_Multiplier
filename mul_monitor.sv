class mul_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(mul_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="mul_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  mul_sequence_item  txn;
  //----------------------------------------------------------------------------
  bit flag,flag1;
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(mul_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
    txn=mul_sequence_item::type_id::create("txn",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    forever
    begin
      @(posedge vif.clk);
      txn.in1 = vif.in1;
      txn.in2 = vif.in2;
      txn.out = vif.out;
      flag=$isunknown(txn.in1);
      flag=$isunknown(txn.out);
      `uvm_info(get_type_name(),txn.convert2string(),UVM_MEDIUM)      
	  ap_mon.write(txn);
    end
  endtask
  //----------------------------------------------------------------------------

endclass:mul_monitor
