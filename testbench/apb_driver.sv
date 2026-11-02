class apb_driver extends uvm_driver#(apb_seq_item);
    `uvm_component_utils(apb_driver)
    function new(string name="apb_driver",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    virtual apb_if vif;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif)) begin
            `uvm_error("drv","Failed to get vif");
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        wait(!vif.presetn);
        vif.drv_cb.psel<=0;
        vif.drv_cb.penable<=0;
        vif.drv_cb.pwrite<=0;
        vif.drv_cb.paddr<=0;
        vif.drv_cb.pwdata<=0;
        wait(vif.presetn==1);
        forever begin
            seq_item_port.get_next_item(req);
            drive_item(req);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_item(apb_seq_item req);
        @(vif.drv_cb);//Setup phase
        vif.drv_cb.psel<=1;
        vif.drv_cb.penable<=0;
        vif.drv_cb.pwrite<=req.pwrite;
        vif.drv_cb.paddr<=req.paddr;
        vif.drv_cb.pwdata<=req.pwdata;
      $display("%t |driver write data:%0h",$time,req.pwdata);
        @(vif.drv_cb);// access phase
        vif.drv_cb.penable<=1;
        @(vif.drv_cb);
         if(!req.pwrite) begin
             req.prdata=vif.drv_cb.prdata;
         end
         req.pslverr=vif.drv_cb.pslverr;
        vif.drv_cb.psel<=0;
        vif.drv_cb.penable<=0;
    endtask
endclass

