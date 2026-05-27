`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:
// Design Name:
// Module Name: sin_cos_rom
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//   64-point sine/cosine ROM
//
//////////////////////////////////////////////////////////////////////////////////

module multi_sin_cos_rom(
    input  logic [5:0] phase,
    output logic signed [15:0] sin_out,
    output logic signed [15:0] cos_out
);

always_comb begin
    case (phase)
        6'd0:  begin sin_out = 16'sd0;      cos_out = 16'sd32767; end
        6'd1:  begin sin_out = 16'sd3212;   cos_out = 16'sd32609; end
        6'd2:  begin sin_out = 16'sd6393;   cos_out = 16'sd32137; end
        6'd3:  begin sin_out = 16'sd9512;   cos_out = 16'sd31356; end
        6'd4:  begin sin_out = 16'sd12539;  cos_out = 16'sd30273; end
        6'd5:  begin sin_out = 16'sd15446;  cos_out = 16'sd28898; end
        6'd6:  begin sin_out = 16'sd18204;  cos_out = 16'sd27245; end
        6'd7:  begin sin_out = 16'sd20787;  cos_out = 16'sd25329; end
        6'd8:  begin sin_out = 16'sd23170;  cos_out = 16'sd23170; end
        6'd9:  begin sin_out = 16'sd25329;  cos_out = 16'sd20787; end
        6'd10: begin sin_out = 16'sd27245;  cos_out = 16'sd18204; end
        6'd11: begin sin_out = 16'sd28898;  cos_out = 16'sd15446; end
        6'd12: begin sin_out = 16'sd30273;  cos_out = 16'sd12539; end
        6'd13: begin sin_out = 16'sd31356;  cos_out = 16'sd9512;  end
        6'd14: begin sin_out = 16'sd32137;  cos_out = 16'sd6393;  end
        6'd15: begin sin_out = 16'sd32609;  cos_out = 16'sd3212;  end
        6'd16: begin sin_out = 16'sd32767;  cos_out = 16'sd0;     end
        6'd17: begin sin_out = 16'sd32609;  cos_out = -16'sd3212; end
        6'd18: begin sin_out = 16'sd32137;  cos_out = -16'sd6393; end
        6'd19: begin sin_out = 16'sd31356;  cos_out = -16'sd9512; end
        6'd20: begin sin_out = 16'sd30273;  cos_out = -16'sd12539; end
        6'd21: begin sin_out = 16'sd28898;  cos_out = -16'sd15446; end
        6'd22: begin sin_out = 16'sd27245;  cos_out = -16'sd18204; end
        6'd23: begin sin_out = 16'sd25329;  cos_out = -16'sd20787; end
        6'd24: begin sin_out = 16'sd23170;  cos_out = -16'sd23170; end
        6'd25: begin sin_out = 16'sd20787;  cos_out = -16'sd25329; end
        6'd26: begin sin_out = 16'sd18204;  cos_out = -16'sd27245; end
        6'd27: begin sin_out = 16'sd15446;  cos_out = -16'sd28898; end
        6'd28: begin sin_out = 16'sd12539;  cos_out = -16'sd30273; end
        6'd29: begin sin_out = 16'sd9512;   cos_out = -16'sd31356; end
        6'd30: begin sin_out = 16'sd6393;   cos_out = -16'sd32137; end
        6'd31: begin sin_out = 16'sd3212;   cos_out = -16'sd32609; end
        6'd32: begin sin_out = 16'sd0;      cos_out = -16'sd32767; end
        6'd33: begin sin_out = -16'sd3212;  cos_out = -16'sd32609; end
        6'd34: begin sin_out = -16'sd6393;  cos_out = -16'sd32137; end
        6'd35: begin sin_out = -16'sd9512;  cos_out = -16'sd31356; end
        6'd36: begin sin_out = -16'sd12539; cos_out = -16'sd30273; end
        6'd37: begin sin_out = -16'sd15446; cos_out = -16'sd28898; end
        6'd38: begin sin_out = -16'sd18204; cos_out = -16'sd27245; end
        6'd39: begin sin_out = -16'sd20787; cos_out = -16'sd25329; end
        6'd40: begin sin_out = -16'sd23170; cos_out = -16'sd23170; end
        6'd41: begin sin_out = -16'sd25329; cos_out = -16'sd20787; end
        6'd42: begin sin_out = -16'sd27245; cos_out = -16'sd18204; end
        6'd43: begin sin_out = -16'sd28898; cos_out = -16'sd15446; end
        6'd44: begin sin_out = -16'sd30273; cos_out = -16'sd12539; end
        6'd45: begin sin_out = -16'sd31356; cos_out = -16'sd9512;  end
        6'd46: begin sin_out = -16'sd32137; cos_out = -16'sd6393;  end
        6'd47: begin sin_out = -16'sd32609; cos_out = -16'sd3212;  end
        6'd48: begin sin_out = -16'sd32767; cos_out = 16'sd0;      end
        6'd49: begin sin_out = -16'sd32609; cos_out = 16'sd3212;   end
        6'd50: begin sin_out = -16'sd32137; cos_out = 16'sd6393;   end
        6'd51: begin sin_out = -16'sd31356; cos_out = 16'sd9512;   end
        6'd52: begin sin_out = -16'sd30273; cos_out = 16'sd12539;  end
        6'd53: begin sin_out = -16'sd28898; cos_out = 16'sd15446;  end
        6'd54: begin sin_out = -16'sd27245; cos_out = 16'sd18204;  end
        6'd55: begin sin_out = -16'sd25329; cos_out = 16'sd20787;  end
        6'd56: begin sin_out = -16'sd23170; cos_out = 16'sd23170;  end
        6'd57: begin sin_out = -16'sd20787; cos_out = 16'sd25329;  end
        6'd58: begin sin_out = -16'sd18204; cos_out = 16'sd27245;  end
        6'd59: begin sin_out = -16'sd15446; cos_out = 16'sd28898;  end
        6'd60: begin sin_out = -16'sd12539; cos_out = 16'sd30273;  end
        6'd61: begin sin_out = -16'sd9512;  cos_out = 16'sd31356;  end
        6'd62: begin sin_out = -16'sd6393;  cos_out = 16'sd32137;  end
        6'd63: begin sin_out = -16'sd3212;  cos_out = 16'sd32609;  end
        default: begin sin_out = 16'sd0; cos_out = 16'sd0; end
    endcase
end

endmodule