/*###################################################################*\
##              Class Name: i2c_master_sequencer                     ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_SEQUENCER_SVH
`define I2C_MASTER_SEQUENCER_SVH

class i2c_master_sequencer extends uvm_sequencer #(i2c_master_sequence_item);
    `uvm_component_utils(i2c_master_sequencer)

    extern function new(string name = "i2c_master_sequencer", uvm_component parent);
endclass

function i2c_master_sequencer::new(string name = "i2c_master_sequencer", uvm_component parent);
    super.new(name, parent);
endfunction :new

`endif