/*###################################################################*\
##              Package Name: i2c_master_agent_pkg                   ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_AGENT_PKG_SV
`define I2C_MASTER_AGENT_PKG_SV

package i2c_master_agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import i2c_master_param_pkg::*;

    `include "i2c_master_sequence_item.svh"
    `include "i2c_master_agent_config.svh"
    `include "i2c_master_sequencer.svh"
    `include "i2c_master_driver.svh"
    `include "i2c_master_monitor.svh"
    `include "i2c_master_stat_monitor.svh"
    `include "i2c_master_agent.svh"
endpackage :i2c_master_agent_pkg

`endif