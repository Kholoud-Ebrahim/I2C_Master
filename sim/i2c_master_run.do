# Clean Work Library
if [file exists "work"] {vdel -all}
vlib work

# Compile RTL and TB files
vlog  -f   i2c_master_rtl.f
vlog  -f   i2c_master_tb.f

# Optimizing Design with vopt
vopt i2c_master_top -o top_opt -debugdb  +acc +cover=sbecft+i2c_master(rtl).
# "+cover=sbecft". s = Statement, b = Branch, c = Condition, e = Expression, f = FSM, t = toggle #

# Simulation of a Test
#********************************** 1. Write TEST 1 ***********************************#
transcript file log/write1_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=i2c_master_write1_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
#add wave sim:/i2c_master_top/mstr_dut/clk
#add wave sim:/i2c_master_top/mstr_dut/rst
#add wave sim:/i2c_master_top/mstr_dut/start
#add wave sim:/i2c_master_top/mstr_dut/address
#add wave sim:/i2c_master_top/mstr_dut/rd_wr
#add wave sim:/i2c_master_top/mstr_dut/din
#add wave sim:/i2c_master_top/mstr_dut/stop
#add wave sim:/i2c_master_top/mstr_dut/SCL
#add wave sim:/i2c_master_top/mstr_dut/SDA
#add wave sim:/i2c_master_top/mstr_dut/state
#add wave sim:/i2c_master_top/mstr_dut/ack
#add wave sim:/i2c_master_top/mstr_dut/tx_reg
#add wave sim:/i2c_master_top/mstr_dut/count
run -all
coverage attribute -name TESTNAME -value write_test_1
coverage save coverage/write_test_1.ucdb

#********************************** 2. Write TEST 2 ***********************************#
transcript file log/write2_test_log.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=i2c_master_write2_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value write_test_2
coverage save coverage/write_test_2.ucdb

# save the coverage in text files
vcover merge  coverage/test_all.ucdb \
              coverage/write_test_1.ucdb\
              coverage/write_test_2.ucdb

vcover report coverage/test_all.ucdb  -cvg -details -output coverage/fun_coverage.txt
vcover report coverage/test_all.ucdb  -details -output coverage/code_coverage.txt
vcover report coverage/test_all.ucdb  -details -assert  -output coverage/assertions.txt