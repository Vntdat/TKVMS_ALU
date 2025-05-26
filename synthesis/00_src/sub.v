module sub (
	input [3:0] a,
	input [3:0] b,
	output [3:0] out,
	output Co
);

	wire [3:0] b_inv;
	
	assign b_inv = ~b;
	
	ripple_adder sub (
		.X (a),
		.Y (b_inv),
		.S (out),
		.Co (Co),
		.Cin (1'b1)
	);
	
endmodule