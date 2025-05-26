module alu (
	input clk,
	input rst_n,
	input [3:0] a,
	input [3:0] b,
	input [2:0] op,
	output reg [3:0] result,
	output reg carry
);

	wire [3:0] result_add, result_sub, result_and, result_or, result_xor, result_not, result_shift_left, result_shift_right;
	wire carry_add, carry_sub, Cin;
	assign Cin = 1'b0;
	
	assign result_and = a & b;
	assign result_or = a | b;
	assign result_xor = a ^ b;
	assign result_not = ~a;

	ripple_adder add (
		.X (a),
		.Y (b),
		.S (result_add),
		.Co (carry_add),
		.Cin (Cin)
	);
	
	sub sub (
		.a (a),
		.b (b),
		.out (result_sub),
		.Co (carry_sub)
	);
	
	shift_right shift_right (
		.a (a),
		.b (b),
		.out (result_shift_right)
	);
	
	shift_left shift_left (
		.a (a),
		.b (b),
		.out (result_shift_left)
	);
	
	
	//output
	always @(*) begin
		case (op)
			3'b000: begin result = result_add;         carry = carry_add; end
			3'b001: begin result = result_sub;         carry = ~carry_sub; end
			3'b010: begin result = result_and;         carry = 1'b0;      end
			3'b011: begin result = result_or;          carry = 1'b0;      end
			3'b100: begin result = result_xor;         carry = 1'b0;      end
			3'b101: begin result = result_not;         carry = 1'b0;      end
			3'b110: begin result = result_shift_right;  carry = 1'b0;      end
			3'b111: begin result = result_shift_left; carry = 1'b0;      end
			default: begin result = 4'b0000; carry = 1'b0; end
		endcase
	end


endmodule