
/***************************************************
** class name  : mul_sequence
** description : send random data to DUT
***************************************************/
class mul_sequence extends uvm_sequence#(mul_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(mul_sequence)            
  //----------------------------------------------------------------------------

  mul_sequence_item txn;
  int loop_count=30;

  //----------------------------------------------------------------------------
  function new(string name="mul_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    for(int i=0;i<loop_count;i++) begin
      txn=mul_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize();
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:mul_sequence



/***************************************************
** class name  : mul_sequence_short
** description : vlaue of in1 and in2 is < 16
***************************************************/
class mul_sequence_short extends uvm_sequence#(mul_sequence_short);
  //----------------------------------------------------------------------------
  `uvm_object_utils(mul_sequence_short)            
  //----------------------------------------------------------------------------

  mul_sequence_item txn;
  int loop_count=30;

  //----------------------------------------------------------------------------
  function new(string name="mul_sequence_short");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    for(int i=0;i<loop_count;i++) begin
      txn=mul_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.in1<16;txn.in2<16;};
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass


/***************************************************
** class name  : mul_sequence_high
** description : vlaue of in1 and in2 is > 128
***************************************************/
class mul_sequence_high extends uvm_sequence#(mul_sequence_high);
  //----------------------------------------------------------------------------
  `uvm_object_utils(mul_sequence_high)            
  //----------------------------------------------------------------------------

  mul_sequence_item txn;
  int loop_count=30;

  //----------------------------------------------------------------------------
  function new(string name="mul_sequence_high");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    for(int i=0;i<loop_count;i++) begin
      txn=mul_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.in1>128;txn.in2>128;};
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass







/***************************************************
** class name  : in1_0_seq
** description : send data to DUT in which in1==0
***************************************************/
class in1_0_seq extends mul_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(in1_0_seq)      
  //----------------------------------------------------------------------------
  
  mul_sequence_item txn;
  int loop_count=30;
  
  //----------------------------------------------------------------------------
  function new(string name="in1_0_seq");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i=0;i<loop_count;i++) begin
      txn=mul_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.in1==0;};
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass