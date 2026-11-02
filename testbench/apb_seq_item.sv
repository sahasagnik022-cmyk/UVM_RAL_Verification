class apb_seq_item extends uvm_sequence_item;
    `uvm_object_utils(apb_seq_item)
    function new(string name="apb_seq_item");
        super.new(name);
    endfunction

    bit psel;
    bit penable;
    rand bit pwrite;
    rand logic[15:0] paddr;
    rand logic[31:0] pwdata;
    logic[31:0] prdata;
    logic irq;
    logic pslverr;

    constraint addr{
        soft paddr[1:0]==2'b00;
        soft paddr<=16'h0060;
    }

endclass
