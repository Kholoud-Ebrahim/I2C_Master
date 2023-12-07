/*###################################################################*\
##              Class Name: i2c_master_sequence_item                 ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_SEQUENCE_ITEM_SVH
`define I2C_MASTER_SEQUENCE_ITEM_SVH

class i2c_master_sequence_item extends uvm_sequence_item;
    rand bit rst;
    bit start;
    rand bit [6:0] address;
    rand bit rd_wr;
    rand bit [7:0] din;
    bit stop;
    bit [7:0] dout;
    rand bit SDA;
    bit SCL;
    rand bit [6:0] address_check;
    rand bit [7:0] data_check;

    typedef enum bit[3:0]{IDLE, START, ADDR , ADDR_REG, WACK, SACK , WRITE_DATA, WRITE_DATA_REG, WSTOP_1, READ_DATA, READ_DATA_1, READ_DATA_2, READ_DATA_REG, WSTOP_2, STOP} state_type;
    state_type   state_t;

    constraint rst_C   {rst   dist {0:=1, 1:=60}; }
    constraint rd_wr_C {rd_wr dist {0:=50, 1:=50};}

    `uvm_object_utils_begin(i2c_master_sequence_item)
        `uvm_field_int(rst          , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(start        , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(address      , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(address_check, UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(rd_wr        , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(din          , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(data_check   , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(stop         , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(dout         , UVM_DEFAULT | UVM_HEX)
        `uvm_field_int(SDA          , UVM_DEFAULT | UVM_BIN)
        `uvm_field_int(SCL          , UVM_DEFAULT | UVM_BIN)
        `uvm_field_enum(state_type, state_t, UVM_DEFAULT)
    `uvm_object_utils_end

    extern function new(string name = "i2c_master_sequence_item");
endclass :i2c_master_sequence_item

function i2c_master_sequence_item::new(string name = "i2c_master_sequence_item");
    super.new(name);
endfunction :new

`endif