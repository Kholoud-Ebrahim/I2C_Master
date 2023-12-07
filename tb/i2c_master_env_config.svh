/*###################################################################*\
##              Class Name: i2c_master_env_config                    ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_ENV_CONFIG_SVH
`define I2C_MASTER_ENV_CONFIG_SVH

class i2c_master_env_config extends uvm_object;
    `uvm_object_utils(i2c_master_env_config)

    i2c_master_agent_config   mstr_agnt_config;
    uvm_active_passive_enum   is_active;
    virtual i2c_master_if     mstr_vif;
    bit                       scb_exist, cov_exist;

    extern function new(string name = "i2c_master_env_config");
endclass :i2c_master_env_config

function i2c_master_env_config::new(string name = "i2c_master_env_config");
    super.new(name);
endfunction :new

`endif