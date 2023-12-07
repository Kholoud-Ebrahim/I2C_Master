/*###################################################################*\
##              Class Name: i2c_master_driver                        ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_DRIVER_SVH
`define I2C_MASTER_DRIVER_SVH

class i2c_master_driver extends uvm_driver #(i2c_master_sequence_item);
    `uvm_component_utils(i2c_master_driver)

    i2c_master_agent_config    drv_confg;
    virtual i2c_master_if      vif;
    i2c_master_sequence_item   drv_item;

    extern function new(string name = "i2c_master_driver", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task initialize_dut();
    extern task drive(input i2c_master_sequence_item item);
endclass :i2c_master_driver

function i2c_master_driver::new(string name = "i2c_master_driver", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db #(i2c_master_agent_config)::get(this, "", "master_config", drv_confg))
        `uvm_fatal(get_full_name(),"Cannot get I2C Master Agent Config from configuration database!")
endfunction :build_phase

function void i2c_master_driver::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = drv_confg.vif_confg;
endfunction :connect_phase

task i2c_master_driver::run_phase(uvm_phase phase);
    super.run_phase(phase);
    initialize_dut();
    forever begin
        seq_item_port.get_next_item(drv_item);
        drive(drv_item);
        seq_item_port.item_done();
    end
endtask :run_phase

task i2c_master_driver::initialize_dut();
    vif.rst = 1'b1;
    vif.start = 1'b0;
    vif.address = 7'b0;
    vif.rd_wr = 1'b0;
    vif.din = 8'b0;
    vif.stop = 1'b0;
    @(negedge vif.clk);
    #(PERIOD/2.0 - PERIOD/20.0);
    vif.rst = 1'b0;
endtask :initialize_dut

task i2c_master_driver::drive(input i2c_master_sequence_item item);
    wait(!(vif.rst));
    @(negedge vif.clk);
    #(PERIOD/2.0 - PERIOD/20.0);
    vif.start   <= 1'b1;
    vif.address <= item.address;
    vif.rd_wr   <= item.rd_wr;

    @(negedge vif.clk);
    if(vif.rd_wr == 1) begin // write
        vif.din     <= item.din;

        wait(vif.count == 3'b111);
        @(negedge vif.SCL);
        vif.ack     = 1'b1;
    end // write

    repeat(3) @(negedge vif.SCL);
    wait(vif.count == 3'b111);
    @(negedge vif.SCL);
    vif.stop    <= 1'b1;

    wait(vif.state == 14); //stop state
    vif.stop    <= 1'b0;

    wait(vif.state == 0);
endtask :drive

`endif