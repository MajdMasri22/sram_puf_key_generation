module key_gen #(parameter SIZE = 256) (
    input [SIZE-1:0] helper_data,
    output [31:0] crypt_key
);
    wire [SIZE-1:0] raw_res;
    wire [SIZE-1:0] stable_res;

    sram_puf #(SIZE) puf(
        .raw_res(raw_res)
    );

    error_correction #(SIZE) error_cor (
        .raw_res(raw_res),
        .helper_data(helper_data),
        .stable_res(stable_res)
    );

    hash #(SIZE) h(
        .d_in(stable_res),
        .key(crypt_key)
    );

endmodule

