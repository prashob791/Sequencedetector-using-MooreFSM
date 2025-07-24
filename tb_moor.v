module tb_Sequence_Detector_Moore_FSM_Verilog;
    reg sequence_in;
    reg clock;
    reg reset;
    wire detector_out;

    Sequence_Detector_MOORE_Verilog uut (
        .sequence_in(sequence_in), 
        .clock(clock), 
        .reset(reset), 
        .detector_out(detector_out)
    );

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end 

    initial begin
        sequence_in = 0;
        reset = 1;
        #30 reset = 0;
        #40 sequence_in = 1; 
        #10 sequence_in = 0; 
        #10 sequence_in = 1; 
        #20 sequence_in = 0; 
        #20 sequence_in = 1; 
        #20 sequence_in = 0;  
    end
endmodule
