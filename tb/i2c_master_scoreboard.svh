/*###################################################################*\
##              Class Name: i2c_master_scoreboard                    ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_SCOREBOARD_SVH
`define I2C_MASTER_SCOREBOARD_SVH

`uvm_analysis_imp_decl(_addr)
`uvm_analysis_imp_decl(_data)
`uvm_analysis_imp_decl(_stop)

class i2c_master_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(i2c_master_scoreboard)

    uvm_analysis_imp_addr #(i2c_master_sequence_item, i2c_master_scoreboard) scb_imp_addr;
    uvm_analysis_imp_data #(i2c_master_sequence_item, i2c_master_scoreboard) scb_imp_data;
    uvm_analysis_imp_stop #(i2c_master_sequence_item, i2c_master_scoreboard) scb_imp_stop;

    extern function new(string name = "i2c_master_scoreboard", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void write_addr(i2c_master_sequence_item  item);
    extern function void write_data(i2c_master_sequence_item  item); 
    extern function void write_stop(i2c_master_sequence_item  item); 
endclass :i2c_master_scoreboard

function i2c_master_scoreboard::new(string name = "i2c_master_scoreboard", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_imp_addr = new("scb_imp_addr", this);
    scb_imp_data = new("scb_imp_data", this);
    scb_imp_stop = new("scb_imp_stop", this);
endfunction :build_phase

function void i2c_master_scoreboard::write_addr(i2c_master_sequence_item  item);
    if(item.address_check == item.address)begin
        `uvm_info("ADDR_PASS", $sformatf("Address = %7b equal Expected Address = %7b", item.address, item.address_check), UVM_NONE)        
    end
    else begin
        `uvm_error("ADDR_FAIL", $sformatf("Address = %7b not equal Expected Address = %7b", item.address, item.address_check))        
    end
endfunction :write_addr

function void i2c_master_scoreboard::write_data(i2c_master_sequence_item  item);
    if(item.data_check == item.din)begin
        `uvm_info("DATA_PASS", $sformatf("Data = %8b equal Expected Data = %8b", item.din, item.data_check), UVM_NONE)        
    end
    else begin
        `uvm_error("DATA_FAIL", $sformatf("Data = %8b not equal Expected Data = %8b", item.din, item.data_check))        
    end
endfunction :write_data

function void i2c_master_scoreboard::write_stop(i2c_master_sequence_item  item); 
    if(item.stop == 1)begin
        `uvm_info("STOP_PASS", "The stop signal has been raised", UVM_NONE)        
    end
    else begin
        `uvm_error("STOP_FAIL", "The stop signal has not been raised")        
    end
endfunction :write_stop

`endif