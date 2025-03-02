// Sequence Detector for 10110

module seq_mealy(
    input wire clk, rst,
    input wire X,
    output reg Y
);

parameter IDLE = 3'b000,
          S1 = 3'b001,
          S10 = 3'b010,
          S101 = 3'b011,
          S1011 = 3'b100,
          S10110 = 3'b101;

reg [2:0] state, nxt_state;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        state <= IDLE;
        Y = 1'b0;
    end
    else begin
        state = nxt_state;
        Y = (state == S10110) ? 1'b1 : 1'b0;
    end
end



always @(*) begin
    case (state)

        IDLE : begin
            nxt_state = (X) ? S1 : IDLE;
        end 

        S1 : begin
            nxt_state = (~X) ? S10 : S1;
        end

        S10 : begin
            nxt_state = (X) ? S101 :IDLE;
        end

        S101 : begin
            nxt_state = (X) ? S1011 : S10;
        end

        S1011 : begin
            nxt_state = (~X) ? S10110 : S10;
        end

        S10110 : begin
            nxt_state = (X) ? S101 : IDLE;
        end
        default: begin
            nxt_state = IDLE;
        end
    endcase
end

endmodule