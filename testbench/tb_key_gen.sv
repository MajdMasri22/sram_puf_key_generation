module tb_key_gen();
    parameter SIZE = 256;
    logic [SIZE-1:0] helper_data;
    wire [SIZE-1:0] raw_res;
    wire [SIZE-1:0] stable_res;
    wire [31:0] crypt_key;

    key_gen #(SIZE) DUT (
        .helper_data(helper_data),
        .crypt_key(crypt_key)
    );

    assign raw_res = DUT.raw_res;
    assign stable_res = DUT.stable_res;

    initial begin
        helper_data = 256'h2468ace2468ace2468ace2468ace2468ace2468ace2468ace2468ace2468ace2;
	#10;
	$display("raw response   : %h", raw_res);
        $display("stable response: %h", stable_res);
        $display("generated key  : %h", crypt_key);
        #20;
        $finish;
    end

    initial begin
	$monitor("at time %0t: generated key = %0h", $time, crypt_key);
    end
endmodule

