class apb_pkt_env extends uvm_env;
    `uvm_component_utils(apb_pkt_env)
    apb_agent agt;
    apb_pkt_switch_reg_block regmodel;
    apb_adapter adt;
    uvm_reg_predictor #(apb_seq_item) p_inst;

    function new(string name="apb_pkt_env",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt=apb_agent::type_id::create("agt",this);
        adt=apb_adapter::type_id::create("adt");
        p_inst=uvm_reg_predictor#(apb_seq_item)::type_id::create("p_inst",this);
        regmodel=apb_pkt_switch_reg_block::type_id::create("regmodel",this);
        regmodel.build();
        regmodel.reset();
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        regmodel.default_map.set_sequencer(agt.seqr,adt);
        regmodel.default_map.set_auto_predict(0);
        agt.mon.ap.connect(p_inst.bus_in);
        p_inst.adapter=adt;
        p_inst.map=regmodel.default_map;
    endfunction
endclass
