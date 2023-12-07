/*###################################################################*\
##              Class Name: i2c_master_stat_monitor                  ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_STAT_MONITOR_SVH
`define I2C_MASTER_STAT_MONITOR_SVH

class i2c_master_stat_monitor extends uvm_monitor;
    `uvm_component_utils(i2c_master_stat_monitor)

    i2c_master_sequence_item item_1;
    uvm_analysis_port #(i2c_master_sequence_item) mon_port_1;
    
    i2c_master_agent_config    mon2_confg;
    virtual i2c_master_if      vif;

    extern function new(string name = "i2c_master_stat_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass :i2c_master_stat_monitor

function i2c_master_stat_monitor::new(string name = "i2c_master_stat_monitor", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_stat_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db #(i2c_master_agent_config)::get(this, "", "master_config", mon2_confg))
        `uvm_fatal(get_full_name(),"Cannot get I2C Master Agent Config from configuration database!")

    item_1 = i2c_master_sequence_item::type_id::create("item_1");

    mon_port_1 = new("mon_port_1", this);
endfunction :build_phase

function void i2c_master_stat_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = mon2_confg.vif_confg;
endfunction :connect_phase

task i2c_master_stat_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin            
        @(posedge vif.clk);
        item_1.state_t = vif.state;
        `uvm_info("STATE_COV_ITEM", "the packet while covering the state :", UVM_NONE)
        //item_1.print();
        mon_port_1.write(item_1);
    end
endtask :run_phase

`endif 