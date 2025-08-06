module dff(input clk, input rst, input d, output q);
    wire n1, n2, n3, n4, n5, n6, qn;
    nand (n1, d, clk);
    nand (n2, n1, clk);
    nand (n3, n1, qn);
    nand (n4, n2, n3);
    nand (n5, rst, n4);   // reset path
    nand (n6, rst, n3);   // reset path for qn
    nand (q, n5, qn);
    nand (qn, q, n6);
endmodule
