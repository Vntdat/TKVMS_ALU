module shift_left (
	input [3:0] a,
	input [3:0] b,
	output [3:0] out
);

	wire [3:0] stage1, stage2;
	wire [1:0] shift;
	
	assign shift = b[1:0];
	
	//shift 2 bit
	assign stage1 = shift[1] ? {a[1:0], 2'b00} : a;
	//shift 1 bit
	assign stage2 = shift[0] ? {stage1[2:0], 1'b0} : stage1;
	//output
	assign out = (b > 3) ? 4'b0000 : stage2;
	
endmodule 