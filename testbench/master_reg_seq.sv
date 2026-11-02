
class master_reg_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(master_reg_seq)

  apb_pkt_switch_reg_block regmodel;

  apb_fwd_seq seq_fwd;
  port_enable_seq seq_port_en;
  switch_ctrl_seq seq_switch_ctrl;
  err_enable_seq seq_err_en;
  irq_enable_seq seq_irq_en;
  gen_ctrl_seq seq_gen_ctrl;
  status_regs_seq seq_status_regs;
  gen_pkt_cfg_seq seq_gen_pkt_cfg;
  gen_interval_seq seq_gen_inv;
  gen_count_seq seq_gen_count;
  irq_status_seq seq_irq_stat;
  irq_force_seq seq_irq_force;
  err_status_seq seq_err_stat;
  err_inject_count_seq seq_err_inj_cnt;
  err_info_seq seq_err_info;
  soft_reset_seq seq_soft_rst;
  pkt_gen_seq seq_pkt_gen;

  function new(string name = "master_reg_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("Main_seq", "Start test", UVM_LOW)

    seq_fwd = apb_fwd_seq::type_id::create("seq_fwd");
    seq_fwd.regmodel = this.regmodel;
    seq_fwd.start(m_sequencer);

    seq_port_en = port_enable_seq::type_id::create("seq_port_en");
    seq_port_en.regmodel = this.regmodel;
    seq_port_en.start(m_sequencer);

    //Switch Control Registers
    seq_switch_ctrl = switch_ctrl_seq::type_id::create("seq_switch_ctrl");
    seq_switch_ctrl.regmodel = this.regmodel;
    seq_switch_ctrl.start(m_sequencer);

    //Error Enable Registers
    seq_err_en = err_enable_seq::type_id::create("seq_err_en");
    seq_err_en.regmodel = this.regmodel;
    seq_err_en.start(m_sequencer);

    //IRQ Enable Registers
    seq_irq_en = irq_enable_seq::type_id::create("seq_irq_en");
    seq_irq_en.regmodel = this.regmodel;
    seq_irq_en.start(m_sequencer);

    //Generator Control Registers
    seq_gen_ctrl = gen_ctrl_seq::type_id::create("seq_gen_ctrl");
    seq_gen_ctrl.regmodel = this.regmodel;
    seq_gen_ctrl.start(m_sequencer);

    //Read-Only Status & ID Registers
    seq_status_regs = status_regs_seq::type_id::create("seq_status_regs");
    seq_status_regs.regmodel = this.regmodel;
    seq_status_regs.start(m_sequencer);

    //Generator Packet Configuration
    seq_gen_pkt_cfg = gen_pkt_cfg_seq::type_id::create("seq_gen_pkt_cfg");
    seq_gen_pkt_cfg.regmodel = this.regmodel;
    seq_gen_pkt_cfg.start(m_sequencer);

    //Generator Interval
    seq_gen_inv = gen_interval_seq::type_id::create("seq_gen_inv");
    seq_gen_inv.regmodel = this.regmodel;
    seq_gen_inv.start(m_sequencer);

    //Generator Count
    seq_gen_count = gen_count_seq::type_id::create("seq_gen_count");
    seq_gen_count.regmodel = this.regmodel;
    seq_gen_count.start(m_sequencer);

    //IRQ Status
    seq_irq_stat = irq_status_seq::type_id::create("seq_irq_stat");
    seq_irq_stat.regmodel = this.regmodel;
    seq_irq_stat.start(m_sequencer);

    //IRQ Force
    seq_irq_force = irq_force_seq::type_id::create("seq_irq_force");
    seq_irq_force.regmodel = this.regmodel;
    seq_irq_force.start(m_sequencer);

    //Error Status
    seq_err_stat = err_status_seq::type_id::create("seq_err_stat");
    seq_err_stat.regmodel = this.regmodel;
    seq_err_stat.start(m_sequencer);

    //Error Injection Count
    seq_err_inj_cnt=err_inject_count_seq::type_id::create("seq_err_inj_cnt");
    seq_err_inj_cnt.regmodel = this.regmodel;
    seq_err_inj_cnt.start(m_sequencer);

    // Error Information
    seq_err_info = err_info_seq::type_id::create("seq_err_info");
    seq_err_info.regmodel = this.regmodel;
    seq_err_info.start(m_sequencer);

    // Soft Reset
    seq_soft_rst = soft_reset_seq::type_id::create("seq_soft_rst");
    seq_soft_rst.regmodel = this.regmodel;
    seq_soft_rst.start(m_sequencer);

    //Packet Generation
    seq_pkt_gen=pkt_gen_seq::type_id::create("seq_pkt_gen");
    seq_pkt_gen.regmodel=this.regmodel;
    seq_pkt_gen.start(m_sequencer);

    `uvm_info("Main_seq","Test completed",UVM_LOW)
  endtask
endclass
