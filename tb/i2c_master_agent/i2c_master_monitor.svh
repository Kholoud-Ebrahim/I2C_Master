/*###################################################################*\
##              Class Name: i2c_master_monitor                       ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_MONITOR_SVH
`define I2C_MASTER_MONITOR_SVH

class i2c_master_monitor extends uvm_monitor;
    `uvm_component_utils(i2c_master_monitor)

    i2c_master_sequence_item item_2, item_3, item_4;
    uvm_analysis_port #(i2c_master_sequence_item) mon_port_2;
    uvm_analysis_port #(i2c_master_sequence_item) mon_port_3;
    uvm_analysis_port #(i2c_master_sequence_item) mon_port_4;

    i2c_master_agent_config    mon_confg;
    virtual i2c_master_if      vif;

    extern function new(string name = "i2c_master_monitor", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
endclass :i2c_master_monitor

function i2c_master_monitor::new(string name = "i2c_master_monitor", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(! uvm_config_db #(i2c_master_agent_config)::get(this, "", "master_config", mon_confg))
        `uvm_fatal(get_full_name(),"Cannot get I2C Master Agent Config from configuration database!")

    item_2 = i2c_master_sequence_item::type_id::create("item_2");
    item_3 = i2c_master_sequence_item::type_id::create("item_3");
    item_4 = i2c_master_sequence_item::type_id::create("item_4");

    mon_port_2 = new("mon_port_2", this);
    mon_port_3 = new("mon_port_3", this);
    mon_port_4 = new("mon_port_4", this);
endfunction :build_phase

function void i2c_master_monitor::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif = mon_confg.vif_confg;
endfunction :connect_phase

task i2c_master_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        fork
            begin
                @(vif.tx_reg == {vif.address,vif.rd_wr} && vif.state == 2 && vif.count == 0); //ADDR State
                item_2.address = vif.address;
                item_2.SCL = vif.SCL; 
                item_2.rd_wr   = vif.rd_wr;
                repeat(6) begin
                    @(negedge vif.SCL);
                    item_2.SDA   = vif.SDA;
                    item_2.address_check[0] = vif.SDA;
                    item_2.address_check = item_2.address_check<<1;
                end
                @(negedge vif.SCL);
                item_2.SDA   = vif.SDA;
                item_2.address_check[0] = vif.SDA;
                `uvm_info("ADDR_MATCH_ITEM", "the packet while checking the address matching :", UVM_NONE)
                item_2.print();
                mon_port_2.write(item_2);
            end
            begin
                @(vif.tx_reg == vif.din && vif.state == 6 && vif.count == 0 && vif.stop == 0); //WRITE_DATA State
                item_3.din = vif.din;
                item_3.SCL = vif.SCL; 
                repeat(7) begin
                    @(negedge vif.SCL);
                    item_3.SDA = vif.SDA;
                    item_3.data_check[0] = vif.SDA;
                    item_3.data_check = item_3.data_check<<1;
                end
                @(negedge vif.SCL);
                item_3.SDA   = vif.SDA;
                item_3.data_check[0] = vif.SDA;
                `uvm_info("DATA_MATCH_ITEM", "the packet while checking the data matching :", UVM_NONE)
                item_3.print();
                mon_port_3.write(item_3);
            end
            begin
                @(posedge vif.stop);
                item_4.stop = vif.stop;
                `uvm_info("STOP_MATCH_ITEM", "the packet while checking the stop matching :", UVM_NONE)
                item_4.print();
                mon_port_4.write(item_4);
            end
        join
    end
endtask :run_phase

`endif 