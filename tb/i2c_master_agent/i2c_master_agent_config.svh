/*###################################################################*\
##              Class Name: i2c_master_agent_config                  ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_AGENT_CONFIG_SVH
`define I2C_MASTER_AGENT_CONFIG_SVH

class i2c_master_agent_config extends uvm_object;
    `uvm_object_utils(i2c_master_agent_config)

    virtual i2c_master_if    vif_confg;
    uvm_active_passive_enum  is_active;

    extern function new(string name = "i2c_master_agent_config");
endclass :i2c_master_agent_config

function i2c_master_agent_config::new(string name = "i2c_master_agent_config");
    super.new(name);
endfunction :new

`endif 