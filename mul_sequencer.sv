class mul_sequencer extends uvm_sequencer#(mul_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(mul_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="mul_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:mul_sequencer

