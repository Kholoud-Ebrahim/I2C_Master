/*###################################################################*\
##              Class Name: i2c_master_environment                   ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_ENVIRONMENT_SVH
`define I2C_MASTER_ENVIRONMENT_SVH

class i2c_master_environment extends uvm_env;
    `uvm_component_utils(i2c_master_environment)

    i2c_master_agent_config   mstr_agnt_config;
    i2c_master_env_config     mstr_env_config;

    i2c_master_agent                mstr_agnt;
    i2c_master_scoreboard           mstr_scb;
    i2c_master_coverage_collector   mstr_cov;

    extern function new(string name = "i2c_master_environment", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass :i2c_master_environment

function i2c_master_environment::new(string name = "i2c_master_environment", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_environment::build_phase(uvm_phase phase);
    super.build_phase(phase);
    mstr_agnt = i2c_master_agent::type_id::create("mstr_agnt", this);
    mstr_scb  = i2c_master_scoreboard::type_id::create("mstr_scb", this);
    mstr_cov  = i2c_master_coverage_collector::type_id::create("mstr_cov", this);

    if(! uvm_config_db #(i2c_master_env_config)::get(this, "", "master_env_config", mstr_env_config))
        `uvm_fatal(get_full_name(),"Cannot get I2C Master Env Config from configuration database!")

    mstr_agnt_config = i2c_master_agent_config::type_id::create("mstr_agnt_config");
    mstr_agnt_config.vif_confg = mstr_env_config.mstr_vif;
    mstr_agnt_config.is_active = mstr_env_config.is_active;
    
    uvm_config_db #(i2c_master_agent_config)::set(this, "*", "master_config",mstr_agnt_config);
endfunction :build_phase

function void i2c_master_environment::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if(mstr_env_config.scb_exist == 1) begin
        mstr_agnt.mon2agnt_port_2.connect(mstr_scb.scb_imp_addr);
        mstr_agnt.mon2agnt_port_3.connect(mstr_scb.scb_imp_data);
        mstr_agnt.mon2agnt_port_4.connect(mstr_scb.scb_imp_stop);
    end

    if(mstr_env_config.cov_exist == 1) begin
        mstr_agnt.mon2agnt_port_1.connect(mstr_cov.cov_imp_stat);
        mstr_agnt.mon2agnt_port_2.connect(mstr_cov.cov_imp_addr);
        mstr_agnt.mon2agnt_port_3.connect(mstr_cov.cov_imp_data);
        mstr_agnt.mon2agnt_port_4.connect(mstr_cov.cov_imp_stop);
    end
    
endfunction :connect_phase

`endif 