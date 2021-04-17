
class mul_driver extends uvm_driver #(mul_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(mul_driver)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="mul_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  //---------------------------------------------------------------------------- 

  uvm_analysis_port #(mul_sequence_item) drv2sb;
  bit flag;
  
  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal("driver","unable to get interface");
    end
    drv2sb=new("drv2sb",this);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    mul_sequence_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      @(posedge vif.clk);
      vif.in1 <= txn.in1;
      vif.in2 <= txn.in2;
      flag=$isunknown(txn.in1);
      if(flag==1) begin
        $display("   UNKNOW VALUE DETECTED   ");
        seq_item_port.item_done();
      end
      else begin
       	drv2sb.write(txn);
      	`uvm_info(get_type_name(),txn.convert2string(),UVM_MEDIUM)      
      	seq_item_port.item_done();
      end
    end
  endtask
  //----------------------------------------------------------------------------
  
endclass:mul_driver

