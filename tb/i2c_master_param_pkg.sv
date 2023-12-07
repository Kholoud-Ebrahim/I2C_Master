/*###################################################################*\
##              Package Name: i2c_master_param_pkg                   ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_PARAM_PKG_SV
`define I2C_MASTER_PARAM_PKG_SV

package i2c_master_param_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    parameter PERIOD = 10;
endpackage :i2c_master_param_pkg

`endif