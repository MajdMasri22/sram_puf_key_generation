module sram_puf #(parameter SIZE = 256) (
    output logic [SIZE-1:0] raw_res
);

    integer i;
    integer seed;
    logic [15:0] lfsr;

    initial begin
	seed = $random;
        $srandom(seed);
        for (i = 0; i < SIZE; i = i + 1) begin
	    raw_res[i] = $random(seed) & 1;
        end

        lfsr = raw_res[15:0];

        if (lfsr == 0) begin
            lfsr = 16'h1;
        end

        for (i = 0; i < SIZE; i = i + 1) begin
            raw_res[i] = lfsr[0];
            lfsr = {lfsr[14:0], lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10]};
        end
    end
endmodule

