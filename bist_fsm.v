module bist_fsm (
    input clk,
    input rst,
    input start,
    output mode,     // 0: normal, 1: test
    output load,     // 1: load seed into LFSR
    output capture,  // 1: capture output in MISR
    output done );      // 1: testing done
    wire q0, q1;
    wire d0, d1;
    wire nq0, nq1;
    // 00: IDLE
    // 01: LOAD
    // 10: TEST
    // 11: DONE
    not (nq0, q0);
    not (nq1, q1);
    and (d0, nq1, start);              // IDLE to LOAD when start = 1
    or  (d1, q0, q1);                  // move to next states
    dff dff0 (.clk(clk), .rst(rst), .d(d0), .q(q0));
    dff dff1 (.clk(clk), .rst(rst), .d(d1), .q(q1));
    buf (mode, q1);
    // load = ~q0 & q1  => LOAD state
    wire nq0_q1;
    and (nq0_q1, nq0, q1);
    buf (load, nq0_q1);
    // capture = q0 & q1 => TEST state
    wire q0_q1;
    and (q0_q1, q0, q1);
    buf (capture, q0_q1);
    // done = q0 & ~q1 => DONE state
    wire q0_nq1;
    and (q0_nq1, q0, nq1);
    buf (done, q0_nq1);
endmodule
