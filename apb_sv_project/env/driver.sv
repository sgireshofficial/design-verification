class apb_driver;
apb_transaction tr;
virtual apb_interface vif;
mailbox gdmbx;
function new(virtual apb_interface vif,mailbox gdmbx);
   this.vif=vif;
   this.gdmbx=gdmbx;
endfunction
task run();
   if($test$plusargs("zerowaitstate")) begin
      $display("apb_zero_wait_state");
     zero_wait_state();
  end
  else
     with_wait_state();
endtask
task with_wait_state();
   forever begin
      gdmbx.get(tr);
      @(posedge vif.pclk) begin
         vif.cb_dr.psel<=0;
         vif.cb_dr.penable<=0;
      end
      @(posedge vif.pclk)begin
         vif.cb_dr.psel<=1;
         vif.cb_dr.penable<=0;
         vif.cb_dr.paddr<=tr.paddr;
         vif.cb_dr.pwdata<=tr.pwdata;
         vif.cb_dr.pwrite<=tr.pwrite;
         //tr.display("drv");
      end
      @(posedge vif.pclk)begin
         vif.cb_dr.penable<=1;
         tr.display("drv");
      end
      wait(vif.pready);
   end
endtask

task zero_wait_state();
   forever begin
      gdmbx.get(tr);
      @(posedge vif.pclk) begin
         vif.cb_dr.psel<=0;
         vif.cb_dr.penable<=0;
      end
      @(posedge vif.pclk)begin
         vif.cb_dr.psel<=1;
         vif.cb_dr.penable<=0;
         vif.cb_dr.paddr<=tr.paddr;
         vif.cb_dr.pwdata<=tr.pwdata;
         vif.cb_dr.pwrite<=tr.pwrite;
         //tr.display("drv");
      end
      @(posedge vif.pclk)begin
         vif.cb_dr.penable<=1;
         tr.display("drv");
      end
   end
endtask
endclass

