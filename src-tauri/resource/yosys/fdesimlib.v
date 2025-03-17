module LUT2 (O,ADR0, ADR1);

  parameter INIT = 4'h0;

  output O;
  input ADR0, ADR1;
  assign O = INIT >> {ADR1,ADR0};

endmodule


module LUT3 (O, ADR0, ADR1, ADR2);

  parameter INIT = 8'h00;

  output O;
  input ADR0, ADR1, ADR2;
  assign O = INIT >> {ADR2,ADR1,ADR0};

endmodule



module LUT4 (O, ADR0, ADR1, ADR2, ADR3);

  parameter INIT = 16'h0000;

  output O;
  input ADR0, ADR1, ADR2, ADR3;

  assign O = INIT >> {ADR3,ADR2,ADR1,ADR0};

endmodule




module LUT5 (O,ADR0, ADR1, ADR2, ADR3, ADR4);

  parameter INIT =32'h00000000;

  input ADR0, ADR1, ADR2, ADR3, ADR4;

  output O;

  assign O = INIT >> {ADR4,ADR3,ADR2,ADR1,ADR0};

endmodule



module DFFHQ(Q,CK,D);
    output Q;
    input CK,D;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        Q <= D;
    end
endmodule


module DFFRHQ(Q,CK,RN,D);
    output Q;
    input CK,RN,D;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK or negedge RN)
    begin
        if ( RN == 0 )
        	Q <= 0;
        else
        	Q <= D;
    end
endmodule

module DFFSHQ(Q,CK,SN,D);
    output Q;
    input CK,SN,D;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK or negedge SN)
    begin
        if ( SN == 0 )
        	Q <= 1;
        else
        	Q <= D;
    end
endmodule

module DFFNRHQ(Q,CKN,RN,D);
    output Q;
    input CKN,RN,D;
    reg Q;
    initial Q = 1'b0;
    always @(negedge CKN or negedge RN)
    begin
        if ( RN == 0 )
        	Q <= 0;
        else
        	Q <= D;
    end
endmodule

module DFFNSHQ(Q,CKN,SN,D);
    output Q;
    input CKN,SN,D;
    reg Q;
    initial Q = 1'b0;
    always @(negedge CKN or negedge SN)
    begin
        if ( SN == 0 )
        	Q <= 1;
        else
        	Q <= D;
    end
endmodule

module DFFNHQ(Q,CKN,D);
    output Q;
    input CKN,D;
    reg Q;
    initial Q = 1'b0;
    always @(negedge CKN)
    begin
        Q <= D;
    end
endmodule

module EDFFHQ(Q,CK,D,E);
    output Q;
    input CK,D,E;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        if ( E )
            Q <= D;
    end
endmodule

module EDFFTRHQ(Q,CK,D,E,RN);
    output Q;
    input CK,D,E,RN;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        if(!RN)
            Q <= 0;
        else
            if(E)
                Q <= D;
    end
endmodule

module EDFFTSHQ(Q,CK,D,E,SN);
    output Q;
    input CK,D,E,SN;
    reg Q;
    initial Q = 1'b0;
    always @(posedge CK)
    begin
        if(!SN)
            Q <= 1;
        else
            if(E)
                Q <= D;
    end
endmodule