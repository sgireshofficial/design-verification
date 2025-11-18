class apb_slverr_withoutwait_test extends apb_generator;
apb_transaction tr;
function new(mailbox gdmbx);
   super.new(gdmbx);
endfunction
task run();
 for(int i=1; i<10; i=i+1) begin
      tr=new();
     // assert(tr.randomize() with {tr.paddr=32'hffff_ffff;} else $error("randomization failed"); 
      if(i<5)tr.randomize() with {tr.pwrite==1'b1;tr.paddr==32'hffff_ffff;};
      else tr.randomize() with {tr.pwdata==32'h0;tr.pwrite==1'b0;paddr==32'hffff_ffff;};
      $display("***************************************************");
      tr.display("gen");
      gdmbx.put(tr);
     @(e1);
   end
endtask
endclass


