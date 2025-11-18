`include "/home/dvft0904/apb_sv_project/test/apb_write_read_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_write_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_read_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_slverr_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_write_read_withoutwait_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_write_withoutwait_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_read_withoutwait_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_slverr_withoutwait_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_reset_test.sv"
`include "/home/dvft0904/apb_sv_project/test/apb_reset_withoutwait_test.sv"

class test;
apb_write_read_test apb_wr_rd;
apb_write_test apb_wr;
apb_read_test apb_rd;
apb_slverr_test apb_sl;
apb_write_read_withoutwait_test apb_wd_rd_withoutwait;
apb_write_withoutwait_test apb_wd_withoutwait;
apb_read_withoutwait_test apb_rd_withoutwait;
apb_slverr_withoutwait_test apb_sl_withoutwait;
apb_slverr_withoutwait_test apb_sl_withoutwait;
apb_reset_test apb_rst;
apb_reset_withoutwait_test apb_rst_withoutwait;

environment env;
virtual apb_interface vif;
function new(virtual apb_interface vif);
   this.vif=vif;
endfunction
task run();
   env=new(vif);
   begin
      if($test$plusargs("apb_write_read_test"))begin
         $display("time=%0t inside APB_WRITE_READ_TEST_CASE",$time);
         env.build();
         apb_wr_rd=new(env.gdmbx);
         env.gen=apb_wr_rd;
         env.run();
   end
      if($test$plusargs("apb_write_test"))begin
         $display("time=%0t inside APB_WRITE_TEST_CASE",$time);
         env.build();
         apb_wr=new(env.gdmbx);
         env.gen=apb_wr;
         env.run();
   end
      if($test$plusargs("apb_read_test"))begin
         $display("time=%0t inside APB_READ_TEST_CASE",$time);
         env.build();
         apb_rd=new(env.gdmbx);
         env.gen=apb_rd;
         env.run();
   end
      if($test$plusargs("apb_slverr_test"))begin
         $display("time=%0t inside APB_SLVERR_TEST_CASE",$time);
         env.build();
         apb_sl=new(env.gdmbx);
         env.gen=apb_sl;
         env.run();
   end
   if($test$plusargs("apb_write_read_withoutwait_test"))begin
         $display("time=%0t inside APB_WRITE_READ_WITHOUTWAIT_TEST_CASE",$time);
         env.build();
         apb_wd_rd_withoutwait=new(env.gdmbx);
         env.gen=apb_wd_rd_withoutwait;
         env.run();
   end
   if($test$plusargs("apb_write_withoutwait_test"))begin
         $display("time=%0t inside APB_WRITE_WITHOUTWAIT_TEST_CASE",$time);
         env.build();
         apb_wd_withoutwait=new(env.gdmbx);
         env.gen=apb_wd_withoutwait;
         env.run();
   end

   if($test$plusargs("apb_read_withoutwait_test"))begin
         $display("time=%0t inside APB_READ_WITHOUTWAIT_TEST_CASE",$time);
         env.build();
         apb_rd_withoutwait=new(env.gdmbx);
         env.gen=apb_rd_withoutwait;
         env.run();
   end
   if($test$plusargs("apb_slverr_withoutwait_test"))begin
         $display("time=%0t inside APB_SLVERR_WITHOUTWAIT_TEST_CASE",$time);
         env.build();
         apb_sl_withoutwait=new(env.gdmbx);
         env.gen=apb_sl_withoutwait;
         env.run();
   end

   if($test$plusargs("apb_reset_test"))begin
         $display("time=%0t inside APB_RESET_TEST_CASE",$time);
         env.build();
         apb_rst=new(env.gdmbx);
         env.gen=apb_rst;
         fork
         #595 vif.rst_n=1'b0;
        // #799 vif.rst_n='1;
        // #800 vif.rst_n='0;
         #1800 vif.rst_n=1'b1;
         env.run();
         join_none
   end

if($test$plusargs("apb_reset_withoutwait_test"))begin
         $display("time=%0t inside APB_RESET_WITHOUTWAIT_TEST_CASE",$time);
         env.build();
         apb_rst_withoutwait=new(env.gdmbx);
         env.gen=apb_rst_withoutwait;
         fork
         #595 vif.rst_n=1'b0;
         //#799 vif.rst_n=1;
         //#800 vif.rst_n=0;
         #1800 vif.rst_n=1'b1;
         env.run();
         join_none
   end
   
end
endtask
endclass
