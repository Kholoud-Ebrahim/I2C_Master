/*###################################################################*\
##              Class Name: i2c_master_write1_seq                    ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_WRITE1_SEQ_SVH
`define I2C_MASTER_WRITE1_SEQ_SVH

class i2c_master_write1_seq extends i2c_master_base_seq;
    `uvm_object_utils(i2c_master_write1_seq)
    i2c_master_sequence_item   item;

    extern function new(string name = "i2c_master_write1_seq");
    extern task body();
endclass :i2c_master_write1_seq

function i2c_master_write1_seq::new(string name = "i2c_master_write1_seq");
    super.new(name);
endfunction :new

task i2c_master_write1_seq::body();
    item = i2c_master_sequence_item::type_id::create("item");
    start_item(item);
    base_rand_ass:assert(item.randomize() with {rd_wr == 1; address inside {[0:'h3E]}; din inside {['h80:'hFF]};});
    finish_item(item);
endtask :body

`endif