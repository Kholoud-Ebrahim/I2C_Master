/*###################################################################*\
##              Class Name: i2c_master_base_seq                      ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_BASE_SEQ_SVH
`define I2C_MASTER_BASE_SEQ_SVH

class i2c_master_base_seq extends uvm_sequence #(i2c_master_sequence_item);
    `uvm_object_utils(i2c_master_base_seq)
    i2c_master_sequence_item   item;

    extern function new(string name = "i2c_master_base_seq");
    extern task body();
endclass :i2c_master_base_seq

function i2c_master_base_seq::new(string name = "i2c_master_base_seq");
    super.new(name);
endfunction :new

task i2c_master_base_seq::body();
    item = i2c_master_sequence_item::type_id::create("item");
    start_item(item);
    base_rand_ass:assert(item.randomize());
    finish_item(item);
endtask :body
`endif