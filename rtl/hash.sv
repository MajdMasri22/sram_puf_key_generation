module hash #(parameter SIZE = 256) (
    input [SIZE-1:0] d_in,
    output logic [31:0] key
);
    integer i;
    always_comb begin
        key = 0;
        for (i = 0; i < SIZE; i = i + 1) begin
             key = (key << 1) ^ d_in[i];
        end
    end

endmodule

