/*###################################################################*\
##              Module Name: i2c_master                              ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

module i2c_master(clk, rst, start, address, rd_wr, din, stop, dout, SDA, SCL);
    input clk, rst, start;
    input [6:0] address;
    input rd_wr;
    input [7:0] din;
    input stop;
    output reg [7:0] dout;
    inout SDA;
    output SCL;

    parameter READ =0, WRITE =1;
    enum bit[3:0]{IDLE, START, ADDR , ADDR_REG, WACK, SACK , WRITE_DATA, WRITE_DATA_REG, WSTOP_1, READ_DATA, READ_DATA_1, READ_DATA_2, READ_DATA_REG, WSTOP_2, STOP} state;
    bit mode;
    logic ack;
    logic [7:0] tx_reg;
    logic [2:0] count;
    logic sda, scl;
    
    always @(posedge clk , posedge rst) begin
        if (rst) begin
            count = 0;
            state = IDLE;
            scl = 1;
            sda = 1;
        end
        else begin
            case (state) 
                IDLE : begin
                    if (start == 1'b1) 
                        state = START ;
                    else 
                        state = IDLE;
                    scl = 1;
                    sda = 1;
                end

                START : begin
                    state = ADDR;
                    sda = 0;
                    count = 0;
                    mode = rd_wr; // read or write status must be maintained by user at rd_wr pin
                    tx_reg = {address,rd_wr};
                end
        
                ADDR : begin
                    scl = 0; // falling edge by master
                    state = ADDR_REG;
                    sda = tx_reg[~count] ;
                end
      
                ADDR_REG : begin
                    scl = 1;// rising edge by master 
                    count = count +1;
                    if (count == 0) 
                        state = WACK;
                    else 
                        state = ADDR;
                end
        
                WACK : begin
                    state = SACK;
                    scl = 0; // negedge scl  
                end
              
                SACK : begin
                    scl = 1; //rising edge
                    
                    if(ack == 0) 
                        state = IDLE;
                    else begin
                        if(ack == 1 && mode == READ) begin
                            state = WSTOP_1;
                            tx_reg = 0;
                        end
                        if(ack == 1 && mode == WRITE) begin
                            state = WRITE_DATA;
                            tx_reg = din;
                        end
                    end
                end
    
                WRITE_DATA : begin
                    scl = 0; // negedge scl
                    if(count == 0 && stop == 1) begin //for stop detection
                        state = WSTOP_2;
                        sda = 0;
                    end
                    else begin
                        state = WRITE_DATA_REG;
                        sda = tx_reg[~count];
                    end
                end
  
                WRITE_DATA_REG : begin
                    scl = 1; //posedge scl
                    count = count +1;
                    if(count == 0)
                        state = WACK;
                    else 
                        state = WRITE_DATA;
                end
  
                WSTOP_1 : begin
                    scl = 0; // negedge scl
                    sda=1;	
                    if(stop == 1)begin
                        state = WSTOP_2;
                        sda = 0;
                    end
                    else 
                        state = READ_DATA;   
                end
    
                READ_DATA : begin
                    scl = 1; // posedge scl
                    tx_reg[~count] = SDA;
                    if(count == 7) 
                        state =READ_DATA_2;
                    else 
                        state = READ_DATA_1;
                end
  
                READ_DATA_1 : begin
                    scl = 0 ; // negedge scl
                    count = count +1;
                    state = READ_DATA;         
                end

                READ_DATA_2 : begin
                    scl = 0 ; // negedge scl
                    sda = 0;
                    count = 0;
                    state = READ_DATA_REG;
                end

                READ_DATA_REG : begin
                    scl = 1; // posedge scl
                    dout = tx_reg;
                    state = WSTOP_1;
                end
  
                WSTOP_2 : begin
                    scl = 1; // posedge scl
                    state = STOP;
                end
  
                STOP : begin
                    sda = 1;
                    state = IDLE;
                end
            endcase
        end
    end

    assign SDA = (sda == 0 ) ? 1'b0 : 1'b1 ;
    assign SCL = (scl == 0 ) ? 1'b0 : 1'b1 ;
endmodule :i2c_master