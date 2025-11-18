class environment;
virtual apb_interface vif;
apb_transaction tr;
apb_generator gen;
apb_driver drv;
apb_monitor mon;
apb_predictor pre;
apb_scoreboard sco;
mailbox gdmbx;
mailbox mpmbx;
mailbox msmbx;
mailbox psmbx;
function new(virtual apb_interface vif);
   this.vif=vif;
endfunction
function build();
   gdmbx=new();
   mpmbx=new();
   msmbx=new();
   psmbx=new();
   gen=new(gdmbx);
   drv=new(vif,gdmbx);
   mon=new(vif,mpmbx,msmbx);
   pre=new(vif,mpmbx,psmbx);
   sco=new(msmbx,psmbx);
endfunction
task run();
   fork
      gen.run();
      drv.run();
      mon.run();
      pre.run();
      sco.run();
   join_none
endtask
endclass


   
