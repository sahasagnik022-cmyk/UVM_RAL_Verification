package pkt_ral_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
   class device_id_reg extends uvm_reg;
    `uvm_object_utils(device_id_reg)
    rand uvm_reg_field revision;
    rand uvm_reg_field vendor_id;
    rand uvm_reg_field product_id;

    function new(string name="device_id_reg");
        super.new(name,32,UVM_CVR_ALL);
    endfunction

    virtual function void build();
        product_id=uvm_reg_field::type_id::create("product_id");
        product_id.configure(.parent(this),.size(16),.lsb_pos(0),.access("RO"),.volatile(0),.reset(16'h5357),.has_reset(1),.is_rand(1),.individually_accessible(1));
        vendor_id=uvm_reg_field::type_id::create("vendor_id");
        vendor_id.configure(.parent(this),.size(8),.lsb_pos(16),.access("RO"),.volatile(0),.reset(8'hA5),.has_reset(1),.is_rand(1),.individually_accessible(1));
        revision=uvm_reg_field::type_id::create("revision");
        revision.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(0),.reset(8'h02),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class version_reg extends uvm_reg;
    `uvm_object_utils(version_reg)
    rand uvm_reg_field patch;
    rand uvm_reg_field minor;
    rand uvm_reg_field major;
    rand uvm_reg_field reserved;
    
    function new(string name="version_reg");
        super.new(name,32,UVM_CVR_ALL);
    endfunction

    virtual function void build();
        patch=uvm_reg_field::type_id::create("patch");
        patch.configure(.parent(this),.size(8),.lsb_pos(0),.access("RO"),.volatile(0),.reset(0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        minor=uvm_reg_field::type_id::create("minor");
        minor.configure(.parent(this),.size(8),.lsb_pos(8),.access("RO"),.volatile(0),.reset(2),.has_reset(1),.is_rand(1),.individually_accessible(1));
        major=uvm_reg_field::type_id::create("major");
        major.configure(.parent(this),.size(8),.lsb_pos(16),.access("RO"),.volatile(0),.reset(1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        reserved=uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(0),.reset(0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class switch_status_reg extends uvm_reg;
    `uvm_object_utils(switch_status_reg)

    rand uvm_reg_field ready;
    rand uvm_reg_field busy;
    rand uvm_reg_field switch_enabled;
    rand uvm_reg_field locked;
    rand uvm_reg_field port_enabled;
    rand uvm_reg_field gen_running;
    rand uvm_reg_field err_pending;
    rand uvm_reg_field gen_fsm;
    rand uvm_reg_field reserved_1;
    rand uvm_reg_field reserved_2;

    function new(string name = "switch_status_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved_1 = uvm_reg_field::type_id::create("reserved_1");
        reserved_1.configure(.parent(this),.size(14), .lsb_pos(18),.access("RO"),.volatile(0),.reset(14'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        gen_fsm = uvm_reg_field::type_id::create("gen_fsm");
        gen_fsm.configure(.parent(this),.size(2),.lsb_pos(16),.access("RO"),.volatile(1),.reset(2'b00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        reserved_2 =uvm_reg_field::type_id::create("reserved_2");
        reserved_2.configure(.parent(this),.size(6),.lsb_pos(10),.access("RO"),.volatile(0),.reset(6'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        err_pending = uvm_reg_field::type_id::create("err_pending");
        err_pending.configure(.parent(this),.size(1),.lsb_pos(9),.access("RO"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        gen_running = uvm_reg_field::type_id::create("gen_running");
        gen_running.configure(.parent(this),.size(1),.lsb_pos(8),.access("RO"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port_enabled = uvm_reg_field::type_id::create("port_enabled");
        port_enabled.configure(.parent(this),.size(4),.lsb_pos(4),.access("RO"),.volatile(1),.reset(4'hF),.has_reset(1),.is_rand(1),.individually_accessible(1));
        locked = uvm_reg_field::type_id::create("locked");
        locked.configure(.parent(this),.size(1),.lsb_pos(3),.access("RO"),.volatile(1),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        switch_enabled = uvm_reg_field::type_id::create("switch_enabled");
        switch_enabled.configure(.parent(this),.size(1),.lsb_pos(2),.access("RO"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        busy = uvm_reg_field::type_id::create("busy");
        busy.configure(.parent(this),.size(1),.lsb_pos(1),.access("RO"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        ready = uvm_reg_field::type_id::create("ready");
        ready.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(1),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class port_status_reg extends uvm_reg;
    `uvm_object_utils(port_status_reg)

    rand uvm_reg_field port3_level;
    rand uvm_reg_field port2_level;
    rand uvm_reg_field port1_level;
    rand uvm_reg_field port0_level;

    function new(string name = "port_status_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        port3_level = uvm_reg_field::type_id::create("port3_level");
        port3_level.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(1),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port2_level = uvm_reg_field::type_id::create("port2_level");
        port2_level.configure(.parent(this), .size(8),.lsb_pos(16),.access("RO"),.volatile(1), .reset(8'h00), .has_reset(1), .is_rand(1),.individually_accessible(1));
        port1_level = uvm_reg_field::type_id::create("port1_level");
        port1_level.configure(.parent(this), .size(8),.lsb_pos(8),.access("RO"),.volatile(1),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port0_level = uvm_reg_field::type_id::create("port0_level");
        port0_level.configure(.parent(this),.size(8),.lsb_pos(0),.access("RO"),.volatile(1), .reset(8'h00), .has_reset(1), .is_rand(1),.individually_accessible(1));
    endfunction
endclass

class gen_status_reg extends uvm_reg;
    `uvm_object_utils(gen_status_reg)
    rand uvm_reg_field reserved2;
    rand uvm_reg_field remaining;
    rand uvm_reg_field reserved1;
    rand uvm_reg_field fsm;
    rand uvm_reg_field done;
    rand uvm_reg_field running;

    function new(string name = "gen_status_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved2 = uvm_reg_field::type_id::create("reserved2");
        reserved2.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(0),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        remaining = uvm_reg_field::type_id::create("remaining");
        remaining.configure(.parent(this),.size(16),.lsb_pos(8),.access("RO"),.volatile(1),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
        reserved1 = uvm_reg_field::type_id::create("reserved1");
        reserved1.configure(.parent(this),.size(4),.lsb_pos(4),.access("RO"),.volatile(0),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        fsm = uvm_reg_field::type_id::create("fsm");
        fsm.configure(.parent(this), .size(2), .lsb_pos(2), .access("RO"),.volatile(1),.reset(2'b00), .has_reset(1), .is_rand(1),.individually_accessible(1));
        done = uvm_reg_field::type_id::create("done");
        done.configure(.parent(this),.size(1),.lsb_pos(1), .access("RO"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        running = uvm_reg_field::type_id::create("running");
        running.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class stat_rx_reg extends uvm_reg;
    `uvm_object_utils(stat_rx_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field rx_packets;

    function new(string name = "stat_rx_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RO"),.volatile(0), .reset(16'h0000), .has_reset(1), .is_rand(1),.individually_accessible(1));
        rx_packets = uvm_reg_field::type_id::create("rx_packets");
        rx_packets.configure(.parent(this),.size(16),.lsb_pos(0),.access("RO"),.volatile(1),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class stat_tx_reg extends uvm_reg;
    `uvm_object_utils(stat_tx_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field tx_packets;

    function new(string name = "stat_tx_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RO"),.volatile(0),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
        tx_packets = uvm_reg_field::type_id::create("tx_packets");
        tx_packets.configure(.parent(this),.size(16),.lsb_pos(0), .access("RO"),.volatile(1),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class stat_drop_reg extends uvm_reg;
    `uvm_object_utils(stat_drop_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field dropped_packets;

    function new(string name = "stat_drop_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RO"),.volatile(0),.reset(16'h0000), .has_reset(1), .is_rand(1),.individually_accessible(1));
        dropped_packets = uvm_reg_field::type_id::create("dropped_packets");
        dropped_packets.configure(.parent(this), .size(16), .lsb_pos(0), .access("RO"),.volatile(1),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class switch_ctrl_reg extends uvm_reg;
    `uvm_object_utils(switch_ctrl_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field irq_global_en;
    rand uvm_reg_field reserved_1;
    rand uvm_reg_field stat_clear;
    rand uvm_reg_field enable;

    function new(string name = "switch_ctrl_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this), .size(28), .lsb_pos(4), .access("RO"),.volatile(0),.reset(28'h0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        irq_global_en = uvm_reg_field::type_id::create("irq_global_en");
        irq_global_en.configure(.parent(this), .size(1), .lsb_pos(3), .access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        reserved_1 = uvm_reg_field::type_id::create("reserved_1");
        reserved_1.configure(.parent(this), .size(1), .lsb_pos(2), .access("RO"),.volatile(0), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        stat_clear = uvm_reg_field::type_id::create("stat_clear");
        stat_clear.configure(.parent(this),.size(1),.lsb_pos(1),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        enable = uvm_reg_field::type_id::create("enable");
        enable.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class port_enable_reg extends uvm_reg;
    `uvm_object_utils(port_enable_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field port3_en;
    rand uvm_reg_field port2_en;
    rand uvm_reg_field port1_en;
    rand uvm_reg_field port0_en;

    function new(string name = "port_enable_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(28),.lsb_pos(4),.access("RO"),.volatile(0),.reset(28'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port3_en = uvm_reg_field::type_id::create("port3_en");
        port3_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port2_en = uvm_reg_field::type_id::create("port2_en");
        port2_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port1_en = uvm_reg_field::type_id::create("port1_en");
        port1_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        port0_en = uvm_reg_field::type_id::create("port0_en");
        port0_en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class fwd_enable_reg extends uvm_reg;
    `uvm_object_utils(fwd_enable_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field fwd3_en;
    rand uvm_reg_field fwd2_en;
    rand uvm_reg_field fwd1_en;
    rand uvm_reg_field fwd0_en;

    function new(string name = "fwd_enable_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(28),.lsb_pos(4),.access("RO"),.volatile(0),.reset(28'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        fwd3_en = uvm_reg_field::type_id::create("fwd3_en");
        fwd3_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        fwd2_en = uvm_reg_field::type_id::create("fwd2_en");
        fwd2_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        fwd1_en = uvm_reg_field::type_id::create("fwd1_en");
        fwd1_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
        fwd0_en = uvm_reg_field::type_id::create("fwd0_en");
        fwd0_en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class gen_ctrl_reg extends uvm_reg;
    `uvm_object_utils(gen_ctrl_reg)

    rand uvm_reg_field reserved_28;
    rand uvm_reg_field continuous;
    rand uvm_reg_field stop;
    rand uvm_reg_field start;
    rand uvm_reg_field enable;

    function new(string name = "gen_ctrl_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved_28 = uvm_reg_field::type_id::create("reserved_28");
        reserved_28.configure(.parent(this),.size(28),.lsb_pos(4),.access("RO"),.volatile(0),.reset(28'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        continuous = uvm_reg_field::type_id::create("continuous");
        continuous.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        stop = uvm_reg_field::type_id::create("stop");
        stop.configure(.parent(this),.size(1),.lsb_pos(2),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        start = uvm_reg_field::type_id::create("start");
        start.configure(.parent(this),.size(1),.lsb_pos(1),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        enable = uvm_reg_field::type_id::create("enable");
        enable.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class gen_pkt_cfg_reg extends uvm_reg;
    `uvm_object_utils(gen_pkt_cfg_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field seed;
    rand uvm_reg_field length;
    rand uvm_reg_field reserved_4;
    rand uvm_reg_field src_port;
    rand uvm_reg_field dst_port;

    function new(string name = "gen_pkt_cfg_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(8),.lsb_pos(24),.access("RO"),.volatile(0), .reset(8'h00), .has_reset(1), .is_rand(1),.individually_accessible(1));
        seed = uvm_reg_field::type_id::create("seed");
        seed.configure(.parent(this), .size(8), .lsb_pos(16), .access("RW"),.volatile(0), .reset(8'h00), .has_reset(1), .is_rand(1),.individually_accessible(1));
        length = uvm_reg_field::type_id::create("length");
        length.configure(.parent(this), .size(8), .lsb_pos(8), .access("RW"),.volatile(0), .reset(8'h04), .has_reset(1), .is_rand(1),.individually_accessible(1));
        reserved_4 = uvm_reg_field::type_id::create("reserved_4");
        reserved_4.configure(.parent(this), .size(4), .lsb_pos(4), .access("RO"),.volatile(0), .reset(4'h0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        src_port = uvm_reg_field::type_id::create("src_port");
        src_port.configure(.parent(this), .size(2), .lsb_pos(2), .access("RW"),.volatile(0), .reset(2'b00), .has_reset(1), .is_rand(1),.individually_accessible(1));
        dst_port = uvm_reg_field::type_id::create("dst_port");
        dst_port.configure(.parent(this),.size(2),.lsb_pos(0),.access("RW"),.volatile(0),.reset(2'b01),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class gen_interval_reg extends uvm_reg;
    `uvm_object_utils(gen_interval_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field interval;
    function new(string name = "gen_interval_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this), .size(16), .lsb_pos(16), .access("RO"),.volatile(0),.reset(16'h0000), .has_reset(1), .is_rand(1),.individually_accessible(1));
        interval = uvm_reg_field::type_id::create("interval");
        interval.configure(.parent(this), .size(16), .lsb_pos(0), .access("RW"),.volatile(0),.reset(16'h0002), .has_reset(1), .is_rand(1),.individually_accessible(1));
    endfunction
endclass

class gen_count_reg extends uvm_reg;
    `uvm_object_utils(gen_count_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field packet_count;

    function new(string name = "gen_count_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this), .size(16), .lsb_pos(16), .access("RO"),.volatile(0), .reset(16'h0000), .has_reset(1), .is_rand(1),.individually_accessible(1));
        packet_count = uvm_reg_field::type_id::create("packet_count");
        packet_count.configure(.parent(this), .size(16), .lsb_pos(0), .access("RW"),.volatile(0), .reset(16'h0004), .has_reset(1), .is_rand(1),.individually_accessible(1));
    endfunction
endclass

class irq_status_reg extends uvm_reg;
    `uvm_object_utils(irq_status_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field sw_event;
    rand uvm_reg_field start_ack;
    rand uvm_reg_field queue_almost_full;
    rand uvm_reg_field packet_forwarded;
    rand uvm_reg_field packet_dropped;
    rand uvm_reg_field queue_overflow;
    rand uvm_reg_field error;
    rand uvm_reg_field gen_done;

    function new(string name = "irq_status_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8), .access("RO"),.volatile(0),.reset(24'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        sw_event = uvm_reg_field::type_id::create("sw_event");
        sw_event.configure(.parent(this), .size(1), .lsb_pos(7), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        start_ack = uvm_reg_field::type_id::create("start_ack");
        start_ack.configure(.parent(this), .size(1), .lsb_pos(6), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        queue_almost_full = uvm_reg_field::type_id::create("queue_almost_full");
        queue_almost_full.configure(.parent(this), .size(1), .lsb_pos(5), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        packet_forwarded = uvm_reg_field::type_id::create("packet_forwarded");
        packet_forwarded.configure(.parent(this), .size(1), .lsb_pos(4), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        packet_dropped = uvm_reg_field::type_id::create("packet_dropped");
        packet_dropped.configure(.parent(this), .size(1), .lsb_pos(3), .access("W1C"),.volatile(1),.reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
        queue_overflow.configure(.parent(this),.size(1),.lsb_pos(2),.access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        error = uvm_reg_field::type_id::create("error");
        error.configure(.parent(this), .size(1), .lsb_pos(1), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        gen_done = uvm_reg_field::type_id::create("gen_done");
        gen_done.configure(.parent(this), .size(1), .lsb_pos(0), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
    endfunction
endclass

class irq_enable_reg extends uvm_reg;
    `uvm_object_utils(irq_enable_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field sw_event_en;
    rand uvm_reg_field start_ack_en;
    rand uvm_reg_field queue_af_en;
    rand uvm_reg_field packet_fwd_en;
    rand uvm_reg_field packet_drop_en;
    rand uvm_reg_field overflow_en;
    rand uvm_reg_field error_en;
    rand uvm_reg_field gen_done_en;

    function new(string name = "irq_enable_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8),.access("RO"),.volatile(0),.reset(24'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        sw_event_en = uvm_reg_field::type_id::create("sw_event_en");
        sw_event_en.configure(.parent(this),.size(1),.lsb_pos(7),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        start_ack_en = uvm_reg_field::type_id::create("start_ack_en");
        start_ack_en.configure(.parent(this),.size(1),.lsb_pos(6),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        queue_af_en = uvm_reg_field::type_id::create("queue_af_en");
        queue_af_en.configure(.parent(this),.size(1),.lsb_pos(5),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        packet_fwd_en = uvm_reg_field::type_id::create("packet_fwd_en");
        packet_fwd_en.configure(.parent(this),.size(1),.lsb_pos(4),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        packet_drop_en = uvm_reg_field::type_id::create("packet_drop_en");
        packet_drop_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        overflow_en = uvm_reg_field::type_id::create("overflow_en");
        overflow_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        error_en = uvm_reg_field::type_id::create("error_en");
        error_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        gen_done_en = uvm_reg_field::type_id::create("gen_done_en");
        gen_done_en.configure(.parent(this), .size(1), .lsb_pos(0), .access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class irq_force_reg extends uvm_reg;
    `uvm_object_utils(irq_force_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field force_f;

    function new(string name = "irq_force_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8),.access("RO"),.volatile(0),.reset(24'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        force_f= uvm_reg_field::type_id::create("force");
        force_f.configure(.parent(this), .size(8),.lsb_pos(0),.access("WO"),.volatile(0),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class err_status_reg extends uvm_reg;
    `uvm_object_utils(err_status_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field injected;
    rand uvm_reg_field length_error;
    rand uvm_reg_field crc_error;
    rand uvm_reg_field protocol_error;
    rand uvm_reg_field undersize;
    rand uvm_reg_field queue_overflow;
    rand uvm_reg_field dest_error;
    rand uvm_reg_field bus_error;

    function new(string name = "err_status_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(24),.lsb_pos(8), .access("RO"),.volatile(0),.reset(24'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        injected = uvm_reg_field::type_id::create("injected");
        injected.configure(.parent(this),.size(1),.lsb_pos(7), .access("W1C"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        length_error = uvm_reg_field::type_id::create("length_error");
        length_error.configure(.parent(this), .size(1), .lsb_pos(6), .access("W1C"),.volatile(1),.reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        crc_error = uvm_reg_field::type_id::create("crc_error");
        crc_error.configure(.parent(this),.size(1),.lsb_pos(5), .access("W1C"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        protocol_error = uvm_reg_field::type_id::create("protocol_error");
        protocol_error.configure(.parent(this), .size(1), .lsb_pos(4), .access("W1C"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        undersize = uvm_reg_field::type_id::create("undersize");
        undersize.configure(.parent(this),.size(1),.lsb_pos(3),.access("W1C"),.volatile(1),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        queue_overflow = uvm_reg_field::type_id::create("queue_overflow");
        queue_overflow.configure(.parent(this), .size(1), .lsb_pos(2), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        dest_error = uvm_reg_field::type_id::create("dest_error");
        dest_error.configure(.parent(this), .size(1), .lsb_pos(1), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        bus_error = uvm_reg_field::type_id::create("bus_error");
        bus_error.configure(.parent(this), .size(1), .lsb_pos(0), .access("W1C"),.volatile(1), .reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
    endfunction
endclass

class err_enable_reg extends uvm_reg;
    `uvm_object_utils(err_enable_reg)

    rand uvm_reg_field reserved;
    rand uvm_reg_field injected_en;
    rand uvm_reg_field length_en;
    rand uvm_reg_field crc_en;
    rand uvm_reg_field protocol_en;
    rand uvm_reg_field undersize_en;
    rand uvm_reg_field overflow_en;
    rand uvm_reg_field dest_en;
    rand uvm_reg_field bus_en;

    function new(string name = "err_enable_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this), .size(24), .lsb_pos(8), .access("RO"),.volatile(0),.reset(24'h0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        injected_en = uvm_reg_field::type_id::create("injected_en");
        injected_en.configure(.parent(this), .size(1), .lsb_pos(7), .access("RW"),.volatile(0),.reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        length_en = uvm_reg_field::type_id::create("length_en");
        length_en.configure(.parent(this),.size(1),.lsb_pos(6),.access("RW"),.volatile(0),.reset(1'b0), .has_reset(1), .is_rand(1),.individually_accessible(1));
        crc_en = uvm_reg_field::type_id::create("crc_en");
        crc_en.configure(.parent(this),.size(1),.lsb_pos(5),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        protocol_en = uvm_reg_field::type_id::create("protocol_en");
        protocol_en.configure(.parent(this),.size(1),.lsb_pos(4),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        undersize_en = uvm_reg_field::type_id::create("undersize_en");
        undersize_en.configure(.parent(this),.size(1),.lsb_pos(3),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        overflow_en = uvm_reg_field::type_id::create("overflow_en");
        overflow_en.configure(.parent(this),.size(1),.lsb_pos(2),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        dest_en = uvm_reg_field::type_id::create("dest_en");
        dest_en.configure(.parent(this),.size(1),.lsb_pos(1),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        bus_en = uvm_reg_field::type_id::create("bus_en");
        bus_en.configure(.parent(this),.size(1),.lsb_pos(0),.access("RW"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class err_inject_reg extends uvm_reg;
    `uvm_object_utils(err_inject_reg)

    rand uvm_reg_field clear_count;
    rand uvm_reg_field reserved;
    rand uvm_reg_field injected;
    rand uvm_reg_field length;
    rand uvm_reg_field crc;
    rand uvm_reg_field protocol;
    rand uvm_reg_field undersize;
    rand uvm_reg_field overflow;
    rand uvm_reg_field dest;
    rand uvm_reg_field bus;

    function new(string name = "err_inject_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        clear_count = uvm_reg_field::type_id::create("clear_count");
        clear_count.configure(.parent(this),.size(1),.lsb_pos(31),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(23),.lsb_pos(8),.access("RO"),.volatile(0),.reset(23'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        injected = uvm_reg_field::type_id::create("injected");
        injected.configure(.parent(this),.size(1),.lsb_pos(7),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        length = uvm_reg_field::type_id::create("length");
      length.configure(.parent(this),.size(1),.lsb_pos(6),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        crc = uvm_reg_field::type_id::create("crc");
        crc.configure(.parent(this),.size(1),.lsb_pos(5),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        protocol = uvm_reg_field::type_id::create("protocol");
        protocol.configure(.parent(this),.size(1),.lsb_pos(4),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        undersize = uvm_reg_field::type_id::create("undersize");
        undersize.configure(.parent(this),.size(1),.lsb_pos(3),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        overflow = uvm_reg_field::type_id::create("overflow");
        overflow.configure(.parent(this),.size(1),.lsb_pos(2),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        dest = uvm_reg_field::type_id::create("dest");
        dest.configure(.parent(this),.size(1),.lsb_pos(1),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        bus=uvm_reg_field::type_id::create("bus");
        bus.configure(.parent(this),.size(1),.lsb_pos(0),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class err_count_reg extends uvm_reg;
    `uvm_object_utils(err_count_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field error_count;

    function new(string name = "err_count_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(16),.lsb_pos(16),.access("RO"),.volatile(0),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
        error_count = uvm_reg_field::type_id::create("error_count");
        error_count.configure(.parent(this),.size(16),.lsb_pos(0),.access("RO"),.volatile(1),.reset(16'h0000),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class err_info_reg extends uvm_reg;
    `uvm_object_utils(err_info_reg)

    rand uvm_reg_field tx_snapshot;
    rand uvm_reg_field reserved;
    rand uvm_reg_field dest_port;
    rand uvm_reg_field source;
    rand uvm_reg_field last_code;

    function new(string name = "err_info_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        tx_snapshot = uvm_reg_field::type_id::create("tx_snapshot");
        tx_snapshot.configure(.parent(this),.size(12),.lsb_pos(20),.access("RO"),.volatile(1),.reset(12'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(2),.lsb_pos(18),.access("RO"),.volatile(0),.reset(2'b00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        dest_port = uvm_reg_field::type_id::create("dest_port");
        dest_port.configure(.parent(this),.size(2),.lsb_pos(16),.access("RO"),.volatile(1), .reset(2'b00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        source = uvm_reg_field::type_id::create("source");
        source.configure(.parent(this),.size(8),.lsb_pos(8),.access("RO"),.volatile(1),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
        last_code = uvm_reg_field::type_id::create("last_code");
        last_code.configure(.parent(this),.size(8),.lsb_pos(0),.access("RO"),.volatile(1),.reset(8'h00),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class lock_reg extends uvm_reg;
    `uvm_object_utils(lock_reg)

    rand uvm_reg_field key_reserved;
    rand uvm_reg_field locked;

    function new(string name = "lock_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        key_reserved = uvm_reg_field::type_id::create("key_reserved");
        key_reserved.configure(.parent(this),.size(31),.lsb_pos(1),.access("WO"),.volatile(0),.reset(31'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        locked = uvm_reg_field::type_id::create("locked");
        locked.configure(.parent(this),.size(1),.lsb_pos(0),.access("RO"),.volatile(1),.reset(1'b1),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class soft_reset_reg extends uvm_reg;
    `uvm_object_utils(soft_reset_reg)
    rand uvm_reg_field reserved;
    rand uvm_reg_field pulse;

    function new(string name = "soft_reset_reg");
        super.new(name, 32, UVM_CVR_ALL);
    endfunction

    virtual function void build();
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),.size(31),.lsb_pos(1),.access("RO"),.volatile(0),.reset(31'h0),.has_reset(1),.is_rand(1),.individually_accessible(1));
        pulse = uvm_reg_field::type_id::create("pulse");
        pulse.configure(.parent(this),.size(1),.lsb_pos(0),.access("WO"),.volatile(0),.reset(1'b0),.has_reset(1),.is_rand(1),.individually_accessible(1));
    endfunction
endclass

class apb_pkt_switch_reg_block extends uvm_reg_block;
    `uvm_object_utils(apb_pkt_switch_reg_block)

    device_id_reg device_id;
    version_reg version;
    switch_status_reg switch_status;
    port_status_reg port_status;
    gen_status_reg gen_status;
    stat_rx_reg stat_rx;
    stat_tx_reg stat_tx;
    stat_drop_reg stat_drop;
    switch_ctrl_reg switch_ctrl;
    port_enable_reg port_enable;
    fwd_enable_reg fwd_enable;
    gen_ctrl_reg gen_ctrl;
    gen_pkt_cfg_reg gen_pkt_cfg;
    gen_interval_reg gen_interval;
    gen_count_reg gen_count;
    irq_status_reg irq_status;
    irq_enable_reg irq_enable;
    irq_force_reg irq_force;
    err_status_reg err_status;
    err_enable_reg err_enable;
    err_inject_reg err_inject;
    err_count_reg err_count;
    err_info_reg err_info;
    lock_reg lock;
    soft_reset_reg soft_reset;

    function new(string name = "apb_pkt_switch_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        add_hdl_path("dut","RTL");
        device_id = device_id_reg::type_id::create("device_id");
        device_id.configure(this, null, "");
        device_id.build();
        version = version_reg::type_id::create("version");
        version.configure(this, null, "");
        version.build();
        switch_status = switch_status_reg::type_id::create("switch_status");
        switch_status.configure(this, null, "");
        switch_status.add_hdl_path_slice("switch_status_r", 0, 32);
        switch_status.build();
        port_status = port_status_reg::type_id::create("port_status");
        port_status.configure(this, null, "");
        port_status.build();
        gen_status = gen_status_reg::type_id::create("gen_status");
        gen_status.configure(this, null, "");
        gen_status.build();
        stat_rx = stat_rx_reg::type_id::create("stat_rx");
        stat_rx.configure(this, null, "");
        stat_rx.build();
        stat_tx = stat_tx_reg::type_id::create("stat_tx");
        stat_tx.configure(this, null, "");
        stat_tx.build();
        stat_drop = stat_drop_reg::type_id::create("stat_drop");
        stat_drop.configure(this, null, "");
        stat_drop.build();
        switch_ctrl = switch_ctrl_reg::type_id::create("switch_ctrl");
        switch_ctrl.configure(this, null, "");
        switch_ctrl.build();
        port_enable = port_enable_reg::type_id::create("port_enable");
        port_enable.configure(this, null, "");
        port_enable.build();
        fwd_enable = fwd_enable_reg::type_id::create("fwd_enable");
        fwd_enable.configure(this, null, "");
        fwd_enable.build();
        gen_ctrl = gen_ctrl_reg::type_id::create("gen_ctrl");
        gen_ctrl.configure(this, null, "");
        gen_ctrl.build();
        gen_pkt_cfg = gen_pkt_cfg_reg::type_id::create("gen_pkt_cfg");
        gen_pkt_cfg.configure(this, null, "");
        gen_pkt_cfg.build();
        gen_interval = gen_interval_reg::type_id::create("gen_interval");
        gen_interval.configure(this, null, "");
        gen_interval.build();
        gen_count = gen_count_reg::type_id::create("gen_count");
        gen_count.configure(this, null, "");
        gen_count.build();
        irq_status = irq_status_reg::type_id::create("irq_status");
        irq_status.configure(this, null, "");
        irq_status.build();
        irq_enable = irq_enable_reg::type_id::create("irq_enable");
        irq_enable.configure(this, null, "");
        irq_enable.build();

        irq_force = irq_force_reg::type_id::create("irq_force");
        irq_force.configure(this, null, "");
        irq_force.build();

        err_status = err_status_reg::type_id::create("err_status");
        err_status.configure(this, null, "");
        err_status.build();

        err_enable = err_enable_reg::type_id::create("err_enable");
        err_enable.configure(this, null, "");
        err_enable.build();

        err_inject = err_inject_reg::type_id::create("err_inject");
        err_inject.configure(this, null, "");
        err_inject.build();

        err_count = err_count_reg::type_id::create("err_count");
        err_count.configure(this, null, "");
        err_count.build();

        err_info = err_info_reg::type_id::create("err_info");
        err_info.configure(this, null, "");
        err_info.build();

        lock = lock_reg::type_id::create("lock");
        lock.configure(this, null, "");
        lock.build();

        soft_reset = soft_reset_reg::type_id::create("soft_reset");
        soft_reset.configure(this, null, "");
        soft_reset.build();


        default_map = create_map("default_map",32'h0000,4,UVM_LITTLE_ENDIAN,0);
        // device_id.add_hdl_path_slice("DEVICE_ID", 0, 32); // Does not exist
        // version.add_hdl_path_slice("VERSION", 0, 32); // Does not exist
        switch_status.add_hdl_path_slice("switch_status_r", 0, 32);
        port_status.add_hdl_path_slice("port_status_r", 0, 32);
        gen_status.add_hdl_path_slice("gen_status_r", 0, 32);

        stat_rx.add_hdl_path_slice("stat_rx", 0, 32);
        stat_tx.add_hdl_path_slice("stat_tx", 0, 32);
        stat_drop.add_hdl_path_slice("stat_drop", 0, 32);

        switch_ctrl.add_hdl_path_slice("switch_ctrl_q", 0, 32);
        port_enable.add_hdl_path_slice("port_enable_q", 0, 32);
        fwd_enable.add_hdl_path_slice("fwd_enable_q", 0, 32);

        gen_ctrl.add_hdl_path_slice("gen_ctrl_q", 0, 32);
        gen_pkt_cfg.add_hdl_path_slice("gen_pkt_cfg_q", 0, 32);
        gen_interval.add_hdl_path_slice("gen_interval_q", 0, 32);
        gen_count.add_hdl_path_slice("gen_count_q", 0, 32);

        irq_status.add_hdl_path_slice("irq_status_q", 0, 32);

        // irq_enable.add_hdl_path_slice("irq_enable_q", 0, 32); // Wrong path
        // irq_force.add_hdl_path_slice("irq_force_q", 0, 32); // Wrong path

        err_status.add_hdl_path_slice("err_status_q", 0, 32);
        err_enable.add_hdl_path_slice("err_enable_q", 0, 32);

        err_inject.add_hdl_path_slice("ERR_INJECT", 0, 32);

        err_count.add_hdl_path_slice("err_count_q", 0, 32);
        err_info.add_hdl_path_slice("err_info_q", 0, 32);

        lock.add_hdl_path_slice("locked", 0, 32);

        soft_reset.add_hdl_path_slice("SOFT_RESET", 0, 32);default_map.add_reg(device_id,32'h00, "RW");
        default_map.add_reg(version,32'h04, "RW");
        default_map.add_reg(switch_status,32'h08, "RW");
        default_map.add_reg(port_status,32'h0C, "RW");
        default_map.add_reg(gen_status,32'h10, "RW");
        default_map.add_reg(stat_rx,32'h14, "RW");
        default_map.add_reg(stat_tx,32'h18, "RW");
        default_map.add_reg(stat_drop,32'h1C, "RW");
        default_map.add_reg(switch_ctrl,32'h20, "RW");
        default_map.add_reg(port_enable,32'h24, "RW");
        default_map.add_reg(fwd_enable,32'h28, "RW");
        default_map.add_reg(gen_ctrl,32'h2C, "RW");
        default_map.add_reg(gen_pkt_cfg,32'h30, "RW");
        default_map.add_reg(gen_interval,32'h34, "RW");
        default_map.add_reg(gen_count,32'h38, "RW");
        default_map.add_reg(irq_status,32'h3C, "RW");
        default_map.add_reg(irq_enable,32'h40, "RW");
        default_map.add_reg(irq_force,32'h44, "RW");
        default_map.add_reg(err_status,32'h48, "RW");
        default_map.add_reg(err_enable,32'h4C, "RW");
        default_map.add_reg(err_inject,32'h50, "RW");
        default_map.add_reg(err_count,32'h54, "RW");
        default_map.add_reg(err_info,32'h58, "RW");
        default_map.add_reg(lock,32'h5C,"RW");
        default_map.add_reg(soft_reset,32'h60,"RW");

        lock_model();
    endfunction
endclass


endpackage
