/*###################################################################*\
##              Module Name: i2c_master_top                          ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/
`timescale 1ns/100ps
import uvm_pkg::*;
import i2c_master_param_pkg::*;
import i2c_master_pkg::*;

module i2c_master_top;
    bit clk;

    i2c_master_if  mstr_if(.clk(clk), 
                           .state(mstr_dut.state),
                           .mode(mstr_dut.mode),
                           .ack(mstr_dut.ack),
                           .count(mstr_dut.count),
                           .tx_reg(mstr_dut.tx_reg)
                           );
                           
    i2c_master    mstr_dut(.clk(mstr_if.clk), 
                           .rst(mstr_if.rst), 
                           .start(mstr_if.start), 
                           .address(mstr_if.address), 
                           .rd_wr(mstr_if.rd_wr), 
                           .din(mstr_if.din), 
                           .stop(mstr_if.stop), 
                           .dout(mstr_if.dout), 
                           .SDA(mstr_if.SDA), 
                           .SCL(mstr_if.SCL)
    );

    initial begin
        uvm_config_db #(virtual i2c_master_if)::set(null, "*", "i2c_master_vif", mstr_if);
        run_test();
    end

    initial begin
        $timeformat(-9, 0, "ns", 16);
        clk = 0;
        forever begin
            #(PERIOD/2) clk = !clk;
        end
    end
endmodule :i2c_master_top