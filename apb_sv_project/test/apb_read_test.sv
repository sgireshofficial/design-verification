class apb_read_test extends apb_generator;
apb_transaction tr;
function new(mailbox gdmbx);
   super.new(gdmbx);
endfunction
task run();
 for(int i=1; i<11; i=i+1) begin
      tr=new();
      if(i<11)tr.randomize() with {tr.pwdata==32'h0;tr.pwrite==1'b0;};
      $display("***************************************************");
      tr.display("gen");
      gdmbx.put(tr);
     @(e1);
   end
endtask
endclass

