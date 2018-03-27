module divide_led(
input sys_clk, //试验箱脉冲时钟
output wire [1:0] led
);
parameter HW=8; //高电平数， 可改
parameter LW=8; //低电平数， 可改， 实现任意分频
reg sys_clk_out; //分频脉冲时钟， 初始值默认 0；
reg [9:0] count1;
reg state;
always@(posedge sys_clk )
begin
case(state)
0: if(count1<LW-1) //计数值小于分频时钟低电平个数时
begin
count1<=count1+1'd1; //维持 sys_clk_out 初始值 0
state<=0;
end
else //当满足低电平个数时
begin
count1<=0;
sys_clk_out<=1'b1; //将 sys_clk_out 置为 1， 并跳转到 state1
state<=1;
end
1: if(count1<HW-1) //计数值小于分频时钟高电平个数时
begin
count1<=count1+1'd1; //维持 sys_clk_out 当前状态 1
state<=1;
end
else //当满足高电平个数时
begin
count1<=0;
sys_clk_out<=1'b0; //将 sys_clk_out 置为 0， 并跳转到 state0
state<=0;
end
default:state<=0;
endcase
end
assign led[0]=sys_clk; //将两个 led 灯分别链接到两个脉冲信号上
assign led[1]=sys_clk_out;
endmodule