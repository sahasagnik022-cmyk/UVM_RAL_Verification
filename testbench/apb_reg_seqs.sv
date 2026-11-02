class apb_fwd_seq extends uvm_sequence #(apb_seq_item); 
  `uvm_object_utils(apb_fwd_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_reg_data_t rdata;
  uvm_status_e status;
  function new(string name = "apb_fwd_seq");
    super.new(name);
  endfunction 
  virtual task body();
    regmodel.fwd_enable.read(status, rdata);
    `uvm_info("FWD_EN",$sformatf("Reset value: 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hF)
      `uvm_error("FWD_EN", "Reset value mismatch")
    // Unlock register
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Bin 1
    regmodel.fwd_enable.write(status, 32'h0);
    regmodel.fwd_enable.read(status, rdata);
    `uvm_info("FWD_EN",$sformatf("All blocked: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("FWD_EN", "All-blocked value mismatch")
    // Bin 2
    regmodel.fwd_enable.write(status, 32'h5);
    regmodel.fwd_enable.read(status, rdata);
    `uvm_info("FWD_EN",$sformatf("Partial forwarding: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h5)
      `uvm_error("FWD_EN", "Partial-forwarding value mismatch")
    // Bin 3
    regmodel.fwd_enable.write(status, 32'hF);
    regmodel.fwd_enable.read(status, rdata);
    `uvm_info("FWD_EN",$sformatf("All forwarding enabled: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hF)
      `uvm_error("FWD_EN", "All-forwarding value mismatch")
    // Lock register
    regmodel.lock.write(status, 32'h1);
    // Attempt a write after locking
    regmodel.fwd_enable.write(status, 32'h5);
    regmodel.fwd_enable.read(status, rdata);
    `uvm_info("FWD_EN",$sformatf("After locking: read = 0x%02h", rdata), UVM_LOW)
    // Register should retain its previous value
    if (rdata != 32'hF)
      `uvm_error("FWD_EN", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////
class port_enable_seq extends uvm_sequence#(apb_seq_item);
  `uvm_object_utils(port_enable_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_reg_data_t rdata;
  uvm_status_e status;
  function new(string name = "port_enable_seq");
    super.new(name);
  endfunction
  virtual task body();
    regmodel.port_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("Reset value: 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h0000000F)
      `uvm_error("port_enable", "Reset value mismatch")
    // Unlock register
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Bin 1
    regmodel.port_enable.write(status, 32'h0);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("All disabled: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("port_enable", "All-disabled value mismatch")
    // Bin 2
    regmodel.port_enable.write(status, 32'h5);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("Partial enable: read = 0x%02h", rdata), UVM_LOW) 
    if (rdata != 32'h5)
      `uvm_error("port_enable", "Partial-enable value mismatch")
    // Bin 3
    regmodel.port_enable.write(status, 32'hF);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("All enabled: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hF)
      `uvm_error("port_enable", "All-enabled value mismatch")
    // Lock register and check write protection
    regmodel.lock.write(status, 32'h1);
    regmodel.port_enable.write(status, 32'h5);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("After locking: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hF)
      `uvm_error("port_enable", "Locked register value changed")
  endtask
endclass
//////////////////////////////////////////////////////////////////////////////////////////
class switch_ctrl_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(switch_ctrl_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;
  function new(string name = "switch_ctrl_seq");
    super.new(name);
  endfunction
  virtual task body();
    regmodel.switch_ctrl.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("switch_ctrl", "Reset value ERROR")
    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Hit enable bins: 0 and 8
    regmodel.switch_ctrl.write(status, 32'h0);
    regmodel.switch_ctrl.write(status, 32'h8);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("read from dut = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h8)
      `uvm_error("switch_ctrl", "Write data mismatch")
    // Hit stat_clr bins: 0 and 2
    regmodel.switch_ctrl.write(status, 32'h0);
    regmodel.switch_ctrl.write(status, 32'h2);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("read from dut = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h2)
      `uvm_error("switch_ctrl", "Write data mismatch")
    // Hit irq bins: 0 and 1
    regmodel.switch_ctrl.write(status, 32'h0);
    regmodel.switch_ctrl.write(status, 32'h1);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("read from dut = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h1)
      `uvm_error("switch_ctrl", "Write data mismatch")
    // Exercise combinations of all fields
    regmodel.switch_ctrl.write(status, 32'hB); // 1011
    regmodel.port_enable.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("read from dut = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hB)
      `uvm_error("switch_ctrl", "Write data mismatch")
    regmodel.switch_ctrl.write(status, 32'h9); // 1001
    regmodel.port_enable.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("read from dut = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h9)
      `uvm_error("switch_ctrl", "Write data mismatch")
    regmodel.switch_ctrl.write(status, 32'hA); // 1010
    regmodel.port_enable.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("read from dut = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hA)
      `uvm_error("switch_ctrl", "Write data mismatch")
    regmodel.switch_ctrl.write(status, 32'h0); // 0000
    regmodel.switch_ctrl.read(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("Final read value: 0x%08h", rdata), UVM_LOW) 
  endtask
endclass
//////////////////////////////////////////////////////////////////////////////////////////
class err_enable_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(err_enable_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "err_enable_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.err_enable.read(status, rdata);
    `uvm_info("err_enable",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("err_enable", "Reset value ERROR")
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Hit bus_en bins: 0 and 1
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h1);
    // Hit dest_en bins: 0 and 2
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h2);
    // Hit q_en bins: 0 and 4
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h4);
    // Hit undersize_en bins: 0 and 8
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h8);
    // Hit p_en bins: 0 and 16 (0x10)
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h10);
    // Hit crc_en bins: 0 and 32 (0x20)
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h20);
    // Hit l_en bins: 0 and 64 (0x40)
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h40);
    // Hit injected_en bins: 0 and 128 (0x80)
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.write(status, 32'h80);
    // Exercise combination of all fields
    regmodel.err_enable.write(status, 32'hFF); 
    // Lock register
    regmodel.lock.write(status, 32'h1);
    regmodel.err_enable.write(status, 32'h0);
    regmodel.err_enable.read(status, rdata);
    `uvm_info("err_enable",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'hFF)
      `uvm_error("err_enable", "Locked register value changed")
  endtask
endclass
////////////////////////////////////////////////////////////////////////////////////////
class irq_enable_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(irq_enable_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "irq_enable_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.irq_enable.read(status, rdata);
    `uvm_info("irq_enable",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("irq_enable", "Reset value ERROR")
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Hit gen_done_en bins: 0 and 1
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h1);

    // Hit err_en bins: 0 and 2
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h2);

    // Hit oflow_en bins: 0 and 4
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h4);

    // Hit pkt_drp_en bins: 0 and 8
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h8);

    // Hit pkt_fwd_en bins: 0 and 16 (0x10)
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h10);

    // Hit q_af_en bins: 0 and 32 (0x20)
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h20);

    // Hit stat_ack_en bins: 0 and 64 (0x40)
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h40);

    // Hit sw_event_en bins: 0 and 128 (0x80)
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.write(status, 32'h80);

    // Exercise combination of all fields
    regmodel.irq_enable.write(status, 32'hFF); 

    // Lock register
    regmodel.lock.write(status, 32'h1);

    // Attempt a write after locking
    regmodel.irq_enable.write(status, 32'h0);
    regmodel.irq_enable.read(status, rdata);
    `uvm_info("irq_enable",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    
    // Register should retain its previous value
    if (rdata != 32'hFF)
      `uvm_error("irq_enable", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////
class gen_ctrl_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(gen_ctrl_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;
  function new(string name = "gen_ctrl_seq");
    super.new(name);
  endfunction
  virtual task body();
    regmodel.gen_ctrl.read(status, rdata);
    `uvm_info("gen_ctrl",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("gen_ctrl", "Reset value ERROR")

    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);

    // Hit enable bins: 0 and 1
    regmodel.gen_ctrl.write(status, 32'h0);
    regmodel.gen_ctrl.write(status, 32'h1);

    // Hit stop bins: 0 and 2
    regmodel.gen_ctrl.write(status, 32'h0);
    regmodel.gen_ctrl.write(status, 32'h2);

    // Hit start bins: 0 and 4
    regmodel.gen_ctrl.write(status, 32'h0);
    regmodel.gen_ctrl.write(status, 32'h4);

    // Hit continuous bins: 0 and 8
    regmodel.gen_ctrl.write(status, 32'h0);
    regmodel.gen_ctrl.write(status, 32'h8);

    // Exercise combinations (Sets RW bits 3 and 0 -> 0x9)
    regmodel.gen_ctrl.write(status, 32'h9); 

    // Lock register
    regmodel.lock.write(status, 32'h1);
    regmodel.gen_ctrl.write(status, 32'h0); 
    regmodel.gen_ctrl.read(status, rdata);
    `uvm_info("gen_ctrl",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h9)
      `uvm_error("gen_ctrl", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////
class gen_pkt_cfg_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(gen_pkt_cfg_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;
  int unsigned seed_bins[] = '{0, 65536, 131072, 196608, 262144, 327680, 458752, 524288, 589824, 655360, 720896};
  int unsigned len_bins[]  = '{0, 256, 512, 768, 1024, 1280, 1792, 2048, 2304, 2816, 3840, 3328, 1536};
  int unsigned src_bins[]  = '{0, 4, 8, 12};
  int unsigned dst_bins[]  = '{0, 1, 2, 3};
  function new(string name = "gen_pkt_cfg_seq");
    super.new(name);
  endfunction
  virtual task body();
    // Reset Check (Reset default: 0x00000401)
    regmodel.gen_pkt_cfg.read(status, rdata);
    `uvm_info("gen_pkt_cfg",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h00000401)
      `uvm_error("gen_pkt_cfg", "Reset value ERROR")

    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);

    // Hit seed[] bins with immediate read-checks
    foreach (seed_bins[i]) begin
      regmodel.gen_pkt_cfg.write(status, seed_bins[i]);
      regmodel.gen_pkt_cfg.read(status, rdata);
      `uvm_info("gen_pkt_cfg", $sformatf("Seed write: %0d | read: %0d", seed_bins[i], rdata), UVM_LOW)
      if (rdata != seed_bins[i]) `uvm_error("gen_pkt_cfg", "Seed write data mismatch")
    end

    // Hit length[] bins with immediate read-checks
    foreach (len_bins[i]) begin
      regmodel.gen_pkt_cfg.write(status, len_bins[i]);
      regmodel.gen_pkt_cfg.read(status, rdata);
      `uvm_info("gen_pkt_cfg", $sformatf("Length write: %0d | read: %0d", len_bins[i], rdata), UVM_LOW)
      if (rdata != len_bins[i]) `uvm_error("gen_pkt_cfg", "Length write data mismatch")
    end

    // Hit src_port[] bins with immediate read-checks
    foreach (src_bins[i]) begin
      regmodel.gen_pkt_cfg.write(status, src_bins[i]);
      regmodel.gen_pkt_cfg.read(status, rdata);
      `uvm_info("gen_pkt_cfg", $sformatf("Src Port write: %0d | read: %0d", src_bins[i], rdata), UVM_LOW)
      if (rdata != src_bins[i]) `uvm_error("gen_pkt_cfg", "Src Port write data mismatch")
    end

    // Hit dst_port[] bins with immediate read-checks
    foreach (dst_bins[i]) begin
      regmodel.gen_pkt_cfg.write(status, dst_bins[i]);
      regmodel.gen_pkt_cfg.read(status, rdata);
      `uvm_info("gen_pkt_cfg", $sformatf("Dst Port write: %0d | read: %0d", dst_bins[i], rdata), UVM_LOW)
      if (rdata != dst_bins[i]) `uvm_error("gen_pkt_cfg", "Dst Port write data mismatch")
    end

    // Lock register
    regmodel.lock.write(status, 32'h1);

    // Attempt a write after locking
    regmodel.gen_pkt_cfg.write(status, 32'h0);
    regmodel.gen_pkt_cfg.read(status, rdata);
    `uvm_info("gen_pkt_cfg",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    
    // Register should retain its previous value (the last dst_bin written, which is 3)
    if (rdata != 32'h3)
      `uvm_error("gen_pkt_cfg", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////
class gen_interval_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(gen_interval_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "gen_interval_seq");
    super.new(name);
  endfunction

  virtual task body();
    // Reset Check (Reset default: 0x00000002)
    regmodel.gen_interval.read(status, rdata);
    `uvm_info("gen_interval",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h00000002)
      `uvm_error("gen_interval", "Reset value ERROR")
    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Test middle value (e.g., 256)
    regmodel.gen_interval.write(status, 32'h100);
    regmodel.gen_interval.read(status, rdata);
    `uvm_info("gen_interval",$sformatf("Write 0x100 | Read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h100) `uvm_error("gen_interval", "Write data mismatch for 256")
    // Lock register
    regmodel.lock.write(status, 32'h1);
    // Attempt a write after locking
    regmodel.gen_interval.write(status, 32'h5);
    regmodel.gen_interval.read(status, rdata);
    `uvm_info("gen_interval",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h100)
      `uvm_error("gen_interval", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////
class gen_count_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(gen_count_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "gen_count_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.gen_count.read(status, rdata);
    `uvm_info("gen_count",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h00000004)
      `uvm_error("gen_count", "Reset value ERROR")
    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);
    regmodel.gen_count.write(status, 32'h100);
    regmodel.gen_count.read(status, rdata);
    `uvm_info("gen_count",$sformatf("Write 0x100 | Read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h100) `uvm_error("gen_interval", "Write data mismatch for 256")
    // Lock register
    regmodel.lock.write(status, 32'h1);
    // Attempt a write after locking
    regmodel.gen_count.write(status, 32'h5);
    regmodel.gen_count.read(status, rdata);
    `uvm_info("gen_count",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h100)
      `uvm_error("gen_interval", "Locked register value changed")
  endtask
endclass
//////////////////////////////////////////////////////////////////////////////////////////
class irq_status_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(irq_status_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "irq_status_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.irq_status.read(status, rdata);
    `uvm_info("irq_status",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("irq_status", "Reset value ERROR")
    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Hit the `irq_st = {[0:128]}` bin
    regmodel.irq_status.write(status, 32'h0);
    regmodel.irq_status.read(status, rdata);
    `uvm_info("irq_status",$sformatf("Write 0x0 | Read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0) `uvm_error("irq_status", "W1C register did not return 0")

    regmodel.irq_status.write(status, 32'h80); // 128 (0x80)
    regmodel.irq_status.read(status, rdata);
    `uvm_info("irq_status",$sformatf("Write 0x80 | Read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0) `uvm_error("irq_status", "W1C register did not return 0")

    // Lock register
    regmodel.lock.write(status, 32'h1);
    // Attempt a write after locking
    regmodel.irq_status.write(status, 32'h80);
    regmodel.irq_status.read(status, rdata);
    `uvm_info("irq_status",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("irq_status", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////
class irq_force_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(irq_force_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;

  function new(string name = "irq_force_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.irq_force.read(status, rdata);
    `uvm_info("irq_force",$sformatf("After reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0)
      `uvm_error("irq_force", "Reset value ERROR")

    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Hit the `force_q = {[0:128]}` bin
    regmodel.irq_force.write(status, 32'h40); // 64 (0x40)
    regmodel.irq_force.read(status, rdata);
    `uvm_info("irq_force",$sformatf("Write 0x40 | Read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h40) `uvm_error("irq_force", "Read data mismatch")
    // Lock register
    regmodel.lock.write(status, 32'h1);
    // Attempt a write after locking
    regmodel.irq_force.write(status, 32'h80);
    regmodel.irq_force.read(status, rdata);
    `uvm_info("irq_force",$sformatf("After locking: read = 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h40)
      `uvm_error("irq_force", "Locked register value changed")
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////////////////////
class err_inject_count_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(err_inject_count_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata,count;

  function new(string name = "err_inject_count_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.reset();
    regmodel.err_inject.read(status, rdata);
    `uvm_info("err_inject_count", $sformatf("ERR_INJECT after reset: 0x%08h", rdata), UVM_LOW)
    if (rdata != 32'h0) `uvm_error("err_inject_count", "ERR_INJECT Reset value ERROR")
    regmodel.err_count.read(status, count); // Hits c23 Address
    `uvm_info("err_inject_count", $sformatf("ERR_COUNT after reset: %0d",count), UVM_LOW)
    if (count!= 32'h0) `uvm_error("err_inject_count", "ERR_COUNT Reset value ERROR")
    // Unlock protected registers
    regmodel.lock.write(status, 32'hA5A5C3C3);
    regmodel.err_inject.write(status,32'hF);
    regmodel.err_count.read(status,count);
    `uvm_info("err_inject_count", $sformatf("ERR_COUNT: %0d",count), UVM_LOW)
    if (count!= 32'h4) `uvm_error("err_inject_count", "ERR_COUNT value ERROR")
    regmodel.soft_reset.write(status,32'hF);
    regmodel.err_count.read(status,count);
    `uvm_info("err_inject_count", $sformatf("ERR_COUNT after soft reset: %0d",count), UVM_LOW)
    if (count!= 32'h0) `uvm_error("err_inject_count", "ERR_COUNT value ERROR")
    for(int i=0;i<8;i++) begin
        regmodel.err_inject.write(status,(1<<i));
         regmodel.err_info.read(status,rdata);
      end
      regmodel.err_inject.write(status,32'h00000001);
      regmodel.err_inject.write(status,32'h00000002);
      regmodel.err_inject.write(status,32'h00000004);
      regmodel.err_inject.write(status,32'h00000008);
      regmodel.err_count.read(status,count);
      `uvm_info("seq",$sformatf("rdata(Final count):%0d",count),UVM_LOW);
  endtask
endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////
class status_regs_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(status_regs_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;
  function new(string name = "status_regs_seq");
    super.new(name);
  endfunction
  virtual task body();
    `uvm_info("status_regs", "Reading all RO registers", UVM_LOW)
    // c1: Device ID (0x00)
    regmodel.device_id.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Device ID: 0x%08h", rdata), UVM_LOW)
    // c2: Version ID (0x04)
    regmodel.version.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Version ID: 0x%08h", rdata), UVM_LOW)
    // c3: Switch Status (0x08)
    regmodel.switch_status.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Switch Status: 0x%08h", rdata), UVM_LOW)
    // c4: Port Status (0x0C)
    regmodel.port_status.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Port Status: 0x%08h", rdata), UVM_LOW)
    // c5: Gen Status (0x10)
    regmodel.gen_status.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Gen Status: 0x%08h", rdata), UVM_LOW)
    // c6: Stat Rx (0x14)
    regmodel.stat_rx.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Stat Rx Count: %0d", rdata), UVM_LOW)
    // c7: Stat Tx (0x18)
    regmodel.stat_tx.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Stat Tx Count: %0d", rdata), UVM_LOW)
    // c8: Stat Drop (0x1C)
    regmodel.stat_drop.read(status, rdata);
    `uvm_info("status_regs", $sformatf("Stat Drop Count: %0d", rdata), UVM_LOW)
  endtask
endclass
////////////////////////////////////////////////////////////////////////////////////////////////////
class err_info_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(err_info_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;
  function new(string name = "err_info_seq");
    super.new(name);
  endfunction
  virtual task body();
    //c24 
    regmodel.err_info.read(status, rdata);
    `uvm_info("err_info", $sformatf("ERR_INFO read: 0x%08h", rdata), UVM_LOW)
  endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////////////////////
class soft_reset_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(soft_reset_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  function new(string name = "soft_reset_seq");
    super.new(name);
  endfunction
  virtual task body();
    // Unlock 
    regmodel.lock.write(status, 32'hA5A5C3C3);
    // Hit reset_pulse bins: 0 and 1 for c26
    regmodel.soft_reset.write(status, 32'h0);
    regmodel.soft_reset.write(status, 32'h1);
    `uvm_info("soft_reset", "Soft reset applied", UVM_LOW)
  endtask
endclass
//////////////////////////////////////////////////////////////////////////////////////////////////////
class err_status_seq extends uvm_sequence #(apb_seq_item);
  `uvm_object_utils(err_status_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  int unsigned stat_bits[]='{1,2,4,8,16,32,64,128};
  function new(string name="err_status_seq");
    super.new(name);
  endfunction
  virtual task body();
    // Unlock
    regmodel.lock.write(status, 32'hA5A5C3C3); 
    foreach (stat_bits[i]) begin
      regmodel.err_status.write(status,32'h0);
      regmodel.err_status.write(status,stat_bits[i]);
    end
    `uvm_info("err_status","All c20 error status bins covered",UVM_LOW)
  endtask
endclass
//////////////////////////////////////////////////////////////////////////////////////////////////////////
class pkt_gen_seq extends uvm_sequence#(apb_seq_item);
  `uvm_object_utils(pkt_gen_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e status;
  uvm_reg_data_t rdata;
  function new(string name="pkt_gen_seq");
    super.new(name);
  endfunction

  virtual task body();
    //Unlock
    regmodel.lock.write(status,32'hA5A5C3C3);
    //Enable all ports
    regmodel.port_enable.write(status,32'hF);
    regmodel.port_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("All enabled: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hF)
      `uvm_error("port_enable", "All-ports are not enabled")
    //Enable all destination
    regmodel.fwd_enable.write(status,32'hF);
    regmodel.fwd_enable.read(status, rdata);
    `uvm_info("port_enable",$sformatf("All enabled: read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'hF)
      `uvm_error("fwd_enable", "Fwd-ports are not enabled")
    regmodel.switch_ctrl.write(status,32'h9);
    regmodel.switch_ctrl.read(status,rdata);
    `uvm_info("switch_ctrl",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h9)
      `uvm_error("switch_ctrl", "Read data mismatch")
    regmodel.gen_pkt_cfg.write(status,32'h100401);
    regmodel.gen_pkt_cfg.read(status,rdata);
    `uvm_info("switch_ctrl",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h100401)
      `uvm_error("switch_ctrl", "Read data mismatch")
    regmodel.gen_interval.write(status,32'h2);
    regmodel.gen_interval.read(status,rdata);
    `uvm_info("gen_interval",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h2)
      `uvm_error("gen_interval", "Read data mismatch")
    regmodel.gen_count.write(status,32'h4);
    regmodel.gen_count.read(status,rdata);
    `uvm_info("gen_count",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h4)
      `uvm_error("gen_count", "Read data mismatch")
    regmodel.irq_enable.write(status,32'h41);
    regmodel.irq_enable.read(status,rdata);
    `uvm_info("irq_enable",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h41)
      `uvm_error("irq_enable", "Read data mismatch")
    //Set enable and pulse start
    regmodel.gen_ctrl.write(status,32'h3);
    regmodel.gen_status.read(status,rdata);
  /*  while(rdata!=32'hE) begin
      regmodel.gen_status.read(status,rdata);
      `uvm_info("",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    end */
    #270;
    regmodel.stat_tx.read(status,rdata);
    `uvm_info("stat_tx",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h4)
      `uvm_error("stat_tx", "Read data mismatch")
    regmodel.stat_rx.read(status,rdata);
    `uvm_info("stat_rx",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h4)
      `uvm_error("stat_rx", "Read data mismatch")
    regmodel.gen_status.read(status,rdata);
     `uvm_info("gen_status",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'he)
      `uvm_error("gen_status", "Read data mismatch")
    regmodel.irq_status.read(status,rdata);
     `uvm_info("irq_status",$sformatf("Read = 0x%02h", rdata), UVM_LOW)
    if (rdata != 32'h71)
      `uvm_error("irq_status", "Read data mismatch")
  endtask
endclass
////////////////////////////////////////////////////////////////////////////////////////////////////////////


class back_door_seq extends uvm_sequence#(apb_seq_item);
  `uvm_object_utils(back_door_seq)
  apb_pkt_switch_reg_block regmodel;
  uvm_status_e   status;
  uvm_reg_data_t rdata;

  function new(string name="back_door_seq");
    super.new(name);
  endfunction

  virtual task body();
    regmodel.reset();
    regmodel.lock.write(status, 32'hA5A5_C3C3);
    regmodel.device_id.peek(status, rdata);
    `uvm_info("DEV_ID",$sformatf("rst val of dev_id = %0h (exp:0x2A55357)", rdata),UVM_LOW)
    regmodel.version.peek(status, rdata);
    `uvm_info("VERSION",$sformatf("rst val of version = %0h (exp:0x10200)", rdata),UVM_LOW)
    regmodel.switch_status.peek(status, rdata);
    `uvm_info("SW_STAT",$sformatf("rst val of sw_stat = %h (exp:0xF1)", rdata),UVM_LOW)
    regmodel.port_status.peek(status, rdata);
    `uvm_info("port_stat",$sformatf("rst val of port_stat = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.gen_status.peek(status, rdata);
    `uvm_info("gen_stat",$sformatf("rst val of gen_stat = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.stat_rx.peek(status, rdata);
    `uvm_info("stat_rx",$sformatf("rst val of stat_rx = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.stat_tx.peek(status, rdata);
    `uvm_info("stat_tx",$sformatf("rst val of stat_tx = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.stat_drop.peek(status, rdata);
    `uvm_info("stat_drop",$sformatf("rst val of stat_drop = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.switch_ctrl.peek(status, rdata);
    `uvm_info("switch_ctrl",$sformatf("rst val of switch_ctrl = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.port_enable.peek(status, rdata);
    `uvm_info("port_enb",$sformatf("rst val of port_en= %0h (exp:0xF)", rdata),UVM_LOW)
    regmodel.fwd_enable.peek(status, rdata);
    `uvm_info("fwd_en",$sformatf("rst val of fwd_en = %0h (exp:0xF)", rdata),UVM_LOW)
    regmodel.gen_ctrl.peek(status, rdata);
    `uvm_info("gen_ctrl",$sformatf("rst val of gen_ctrl = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.gen_pkt_cfg.peek(status, rdata);
    `uvm_info("gen_pkt_cfg",$sformatf("rst val of gen_pkt_cfg = %0h (exp:0x401)", rdata),UVM_LOW)
    regmodel.gen_interval.peek(status, rdata);
    `uvm_info("gen_intrvl",$sformatf("rst val of gen_intrvl = %0h (exp:0x2)", rdata),UVM_LOW)
    regmodel.gen_count.peek(status, rdata);
    `uvm_info("gen_cnt",$sformatf("rst val of gen_cnt = %0h (exp:0x4)", rdata),UVM_LOW)
    regmodel.irq_status.peek(status, rdata);
    `uvm_info("irq_stat",$sformatf("rst val of irq_stat = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.irq_enable.peek(status, rdata);
    `uvm_info("irq_en",$sformatf("rst val of irq_en = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.irq_force.peek(status, rdata);
    `uvm_info("irq_force",$sformatf("rst val of irq_force = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.err_status.peek(status, rdata);
    `uvm_info("err_stat",$sformatf("rst val of err_stat = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.err_enable.peek(status, rdata);
    `uvm_info("err_enb",$sformatf("rst val of err_enb = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.err_inject.peek(status, rdata);
    `uvm_info("err_inj",$sformatf("rst val of err_inj = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.err_count.peek(status, rdata);
    `uvm_info("err_count",$sformatf("rst val of err_count = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.err_info.peek(status, rdata);
    `uvm_info("err_info",$sformatf("rst val of err_info = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.lock.peek(status, rdata);
    `uvm_info("lock",$sformatf("rst val of lock = %0h (exp:0x0)", rdata),UVM_LOW)
    regmodel.soft_reset.peek(status, rdata);
    `uvm_info("soft_reset",$sformatf("rst val of soft_reset = %0h (exp:0x0)", rdata),UVM_LOW)

  endtask
endclass

