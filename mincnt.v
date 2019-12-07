module MINCNT(
    input   CLK, RST,
    input   EN, INC,
    output  reg [2:0]   QH,
    output  reg [3:0]   QL,
    output  CA
);

/* 1min */
always @(posedge CLK) begin
    if(RST)
        QL <= 4'd0;
    else if (EN=1'b1 || INC==1'b1) begin
        if(QL==4'd9)
            QL <= 4'd0;
        else
            QL <= QL + 1'b1;
    end
end

/* 10sec */
always @(posedge CLK) begin
    if(RST)
        QH <= 3'd0;
    else if ( (EN==1'b1 || INC==1'b1) && QL==4'd9) begin
        if(QH==3'd5)
            QH <= 3'd0;
        else
            QH <= QH + 1'b1;
    end
end

assign CA = (QH==3'd5 && QL==4'd9 && EN==1'b1);

endmodule