/*###################################################################*\
##              Interface Name: i2c_master_if                        ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_IF_SV
`define I2C_MASTER_IF_SV

interface i2c_master_if (input bit clk,  logic [3:0] state, logic mode, logic [2:0] count, logic [7:0] tx_reg, ref logic ack);
    logic rst;
    logic start;
    logic [6:0] address;
    logic rd_wr;
    logic [7:0] din;
    logic stop;
    logic [7:0] dout;
    logic SCL;
    wire SDA;
endinterface :i2c_master_if

`endif 