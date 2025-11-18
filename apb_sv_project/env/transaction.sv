class apb_transaction;
rand bit [31:0]paddr;
rand bit [31:0]pwdata;
rand bit pwrite;
bit psel;
bit penable;
bit [31:0]prdata;
bit pready;
bit pslverr;
function void display(string tag="");
   $display("[%0s][%0t] psel=%0b penable=%0b pwrite=%0b paddr=%0h pwdata=%0h pready=%0b prdata=%0h pslverr=%0b",tag,$time,psel,penable,pwrite,paddr,pwdata,pready,prdata,pslverr);
endfunction
constraint c1{soft !paddr inside {32'h0,32'h4,32'h8,32'hc};}
constraint c2{soft pwrite inside {1'b0,1'b1};}
constraint c3{soft paddr inside {32'd72,
                                 32'd74,
                                 32'd45,
                                 32'd85,
                                 32'd56,
                                 32'd89,
                                 32'd189,
                                 32'd134,
                                 32'd156,
                                 32'd123};}

endclass
