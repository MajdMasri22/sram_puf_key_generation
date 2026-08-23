module error_correction #(parameter SIZE = 256) (
    input [SIZE-1:0] raw_res,
    input [SIZE-1:0] helper_data,
    output [SIZE-1:0] stable_res
);
    assign stable_res = raw_res ^ helper_data;
endmodule

