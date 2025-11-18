class apb_predictor;
virtual apb_interface vif;
apb_transaction mp;
apb_transaction ps;
mailbox mpmbx;
mailbox psmbx;
bit [32:0]mem[256];
function new(virtual apb_interface vif,mailbox mpmbx,mailbox psmbx);
   this.vif=vif;
   this.mpmbx=mpmbx;
   this.psmbx=psmbx;
endfunction
task run();
   ps=new();
   forever begin
        @(posedge vif.pclk);
      if(vif.rst_n==0) begin
        ps.prdata <=0;
        ps.pready <=1;
        for(int i=0;i<256;i++) mem[i]=i;
        @(posedge vif.pclk);
   end
   else begin
      mpmbx.get(mp);
      if(mp.pslverr) begin
         ps.pwdata=mp.pwdata;
         ps.paddr=mp.paddr;
         ps.psel=mp.psel;
         ps.penable=mp.penable;
         ps.prdata=mp.prdata;
         ps.pready=mp.pready;
         ps.pslverr=mp.pslverr;
         ps.pwrite=mp.pwrite;
         $display("[SLV ERROR]");
      end
      else begin
         if(mp.pwrite)begin
            mem[mp.paddr]=mp.pwdata;
            ps.pwdata=mp.pwdata;
            ps.paddr=mp.paddr;
            ps.psel=mp.psel;
            ps.prdata=mp.prdata;
            ps.pready=mp.pready;
            ps.pslverr=mp.pslverr;
            ps.penable=mp.penable;
            ps.pwrite=mp.pwrite;
         end
         else begin
            ps.pwdata=mp.pwdata;
            ps.paddr=mp.paddr;
            ps.psel=mp.psel;
            ps.prdata=mem[mp.paddr];
            ps.pready=mp.pready;
            ps.pslverr=mp.pslverr;
            ps.penable=mp.penable;
            ps.pwrite=mp.pwrite;
         end
      end
   psmbx.put(ps);
   ps.display("PRE");
   //->e1;
end
end
endtask
endclass


      
      
