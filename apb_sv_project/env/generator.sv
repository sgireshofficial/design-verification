class apb_generator;
apb_transaction tr;
mailbox gdmbx;
function new(mailbox gdmbx);
   this.gdmbx=gdmbx;
endfunction
virtual task run();
  for(int i=1; i<21; i=i+1) begin
      tr=new();
      if(i<11)tr.randomize() with {tr.pwrite==1'b1;};
      else tr.randomize() with {tr.pwdata==32'h0;tr.pwrite==1'b0;};
      $display("***************************************************");
      tr.display("gen");
      gdmbx.put(tr);
     @(e1);
   end
endtask
endclass
