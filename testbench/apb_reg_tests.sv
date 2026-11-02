class apb_ral_test extends uvm_test;
  `uvm_component_utils(apb_ral_test)
    apb_pkt_env env;
  function new(string name="apb_ral_test",uvm_component parent=null);
        super.new(name,parent);
    endfunction

  virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env=apb_pkt_env::type_id::create("env",this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass

class apb_fwd_test extends apb_ral_test;
    `uvm_component_utils(apb_fwd_test)

    function new(string name = "apb_fwd_test",uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_fwd_seq seq;
        phase.raise_objection(this);
        seq = apb_fwd_seq::type_id::create("seq");
        seq.regmodel = env.regmodel; // Pass RAL block handle to the sequence
        seq.start(env.agt.seqr);  // Start on the APB sequencer
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_port_en_test extends apb_ral_test;
    `uvm_component_utils(apb_port_en_test)

    function new(string name = "apb_port_en_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        port_enable_seq seq = port_enable_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_switch_ctrl_test extends apb_ral_test;
  `uvm_component_utils(apb_switch_ctrl_test)

    function new(string name = "apb_switch_ctrl_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        switch_ctrl_seq seq = switch_ctrl_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_err_en_test extends apb_ral_test;
  `uvm_component_utils(apb_err_en_test)

    function new(string name = "apb_err_en_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        err_enable_seq seq = err_enable_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_irq_en_test extends apb_ral_test;
  `uvm_component_utils(apb_irq_en_test)

    function new(string name = "apb_irq_en_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        irq_enable_seq seq = irq_enable_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass


class apb_gen_ctrl_test extends apb_ral_test;
  `uvm_component_utils(apb_gen_ctrl_test)

    function new(string name = "apb_gen_ctrl_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        gen_ctrl_seq seq = gen_ctrl_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_gen_pkt_test extends apb_ral_test;
  `uvm_component_utils(apb_gen_pkt_test)

    function new(string name = "apb_gen_pkt_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        gen_pkt_cfg_seq seq = gen_pkt_cfg_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_gen_int_test extends apb_ral_test;
  `uvm_component_utils(apb_gen_int_test)

  function new(string name = "apb_gen_int_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        gen_interval_seq seq = gen_interval_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_gen_count_test extends apb_ral_test;
  `uvm_component_utils(apb_gen_count_test)

  function new(string name = "apb_gen_count_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        gen_count_seq seq= gen_count_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_irq_status_test extends apb_ral_test;
  `uvm_component_utils(apb_irq_status_test)

    function new(string name = "apb_irq_status_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        irq_status_seq seq = irq_status_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_irq_force_test extends apb_ral_test;
  `uvm_component_utils(apb_irq_force_test)

    function new(string name = "apb_irq_force_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        irq_force_seq seq = irq_force_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_err_inject_test extends apb_ral_test;
  `uvm_component_utils(apb_err_inject_test)

    function new(string name = "apb_err_inject_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        err_inject_count_seq seq = err_inject_count_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_status_reg_test extends apb_ral_test;
  `uvm_component_utils(apb_status_reg_test)

    function new(string name = "apb_status_reg_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        status_regs_seq seq = status_regs_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_err_info_test extends apb_ral_test;
  `uvm_component_utils(apb_err_info_test)

    function new(string name = "apb_err_info_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        err_info_seq seq = err_info_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_soft_reset_test extends apb_ral_test;
  `uvm_component_utils(apb_soft_reset_test)

    function new(string name = "apb_soft_reset_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        soft_reset_seq seq = soft_reset_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class apb_err_status_test extends apb_ral_test;
  `uvm_component_utils(apb_err_status_test)

    function new(string name = "apb_err_status_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        err_status_seq seq = err_status_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class pkt_gen_test extends apb_ral_test;
  `uvm_component_utils(pkt_gen_test)

    function new(string name = "pkt_gen_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        pkt_gen_seq seq = pkt_gen_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.regmodel = env.regmodel;
        seq.start(env.agt.seqr);
        #20ns;
        phase.drop_objection(this);
    endtask
endclass

class back_door_test extends apb_ral_test;
  `uvm_component_utils(back_door_test)
  function new(string name = "back_door_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  virtual task run_phase(uvm_phase phase);
    back_door_seq seq = back_door_seq::type_id::create("seq");
    phase.raise_objection(this);
    seq.regmodel = env.regmodel;
    seq.start(env.agt.seqr);
    #20ns;
    phase.drop_objection(this);
  endtask
endclass

