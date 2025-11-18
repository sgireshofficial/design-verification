RTL=../rtl/apb_slave_design.sv
INF=../env/interface.sv
PKG=../test/package.sv
TOP=../top/top.sv
INC= +incdir+../test/ +incdir+../env/ +incdir+../top/
TEST=../test/test.sv

COM=vcs -full64 -sverilog ${COVER} -kdb -debug_access+all ${RTL} ${INF} ${PKG} ${TOP} ${INC}
compile:
	     ${COM}

COVER=-cm line+cond+fsm+tgl+branch+assert

RUN=vcs -R -full64 -sverilog ${COVER} -kdb -debug_access+all +ntb_random_seed_automatic ${RTL} ${INF} ${PKG} ${TOP} ${INC}
run:
	     ${RUN}

RUN1=vcs -R -full64 -sverilog -kdb -debug_access+all +ntb_random_seed_automatic +zerowaitstate ${RTL} ${INF} ${PKG} ${TOP} ${INC}


tc1:
	$(RUN) -cm_dir $(TEST1)_coverage.vdb +$(TEST1) -l $(TEST1).log; urg -dir $(TEST1)_coverage.vdb -report $(TEST1)_report
TEST1=apb_write_read_test

tc2:
	$(RUN) -cm_dir $(TEST2)_coverage.vdb +$(TEST2) -l $(TEST2).log; urg -dir $(TEST2)_coverage.vdb -report $(TEST2)_report
TEST2=apb_write_test

tc3:
	$(RUN) -cm_dir $(TEST3)_coverage.vdb +$(TEST3) -l $(TEST3).log; urg -dir $(TEST3)_coverage.vdb -report $(TEST3)_report
TEST3=apb_read_test

tc4:
	$(RUN) -cm_dir $(TEST4)_coverage.vdb +$(TEST4) -l $(TEST4).log; urg -dir $(TEST4)_coverage.vdb -report $(TEST4)_report
TEST4=apb_slverr_test

tc5:
	$(RUN) -cm_dir $(TEST5)_coverage.vdb +$(TEST5) -l $(TEST5).log; urg -dir $(TEST5)_coverage.vdb -report $(TEST5)_report
TEST5=apb_reset_test

tc6:
	$(RUN1) -cm_dir $(TEST6)_coverage.vdb +$(TEST6) -l $(TEST6).log; urg -dir $(TEST6)_coverage.vdb -report $(TEST6)_report
TEST6=apb_write_read_withoutwait_test

tc7:
	$(RUN1) -cm_dir $(TEST7)_coverage.vdb +$(TEST7) -l $(TEST7).log; urg -dir $(TEST7)_coverage.vdb -report $(TEST7)_report
TEST7=apb_write_withoutwait_test

tc8:
	$(RUN1) -cm_dir $(TEST8)_coverage.vdb +$(TEST8) -l $(TEST8).log; urg -dir $(TEST8)_coverage.vdb -report $(TEST8)_report
TEST8=apb_read_withoutwait_test

tc9:
	$(RUN1) -cm_dir $(TEST9)_coverage.vdb +$(TEST9) -l $(TEST9).log; urg -dir $(TEST9)_coverage.vdb -report $(TEST9)_report
TEST9=apb_slverr_withoutwait_test

tc10:
	$(RUN1) -cm_dir $(TEST10)_coverage.vdb +$(TEST10) -l $(TEST10).log; urg -dir $(TEST10)_coverage.vdb -report $(TEST10)_report
TEST10=apb_reset_withoutwait_test

tc: tc1 tc2 tc3 tc4 tc5 tc6 tc7 tc8 tc9 tc10

merge:
	urg -dir $(TEST1)_coverage.vdb $(TEST2)_coverage.vdb $(TEST3)_coverage.vdb $(TEST4)_coverage.vdb $(TEST5)_coverage.vdb $(TEST6)_coverage.vdb $(TEST7)_coverage.vdb $(TEST8)_coverage.vdb $(TEST9)_coverage.vdb $(TEST10)_coverage.vdb -format both -report merged_report
report:
	firefox merged_report/dashboard.html&

final=tc merge report

SIM=./simv -no_save -gui=dve &
sim: 
	$(SIM)
     


clean:
	rm -rf csrc simv.daidir ucli.key sim *.vpd *.vcd *.log *.dump *.vdb *_report *_test nova*v*

