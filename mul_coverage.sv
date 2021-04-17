
class mul_coverage extends uvm_subscriber #(mul_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(mul_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="mul_coverage",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  mul_sequence_item txn;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup dut_cov;
    option.per_instance= 1;
    option.comment     = "dut_cov";
    option.name        = "dut_cov";
    option.auto_bin_max= 256;

    IN1:coverpoint txn.in1;
    IN2:coverpoint txn.in2;
  
  endgroup:dut_cov;

  //----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  function void write(mul_sequence_item t);
    txn=t;
    dut_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    cov=dut_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:mul_coverage
