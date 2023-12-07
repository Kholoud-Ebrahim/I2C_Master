/*###################################################################*\
##              Class Name: i2c_master_write1_test                   ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_WRITE1_TEST_SVH
`define I2C_MASTER_WRITE1_TEST_SVH

class i2c_master_write1_test extends i2c_master_base_test;
    `uvm_component_utils(i2c_master_write1_test)
    i2c_master_write1_seq   wr_seq;

    extern function new(string name = "i2c_master_write1_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass :i2c_master_write1_test

function i2c_master_write1_test::new(string name = "i2c_master_write1_test", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_write1_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr_seq = i2c_master_write1_seq::type_id::create("wr_seq");
endfunction :build_phase

task i2c_master_write1_test::run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    repeat(40) begin
        wr_seq.start(mstr_env.mstr_agnt.sqr);
    end
    #(PERIOD);
    phase.drop_objection(this);
endtask :run_phase

`endif