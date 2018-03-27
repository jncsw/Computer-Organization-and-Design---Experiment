module divide_led(
input sys_clk, //����������ʱ��
output wire [1:0] led
);
parameter HW=8; //�ߵ�ƽ���� �ɸ�
parameter LW=8; //�͵�ƽ���� �ɸģ� ʵ�������Ƶ
reg sys_clk_out; //��Ƶ����ʱ�ӣ� ��ʼֵĬ�� 0��
reg [9:0] count1;
reg state;
always@(posedge sys_clk )
begin
case(state)
0: if(count1<LW-1) //����ֵС�ڷ�Ƶʱ�ӵ͵�ƽ����ʱ
begin
count1<=count1+1'd1; //ά�� sys_clk_out ��ʼֵ 0
state<=0;
end
else //������͵�ƽ����ʱ
begin
count1<=0;
sys_clk_out<=1'b1; //�� sys_clk_out ��Ϊ 1�� ����ת�� state1
state<=1;
end
1: if(count1<HW-1) //����ֵС�ڷ�Ƶʱ�Ӹߵ�ƽ����ʱ
begin
count1<=count1+1'd1; //ά�� sys_clk_out ��ǰ״̬ 1
state<=1;
end
else //������ߵ�ƽ����ʱ
begin
count1<=0;
sys_clk_out<=1'b0; //�� sys_clk_out ��Ϊ 0�� ����ת�� state0
state<=0;
end
default:state<=0;
endcase
end
assign led[0]=sys_clk; //������ led �Ʒֱ����ӵ����������ź���
assign led[1]=sys_clk_out;
endmodule