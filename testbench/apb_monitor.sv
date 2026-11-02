class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)

    virtual apb_if vif;
    uvm_analysis_port #(apb_seq_item) ap;
    apb_seq_item cov_tx;
    bit[3:0] cov_port_en=4'hF;
    bit[3:0] cov_fwd_en=4'hF;
    covergroup apb_pkt_cg;
        option.per_instance=1;    
        c1:coverpoint cov_tx.paddr //Device id register
        {
            bins dev_id={32'h00};
        }
 
        c2:coverpoint cov_tx.paddr//Version id register
        {
            bins ver_id= {32'h04};
        }
        c3:coverpoint cov_tx.paddr//Switch status register
        {
            bins switch_id= {32'h08};
        }

        c4:coverpoint cov_tx.paddr//Port status register
        {
            bins port_id= {32'h0C};
        }

        c5:coverpoint cov_tx.paddr//Gen Status
        {
            bins gen_id= {32'h010};
        }

        c6:coverpoint cov_tx.paddr//Stat Rx
        {
            bins stat_tx_id= {32'h014};
        }

        c7:coverpoint cov_tx.paddr  //Stat Tx
        {
            bins stat_rx_id= {32'h018};
        }

        c8:coverpoint cov_tx.paddr //Stat Drop register
        {
            bins stat_drop_id= {32'h01C};
        }

        c9:coverpoint cov_tx.pwdata[3:0] iff (cov_tx.paddr==32'h20) //Switch Ctrl register
        {
            bins enable[]={0,8};
            bins stat_clr[]={0,2};
            bins irq[]={0,1};
        }
        c10:coverpoint cov_port_en //Port enable register
        { 
            bins all_disabled = {4'h0};
            bins partial_en   = {[4'h1:4'hE]};
            bins all_enabled  = {4'hF};
        }
        c11:coverpoint cov_fwd_en//Fwd enable register
        {
            bins all_blocked  = {4'h0};
            bins partial_fwd  = {[4'h1:4'hE]};
            bins all_fwd      = {4'hF};
        }
        c12:cross c10,c11;//Cross between Port_EN and FWD_EN

        c13:coverpoint cov_tx.pwdata[3:0] iff (cov_tx.paddr==32'h2C) //GEN_CTRL
        {
            bins continous[]={0,8};
            bins start[]={0,4};
            bins stop[]={0,2};
            bins enable[]={0,1};
        }
        c14:coverpoint cov_tx.pwdata[23:0] iff (cov_tx.paddr==32'h30) //GEN_PKT_CFG
        {
            bins seed[]={0,65536,131072,196608,262144,327680,458752,524288,589824,655360,720896};
            bins length[]={0,256,512,768,1024,1280,1792,2048,2304,2816,3840,3328,1536};
            bins src_port[]={0,4,8,12};
            bins dst_port[]={0,1,2,3};
           // bins low={};
           // bins med={};
           // bins high={};
        }  

        c15:coverpoint cov_tx.pwdata[15:0]  iff(cov_tx.paddr==32'h34) //GEN_INTERVAl
        {
            bins interval ={[0:32768]};
        }
        c16:coverpoint cov_tx.pwdata[15:0] iff(cov_tx.paddr==32'h38) //GEN_COUNT
        {
            bins packet_count ={[0:32768]};
        }
        c17:coverpoint cov_tx.pwdata[7:0] iff(cov_tx.paddr==32'h3C) //IRQ_STATUS
        {
            bins irq_st = {[0:128]};
        }
        c18:coverpoint cov_tx.pwdata[7:0] iff (cov_tx.paddr==32'h40)//IRQ_ENABLE
        {
            bins gen_done_en[]={0,1};
            bins err_en[]={0,2};
            bins oflow_en[]={0,4};
            bins pkt_drp_en[]={0,8};
            bins pkt_fwd_en[]={0,16};
            bins q_af_en[]={0,32};
            bins stat_ack_en[]={0,64};
            bins sw_event_en[]={0,128};
        }
        c19:coverpoint cov_tx.pwdata[7:0] iff (cov_tx.paddr==32'h44) //IRQ_FORCE
        {  
            bins force_q={[0:128]};
        }
        c20:coverpoint cov_tx.pwdata[7:0] iff (cov_tx.paddr==32'h48) //ERR_STATUS
        {
            bins bus_err[]={0,1};
            bins dest_err[]={0,2};
            bins q_of[]={0,4};
            bins undersize[]={0,8};
            bins p_err[]={0,16};
            bins crc_err[]={0,32};
            bins l_err[]={0,64};
            bins injected[]={0,128};
        }
        c21:coverpoint cov_tx.pwdata[7:0] iff (cov_tx.paddr==32'h4C) //ERR_ENABLE
        {
            bins bus_en[]={0,1};
            bins dest_en[]={0,2};
            bins q_en[]={0,4};
            bins undersize_en[]={0,8};
            bins p_en[]={0,16};
            bins crc_en[]={0,32};
            bins l_en[]={0,64};
            bins injected_en[]={0,128};
        }

        c22:coverpoint cov_tx.pwdata[31:0] iff (cov_tx.paddr==32'h50) //ERR_INJECT
        {
            bins bus[]={0,1};
            bins dest[]={0,2};
            bins q[]={0,4};
            bins undersize[]={0,8};
            bins p[]={0,16};
            bins crc[]={0,32};
            bins l[]={0,64};
            bins injected[]={0,128};
            bins clr_cnt[]={32'h8000_0000};
        }
        c23:coverpoint cov_tx.paddr // ERR_COUNT
        {
            bins err_count={32'h54};
        }
        c24:coverpoint cov_tx.paddr // ERR_INFO
        {
            bins err_info={32'h58};
        }
 
        c25:coverpoint cov_tx.pwdata[31:0] iff (cov_tx.paddr==32'h5C) //LOCK
        {
            bins unlock={32'hA5A5_C3C3};
        }
        c26:coverpoint cov_tx.pwdata[0] iff(cov_tx.paddr==32'h60) //SOFT_RESET
        {
            bins reset_pulse[]={0,1};
        }
    endgroup
    function new(string name="apb_monitor",uvm_component parent=null);
        super.new(name,parent);
        ap=new("ap",this);
        apb_pkt_cg=new();
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif)) begin
            `uvm_error("mon","Failed to get vif");
        end
    endfunction
    virtual task run_phase(uvm_phase phase);
        forever begin
            @(vif.mon_cb);
            if(!vif.presetn)begin
                cov_port_en=4'hF;
                cov_fwd_en=4'hF;
            end
            if(vif.mon_cb.psel && vif.mon_cb.pready) begin
                apb_seq_item tx;
                tx=apb_seq_item::type_id::create("tx");
                tx.psel=vif.mon_cb.psel;
                tx.penable=vif.mon_cb.penable;
                tx.pwrite=vif.mon_cb.pwrite;
                tx.paddr=vif.mon_cb.paddr;
                tx.pwdata=vif.mon_cb.pwdata;
                tx.prdata=vif.mon_cb.prdata;
                tx.pslverr=vif.mon_cb.pslverr;
                tx.irq=vif.mon_cb.irq;
                if(tx.pwrite && !tx.pslverr) begin
                    if(tx.paddr==16'h0024) cov_port_en=tx.pwdata[3:0];
                    if(tx.paddr==16'h0028) cov_fwd_en=tx.pwdata[3:0];
                    if(tx.paddr==16'h0060 && tx.pwdata[0]) begin
                        cov_port_en=4'hF;
                        cov_fwd_en=4'hF;
                    end
                end
                cov_tx=tx;
                apb_pkt_cg.sample();
                ap.write(tx);
            end
        end
    endtask

endclass
