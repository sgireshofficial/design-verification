class apb_scoreboard;
apb_transaction ps;
apb_transaction ms;
mailbox msmbx;
mailbox psmbx;

covergroup apb_cov1;
cp1:coverpoint ms.paddr {bins b1={[0:200]}; bins b2={32'hffff_ffff};}
cp2:coverpoint ms.pwdata {bins b3={[0:256]};}
cp3:coverpoint ms.prdata {bins b4={[0:256]};}
cp4:coverpoint ms.psel {bins psel_1={1'b1};bins psel_0={1'b0};}
cp5:coverpoint ms.pslverr {bins pslverr_1={1'b1}; bins pslverr_0={1'b0};}
cp6:coverpoint ms.pwrite {bins write_1={1'b1}; bins write_0={1'b0};}
cp2xcp6:cross cp2,cp6;
cp3xcp6:cross cp3,cp6;
endgroup

function new(mailbox msmbx,mailbox psmbx);
   this.msmbx=msmbx;
   this.psmbx=psmbx;
   apb_cov1=new();
endfunction

task run();
   forever begin
      msmbx.get(ms);
      psmbx.get(ps);
      apb_cov1.sample();
      if(ms.pwrite==1'b0) begin
          if(ms.prdata==ps.prdata) begin
             $display("[SCO][%0t] [PASS]: [MON]prdata=%0h<=======>[PRE]prdata=%0h",$time,ms.prdata,ps.prdata);
          end
          else begin
             $display("[SCO][%0t] [FAIL]: [MON]prdata=%0h<=======>[PRE]prdata=%0h",$time,ms.prdata,ps.prdata);
          end
       end
    end
 endtask
 endclass
             


