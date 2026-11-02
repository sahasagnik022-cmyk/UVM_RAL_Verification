class master_reg_test extends apb_ral_test;
  `uvm_component_utils(master_reg_test)

  function new(string name = "master_reg_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    master_reg_seq m_seq;
    m_seq = master_reg_seq::type_id::create("m_seq");
    m_seq.regmodel = env.regmodel;
    phase.raise_objection(this);
    m_seq.start(env.agt.seqr); 
    phase.drop_objection(this);
  endtask
endclass
