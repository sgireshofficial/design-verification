module apb_top;
import apb_pkg::*;
bit pclk;
apb_interface vif(pclk);
apb_slave dut(.dif(vif));
test ts;
always #5 pclk=~pclk;
initial begin
   pclk=0;
   vif.rst_n=0;
   #40;
   vif.rst_n=1;
end
initial begin
   ts=new(vif);
   ts.run();
   #2000;
   $finish;
end
endmodule

