module ecc_tb_key_gen();
    parameter SIZE = 256;

    logic [SIZE-1:0] raw_res;        
    logic [SIZE-1:0] helper_data;    
    logic [SIZE-1:0] noisy_raw_res; 
    wire [SIZE-1:0] stable_res;   
    logic [SIZE-1:0] recovered_res;

    integer i, j, bit_errors, seed;
    real ber;
    logic correction_success;
    wire [31:0] crypt_key;

    key_gen #(SIZE) DUT (
        .helper_data(helper_data),
        .crypt_key(crypt_key)
    );

    assign raw_res = DUT.raw_res;
    assign stable_res = DUT.stable_res;

    initial begin
        helper_data = 256'h2468ace2468ace2468ace2468ace2468ace2468ace2468ace2468ace2468ace2;

        for (j = 0; j < 10; j = j + 1) begin
            #10;
            seed = j + 1;
            $srandom(seed);

            noisy_raw_res = raw_res;

            for (i = 0; i < SIZE; i = i + 1) begin
                if ($urandom % 100 < 5) begin
                    noisy_raw_res[i] = ~noisy_raw_res[i];
                end
            end

            recovered_res = stable_res ^ helper_data;

            correction_success = (recovered_res === raw_res);

            bit_errors = 0;
            for (i = 0; i < SIZE; i = i + 1) begin
                if (noisy_raw_res[i] !== raw_res[i]) begin
                    bit_errors = bit_errors + 1;
                end
            end

            ber = bit_errors * 100.0 / SIZE;

            $display("Run %0d:", j);
            $display("  BER = %0.2f%% (%0d bit errors)", ber, bit_errors);
            $display("  raw_res         = %b", raw_res);
            $display("  noisy_raw_res   = %b", noisy_raw_res);
            $display("  stable_res      = %b", stable_res);
            $display("  recovered_res   = %b", recovered_res);
            if (correction_success) begin
                $display("  Error correction SUCCESS.");
            end else begin
                $display("  Error correction FAILURE.");
            end
        end

        $finish;
    end
endmodule
