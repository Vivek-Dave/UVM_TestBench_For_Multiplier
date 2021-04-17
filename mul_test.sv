
class mul_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(mul_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="mul_test",uvm_component parent);
	    super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    mul_env env_h;
    int file_h;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = mul_env::type_id::create("env_h",this);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      set_report_verbosity_level_hier(UVM_LOW);
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        mul_sequence seq1,seq2;
        in1_0_seq seq3;
        mul_sequence_short seq4;
      	mul_sequence_high seq5;
	      phase.raise_objection(this);
            
      		seq1= mul_sequence::type_id::create("seq1");
            seq2= mul_sequence::type_id::create("seq2");
            seq3= in1_0_seq::type_id::create("seq3");
      		seq4=mul_sequence_short::type_id::create("seq4");
      		seq5=mul_sequence_high::type_id::create("seq5");
      		
      		seq1.loop_count=100;
      		seq2.loop_count=100;
      		seq4.loop_count=200;
      		seq5.loop_count=200;
            seq1.start(env_h.agent_h.sequencer_h);
            seq2.start(env_h.agent_h.sequencer_h);
            seq3.start(env_h.agent_h.sequencer_h);
            seq4.start(env_h.agent_h.sequencer_h);
      		seq5.start(env_h.agent_h.sequencer_h);
            #10;
	      phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:mul_test