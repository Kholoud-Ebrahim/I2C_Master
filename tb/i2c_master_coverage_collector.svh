/*###################################################################*\
##              Class Name: i2c_master_coverage_collector            ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_COVERAGE_COLLECTOR_SVH
`define I2C_MASTER_COVERAGE_COLLECTOR_SVH


`uvm_analysis_imp_decl(_cov_stat)
`uvm_analysis_imp_decl(_cov_addr)
`uvm_analysis_imp_decl(_cov_data)
`uvm_analysis_imp_decl(_cov_stop)

class i2c_master_coverage_collector extends uvm_component;
    `uvm_component_utils(i2c_master_coverage_collector)

    i2c_master_sequence_item  item_1, item_2, item_3, item_4;
    enum bit[3:0]{IDLE, START, ADDR , ADDR_REG, WACK, SACK , WRITE_DATA, WRITE_DATA_REG, WSTOP_1, READ_DATA, READ_DATA_1, READ_DATA_2, READ_DATA_REG, WSTOP_2, STOP} stat;

    uvm_analysis_imp_cov_stat #(i2c_master_sequence_item, i2c_master_coverage_collector) cov_imp_stat;
    uvm_analysis_imp_cov_addr #(i2c_master_sequence_item, i2c_master_coverage_collector) cov_imp_addr;
    uvm_analysis_imp_cov_data #(i2c_master_sequence_item, i2c_master_coverage_collector) cov_imp_data;
    uvm_analysis_imp_cov_stop #(i2c_master_sequence_item, i2c_master_coverage_collector) cov_imp_stop;

    covergroup COVER_STATES;
        option.per_instance = 1;
            
        coverpoint item_1.state_t {
            bins IDLE_to_IDLE                 = (IDLE => IDLE);
            bins IDLE_to_START                = (IDLE => START);
            bins START_to_ADDR                = (START => ADDR); 
            bins ADDR_to_ADDR_REG             = (ADDR => ADDR_REG);
            bins ADDR_REG_to_ADDR             = (ADDR_REG => ADDR);
            bins ADDR_REG_to_WACK             = (ADDR_REG => WACK);
            bins WACK_to_SACK                 = (WACK => SACK);
            bins SACK_to_WRITE_DATA           = (SACK => WRITE_DATA);
            bins WRITE_DATA_to_WRITE_DATA_REG = (WRITE_DATA => WRITE_DATA_REG);
            bins WRITE_DATA_to_WSTOP_2        = (WRITE_DATA => WSTOP_2);
            bins WRITE_DATA_REG_to_WRITE_DATA = (WRITE_DATA_REG => WRITE_DATA);
            bins WRITE_DATA_REG_to_WACK       = (WRITE_DATA_REG => WACK);
            bins WSTOP_2_to_STOP              = (WSTOP_2 => STOP);
            bins STOP_to_IDLE                 = (STOP => IDLE);          
        }
    endgroup :COVER_STATES

    covergroup COVER_ADDRESS;
        option.per_instance = 1;

        coverpoint item_2.address {
            bins addr_lo_1 = {['h00:'h1F]};
            bins addr_lo_2 = {['h20:'h3E]};
            bins addr_hi_1 = {['h3F:'h5D]};
            bins addr_hi_2 = {['h5E:'h7F]};
            bins misc_addr = default;
        }
    endgroup :COVER_ADDRESS

    covergroup COVER_DATA;
        option.per_instance = 1;

        coverpoint item_3.din {
            bins data_lo_1 = {['h00:'h3F]};
            bins data_lo_2 = {['h40:'h7F]};
            bins data_hi_1 = {['h80:'hBF]};
            bins data_hi_2 = {['hC0:'hFF]};
            bins misc_data = default;
        }
    endgroup :COVER_DATA

    covergroup COVER_STOP;
        option.per_instance = 1;

        coverpoint item_4.stop {
            bins stop_hi   = {1};
            bins misc_stop = default;
        }
    endgroup :COVER_STOP

    extern function new(string name = "i2c_master_coverage_collector", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void write_cov_stat(i2c_master_sequence_item  item);
    extern function void write_cov_addr(i2c_master_sequence_item  item);
    extern function void write_cov_data(i2c_master_sequence_item  item);
    extern function void write_cov_stop(i2c_master_sequence_item  item);

endclass :i2c_master_coverage_collector

function i2c_master_coverage_collector::new(string name = "i2c_master_coverage_collector", uvm_component parent);
    super.new(name, parent);
    COVER_STATES  = new();
    COVER_ADDRESS = new();
    COVER_DATA    = new();
    COVER_STOP    = new();
endfunction :new

function void i2c_master_coverage_collector::build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_imp_stat = new("cov_imp_stat", this);
    cov_imp_addr = new("cov_imp_addr", this);
    cov_imp_data = new("cov_imp_data", this);
    cov_imp_stop = new("cov_imp_stop", this);
endfunction :build_phase

function void i2c_master_coverage_collector::write_cov_stat(i2c_master_sequence_item  item);
    item_1 = i2c_master_sequence_item::type_id::create("item_1");
    item_1  = item;
    COVER_STATES.sample();
endfunction :write_cov_stat

function void i2c_master_coverage_collector::write_cov_addr(i2c_master_sequence_item  item);
    item_2 = i2c_master_sequence_item::type_id::create("item_2");
    item_2 = item;
    COVER_ADDRESS.sample();
endfunction :write_cov_addr

function void i2c_master_coverage_collector::write_cov_data(i2c_master_sequence_item  item);
    item_3 = i2c_master_sequence_item::type_id::create("item_3");
    item_3 = item;
    COVER_DATA.sample();
endfunction :write_cov_data

function void i2c_master_coverage_collector::write_cov_stop(i2c_master_sequence_item  item);
    item_4 = i2c_master_sequence_item::type_id::create("item_4");
    item_4 = item;
    COVER_STOP.sample();
endfunction :write_cov_stop

`endif