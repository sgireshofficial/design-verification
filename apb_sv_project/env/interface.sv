interface apb_interface(input bit pclk);
bit rst_n;
logic [31:0]paddr;
logic [31:0]pwdata;
logic pwrite;
logic psel;
logic penable;
logic [31:0]prdata;
logic pready;
logic pslverr;

clocking cb_dr@(posedge pclk);
input pclk,prdata,pready,pslverr;
output paddr,pwdata,pwrite,psel,penable;
endclocking
clocking cb_mon@(posedge pclk);
input prdata,pready,pslverr,paddr,pwdata,pwrite,psel,penable;
endclocking

property pready_check;
@(posedge pclk)$rose(psel) ##1 penable |-> ##[0:5]pready;
endproperty

assertion_check:assert property(pready_check);
endinterface
