/*###################################################################*\
##              Package Name: i2c_master_seq_pkg                     ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_SEQ_PKG_SV
`define I2C_MASTER_SEQ_PKG_SV

package i2c_master_seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import i2c_master_param_pkg::*;

    `include "i2c_master_sequence_item.svh"
        
    `include "i2c_master_base_seq.svh"
    `include "i2c_master_write1_seq.svh"
    `include "i2c_master_write2_seq.svh"
endpackage :i2c_master_seq_pkg

`endif