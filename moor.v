module Sequence_Detector_MOORE_Verilog(sequence_in, clock, reset, detector_out);
    input clock; 
    input reset; 
    input sequence_in; 
    output reg detector_out; 

    parameter Zero = 3'b000, One = 3'b001, OneZero = 3'b011, OneZeroOne = 3'b010, OneZeroOneOne = 3'b110;
    reg [2:0] current_state, next_state;

    always @(posedge clock or posedge reset) begin
        if (reset) 
            current_state <= Zero;
        else
            current_state <= next_state;
    end 

    always @(current_state, sequence_in) begin
        case (current_state) 
            Zero: next_state = (sequence_in == 1) ? One : Zero;
            One: next_state = (sequence_in == 0) ? OneZero : One;
            OneZero: next_state = (sequence_in == 1) ? OneZeroOne : Zero;
            OneZeroOne: next_state = (sequence_in == 1) ? OneZeroOneOne : OneZero;
            OneZeroOneOne: next_state = (sequence_in == 0) ? OneZero : One;
            default: next_state = Zero;
        endcase
    end

    always @(current_state) begin 
        case (current_state) 
            Zero, One, OneZero, OneZeroOne: detector_out = 0;
            OneZeroOneOne: detector_out = 1;
            default: detector_out = 0;
        endcase
    end 
endmodule
