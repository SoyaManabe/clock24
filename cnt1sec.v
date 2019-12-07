module CNT1SEC(
    input   CLK, RST,
    output  EN1HZ,
    output  reg SIG2HZ
);

/* 50MHz counter */
reg [25:0] cnt;

always @( posedge CLK )begin
    if (RST)
        cnt <= 26'b0;
    else if  (EN1HZ)
        cnt <= 26'b0;
    else
        cnt <= cnt + 1'b1;
end

/* 1Hzenable */
assign EN1HZ = (cnt==26'd49_999_999);

/* 2Hz 50% duty */
wire cnt37499999 = (cnt==26'd37_499_999);
wire cnt24999999 = (cnt==26'd24_999_999);
wire cnt12499999 = (cnt==26'd12_499_999);

always @(posedge CLK) begin
    if(RST)
        SIG2HZ <= 1'b0;
    else if ( cnt12499999 | cnt24999999 | cnt37499999 | EN1HZ )
        SIG2HZ <= ~SIG2HZ;
end

endmodule