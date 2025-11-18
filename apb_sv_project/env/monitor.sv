class apb_monitor;
virtual apb_interface vif;
apb_transaction tr;
mailbox mpmbx;
mailbox msmbx;
function new(virtual apb_interface vif,mailbox mpmbx,mailbox msmbx);
   this.vif=vif;
   this.mpmbx=mpmbx;
   this.msmbx=msmbx;
endfunction
task run();
   if($test$plusargs("zerowaitstate"))
     zero_wait_state();
  else
     with_wait_state();
endtask
task with_wait_state();
   tr=new();
   forever begin
      @(posedge vif.pclk) begin
         if(vif.cb_mon.psel && !vif.cb_mon.penable) begin      
            @(posedge vif.pclk)
            if(vif.cb_mon.psel && vif.cb_mon.penable) begin
               wait(vif.cb_mon.pready);
               tr.pwdata=vif.cb_mon.pwdata;
               tr.pwrite=vif.cb_mon.pwrite;
               tr.paddr=vif.cb_mon.paddr;
               tr.penable=vif.cb_mon.penable;
               tr.psel=vif.cb_mon.psel;
               tr.pready=vif.cb_mon.pready;
               tr.prdata=vif.cb_mon.prdata;
               tr.pslverr=vif.cb_mon.pslverr;
               tr.display("mon");
            end
            mpmbx.put(tr);
            msmbx.put(tr);
            ->e1;
         end
      end
   end
endtask
task zero_wait_state();
   tr=new();
   forever begin
      @(posedge vif.pclk) begin
         if(vif.cb_mon.psel && !vif.cb_mon.penable) begin      
            @(posedge vif.pclk)
            if(vif.cb_mon.psel && vif.cb_mon.penable) begin
               tr.pwdata=vif.cb_mon.pwdata;
               tr.pwrite=vif.cb_mon.pwrite;
               tr.paddr=vif.cb_mon.paddr;
               tr.penable=vif.cb_mon.penable;
               tr.psel=vif.cb_mon.psel;
               tr.pready=vif.cb_mon.pready;
               tr.prdata=vif.cb_mon.prdata;
               tr.pslverr=vif.cb_mon.pslverr;
               tr.display("mon");
            end
            mpmbx.put(tr);
            msmbx.put(tr);
            ->e1;
         end
      end
   end
   endtask

endclass





