/*###################################################################*\
##              Class Name: i2c_master_agent                         ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_AGENT_SVH
`define I2C_MASTER_AGENT_SVH

class i2c_master_agent extends uvm_agent;
    `uvm_component_utils(i2c_master_agent)

    i2c_master_agent_config   mstr_config;
    uvm_active_passive_enum   is_active;
    i2c_master_sequencer      sqr;
    i2c_master_driver         drv;
    i2c_master_monitor        mon;
    i2c_master_stat_monitor   mon2;

    uvm_analysis_port #(i2c_master_sequence_item) mon2agnt_port_1;
    uvm_analysis_port #(i2c_master_sequence_item) mon2agnt_port_2;
    uvm_analysis_port #(i2c_master_sequence_item) mon2agnt_port_3;
    uvm_analysis_port #(i2c_master_sequence_item) mon2agnt_port_4;

    extern function new(string name = "i2c_master_agent", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass :i2c_master_agent

function i2c_master_agent::new(string name = "i2c_master_agent", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db #(i2c_master_agent_config)::get(this, "", "master_config", mstr_config))
        `uvm_fatal(get_full_name(),"Cannot get I2C Master Agent Config from configuration database!")
    is_active = mstr_config.is_active;

    if(is_active == UVM_ACTIVE)begin
        sqr = i2c_master_sequencer::type_id::create("sqr", this);
        drv = i2c_master_driver::type_id::create("drv", this);
    end
    mon  = i2c_master_monitor::type_id::create("mon", this);
    mon2 = i2c_master_stat_monitor::type_id::create("mon2", this);

    mon2agnt_port_1 = new("mon2agnt_port_1", this);
    mon2agnt_port_2 = new("mon2agnt_port_2", this);
    mon2agnt_port_3 = new("mon2agnt_port_3", this);
    mon2agnt_port_4 = new("mon2agnt_port_4", this);
endfunction :build_phase

function void i2c_master_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(is_active == UVM_ACTIVE)begin
        drv.seq_item_port.connect(sqr.seq_item_export);
    end
    mon2.mon_port_1.connect(this.mon2agnt_port_1);
    mon.mon_port_2.connect(this.mon2agnt_port_2);
    mon.mon_port_3.connect(this.mon2agnt_port_3);
    mon.mon_port_4.connect(this.mon2agnt_port_4);
endfunction :connect_phase

`endif