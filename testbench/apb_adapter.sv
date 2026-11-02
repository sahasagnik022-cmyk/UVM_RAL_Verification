class apb_adapter extends uvm_reg_adapter;
    `uvm_object_utils(apb_adapter)
    function new(string name="apb_adapter");
        super.new(name);
    endfunction
    //reg2bus
    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        apb_seq_item tx;
        tx=apb_seq_item::type_id::create("tx");
        tx.pwrite=(rw.kind==UVM_WRITE)?1:0;
        tx.paddr=rw.addr;
        tx.pwdata=rw.data;
        return tx;
    endfunction
    //bus2reg
    function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
        apb_seq_item tx;
        assert($cast(tx,bus_item));
        rw.kind=tx.pwrite?UVM_WRITE:UVM_READ;
        rw.addr=tx.paddr;
        rw.data=tx.pwrite?tx.pwdata:tx.prdata;
        rw.status=tx.pslverr?UVM_NOT_OK:UVM_IS_OK;
      $display("%0t |adapter gets data from dut:%0h",$time,tx.prdata);
    endfunction
endclass
