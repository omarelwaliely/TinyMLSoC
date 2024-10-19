volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
volatile unsigned int* TIMER_STATUS = (volatile unsigned int *) 0x43000000;
volatile unsigned int* LOAD_VALUE = (volatile unsigned int *) 0x43000004;

volatile unsigned int* uart_ctrl = (volatile unsigned int *) 0x50000000;
volatile unsigned int* uart_bauddiv = (volatile unsigned int *) 0x50000004;
volatile unsigned int* uart_status = (volatile unsigned int *) 0x50000008;
volatile unsigned int* uart_data = (volatile unsigned int *) 0x5000000C;

void delay(unsigned int milliseconds) {
    *LOAD_VALUE = milliseconds* 6000; //6000 for 6MHz clock
    *TIMER_STATUS = 0x0000001;
    while ((*TIMER_STATUS & 0x100) == 0) {

    }
}
void uart_init(int bauddiv){
    *uart_bauddiv = bauddiv;
    *uart_ctrl = 1;
}

void uart_putc(char c){
    while(*uart_status == 0);
    *uart_data = c;
    *uart_ctrl |= 2;
}

void uart_puts(char *s){
    for(int i=0; s[i]; i++)
        uart_putc(s[i]);
}

// void exit(){
//     *gpio_data = 0xF00FE00E;
// }

int main(){     
    
    *gpio_oe_A = 0xFFFFFFFF;  // configure the GPIO as an output
    unsigned int data_A = 0xFFFF;    
    uart_init(625);
    while(1)
    {
        
    *gpio_data_A = data_A;
    data_A = (data_A +1)% 7;
    delay(1000);
    if((data_A & 0x7) == 0b001)
    uart_puts("I'm red!\n");
    else if((data_A & 0x7) == 0b010)
    uart_puts("I'm blue!\n");
    else if((data_A & 0x7) == 0b011)
    uart_puts("I'm purple!\n");
    else if((data_A & 0x7) == 0b100)
    uart_puts("I'm green!\n");
    else if((data_A & 0x7) == 0b101)
    uart_puts("I'm yellow!\n");
    else if((data_A & 0x7) == 0b110)
    uart_puts("I'm aqua!\n");
    else if((data_A & 0x7) == 0b000)
    uart_puts("I'm black:(\n");
    else if((data_A & 0x7)== 0b111)
    uart_puts("I'm white!\n");
    }
    return 0;
}