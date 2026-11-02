`include "uvm_macros.svh"
import uvm_pkg::*;
`include "design.sv"
import apb_pkt_pkg::*;
//Tb
`include "apb_if.sv"
`include "apb_seq_item.sv"
`include "pkt_ral_pkg.sv"
import pkt_ral_pkg::*;
//Components
`include "apb_adapter.sv"
`include "apb_driver.sv"
`include "apb_sequencer.sv"
`include "apb_monitor.sv"
`include "apb_agent.sv"
`include "apb_pkt_env.sv"
`include "apb_reg_seqs.sv"
`include "master_reg_seq.sv"
`include "apb_reg_tests.sv"
`include "master_reg_test.sv"

module tb;
    bit pclk;
    bit presetn;
    initial begin
        pclk = 1'b0;
        forever #5 pclk = ~pclk;
    end
    initial begin
        presetn = 1'b0;
        repeat (5) @(posedge pclk);
        presetn = 1'b1;
    end

    apb_if vif(pclk, presetn);

    apb_pkt_switch dut (
        .pclk    (vif.pclk),
        .presetn (vif.presetn),
        .psel    (vif.psel),
        .penable (vif.penable),
        .pwrite  (vif.pwrite),
        .paddr   (vif.paddr),
        .pwdata  (vif.pwdata),
        .prdata  (vif.prdata),
        .pready  (vif.pready),
        .pslverr (vif.pslverr),
        .irq     (vif.irq)
    );
    initial begin
        uvm_config_db#(virtual apb_if)::set(null, "*", "vif", vif);
        run_test();
    end
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0,tb);
    end
endmodule
