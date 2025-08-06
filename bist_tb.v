module bist_tb;
    reg clk, rst, start;
    wire mode, load, capture, done;
    wire [7:0] lfsr_out, misr_out;
    wire [7:0] a, b, alu_out;
    wire [2:0] op;
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 1;
        start = 0;
        #20 rst = 0;
        #10 start = 1;
        #10 start = 0;
        #200 $finish;
    end
    bist_fsm fsm (
        .clk(clk),
        .rst(rst),
        .start(start),
        .mode(mode),
        .load(load),
        .capture(capture),
        .done(done) );
    lfsr_8bit lfsr (
        .clk(clk),
        .rst(rst),
        .load(load),
        .seed(8'b10101010),
        .out(lfsr_out) );
    assign a = lfsr_out;
    assign b = 8'b00001111;
    assign op = 3'b000; 
    alu_8bit alu (
        .a(a),
        .b(b),
        .op(op),
        .result(alu_out) );
    misr_8bit misr (
        .clk(clk),
        .rst(rst),
        .capture(capture),
        .in(alu_out),
        .out(misr_out) );
endmodule
