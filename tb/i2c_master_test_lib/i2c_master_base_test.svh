/*###################################################################*\
##              Class Name: i2c_master_base_test                     ##
##              Project Name: i2c_master                             ##
##              Date:   7/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

`ifndef I2C_MASTER_BASE_TEST_SVH
`define I2C_MASTER_BASE_TEST_SVH

class i2c_master_base_test extends uvm_test;
    `uvm_component_utils(i2c_master_base_test)

    i2c_master_environment    mstr_env;
    i2c_master_env_config     mstr_env_confg;
    uvm_active_passive_enum   mstr_is_active;
    bit                       scb_exist_tst, cov_exist_tst;
    virtual i2c_master_if     mstr_vif;

    extern function new(string name = "i2c_master_base_test", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void end_of_elaboration_phase(uvm_phase phase);
endclass :i2c_master_base_test

function i2c_master_base_test::new(string name = "i2c_master_base_test", uvm_component parent);
    super.new(name, parent);
endfunction :new

function void i2c_master_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    mstr_env = i2c_master_environment::type_id::create("mstr_env", this);
    mstr_env_confg = i2c_master_env_config::type_id::create("mstr_env_confg");

    if(! uvm_config_db #(virtual i2c_master_if)::get(this, "", "i2c_master_vif", mstr_vif))
        `uvm_fatal(get_full_name(),"Cannot get I2C Master VIF from configuration database!")

    mstr_env_confg.mstr_vif = mstr_vif;
    mstr_is_active  = UVM_ACTIVE;
    mstr_env_confg.is_active = mstr_is_active;
    scb_exist_tst = 1;
    mstr_env_confg.scb_exist = scb_exist_tst;
    cov_exist_tst = 1;
    mstr_env_confg.cov_exist = cov_exist_tst;

    uvm_config_db #(i2c_master_env_config)::set(this, "*", "master_env_config", mstr_env_confg);
endfunction :build_phase

//Printing the heirarchy of the TB components
function void i2c_master_base_test::end_of_elaboration_phase(uvm_phase phase);	
    uvm_top.print_topology();
endfunction :end_of_elaboration_phase

`endif