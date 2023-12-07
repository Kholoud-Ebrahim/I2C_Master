/*###################################################################*\
##              Package Name: i2c_master_test_pkg                    ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_TEST_PKG_SV
`define I2C_MASTER_TEST_PKG_SV

package i2c_master_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import i2c_master_param_pkg::*;

    `include "i2c_master_base_test.svh"
    `include "i2c_master_write1_test.svh"
    `include "i2c_master_write2_test.svh"
endpackage :i2c_master_test_pkg

`endif