`timescale 1ns / 1ps

module tb_processor;
    
    reg clk, nrst;
    wire [31:0] inst;
    wire [63:0] rdata;
    wire wr_en;
    wire [63:0] wdata;
    wire [31:0] pc, addr;
    wire [7:0] wmask;
    
    processor i_processor (
        .clk(clk),
        .nrst(nrst),
        .inst(inst),
        .rdata(rdata),
        .wr_en(wr_en),
        .wdata(wdata),
        .pc(pc),
        .addr(addr),
        .wmask(wmask)
    );
    
    mem_prog i_mem_prog (
        .addr(pc[31:2]),
        .rdata(inst)
    );
    
    mem_model i_mem_model (
        .clk(clk),
        .addr(addr[31:3]),
        .rdata(rdata),
        .wr_en(wr_en),
        .wdata(wdata),
        .wmask(wmask)
    );
    
    always begin #50; clk <= ~clk; end
    
    initial begin
    clk = 0;
    nrst = 0;
    #100;
    nrst = 1;
    #1500;
    $finish;
    end
    
    
endmodule
