class mul_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic [7:0]in1;  //i/p
  rand logic [7:0]in2;

  logic [15:0]out;        //o/p

  //---------------- register mul_sequence_item class with factory --------
  `uvm_object_utils_begin(mul_sequence_item) 
     `uvm_field_int( in1 ,UVM_ALL_ON)
     `uvm_field_int( in2 ,UVM_ALL_ON)
     `uvm_field_int( out ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="mul_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("in1=%h  in2=%h", in1,in2 ));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("out=%h ",out));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), "  ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:mul_sequence_item
